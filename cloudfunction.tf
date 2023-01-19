locals {
  cloudfunctions = {
    "nodejs-cf" = { runtime = "nodejs16", entry_point = "helloHttp", sa_name = "${google_service_account.cf_sa_node.email}" },
    "python-cf" = { runtime = "python310", entry_point = "hello_get", sa_name = "${google_service_account.cf_sa_python.email}" },
  }
}

data "archive_file" "source_code" {
  for_each = local.cloudfunctions

  type        = "zip"
  source_dir  = "./${each.key}"
  output_path = "./${each.key}.zip"
}

resource "google_storage_bucket_object" "cf_source_code_archive" {
  for_each = local.cloudfunctions

  name   = "${data.archive_file.source_code[each.key].output_md5}.zip"
  bucket = var.cloudfunc_bucket
  source = data.archive_file.source_code[each.key].output_path
}

resource "google_cloudfunctions2_function" "cloud_function" {
  for_each = local.cloudfunctions

  name        = each.key
  location    = var.region
  description = "test-${each.key}-function"

  build_config {
    runtime     = each.value.runtime
    entry_point = each.value.entry_point
    source {
      storage_source {
        bucket = var.cloudfunc_bucket
        object = google_storage_bucket_object.cf_source_code_archive[each.key].name
      }
    }
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = each.value.sa_name
  }
}
