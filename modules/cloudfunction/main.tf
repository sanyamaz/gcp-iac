resource "google_service_account" "sa" {
  project      = var.project
  account_id   = "${var.sa_name}-sa"
  display_name = "${var.sa_name}-sa"
}

resource "google_project_iam_member" "iam_binding" {
  for_each = toset(var.cf_iam_roles)

  project  = var.project
  role     = each.key
  member   = "${var.sa_type}:${google_service_account.sa.email}"
}

data "archive_file" "source_code" {
  type        = "zip"
  source_dir  = var.source_code
  output_path = "${var.source_code}.zip"
}

resource "google_storage_bucket_object" "cf_source_code_archive" {
  name   = "${data.archive_file.source_code.output_md5}.zip"
  bucket = var.cf_bucket_name
  source = data.archive_file.source_code.output_path
}

resource "google_cloudfunctions2_function" "cloud_function" {
  name        = var.cf_name
  location    = var.region
  description = "${var.cf_name}-function"

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.cf_bucket_name
        object = google_storage_bucket_object.cf_source_code_archive.name
      }
    }
  }

  service_config {
    max_instance_count    = 1
    available_memory      = "256M"
    timeout_seconds       = 60
    service_account_email = google_service_account.sa.email
  }
}
