data "archive_file" "this" {
  type        = "zip"
  source_dir  = var.source_code
  output_path = "${var.source_code}.zip"
}

resource "google_storage_bucket_object" "this" {
  name   = "${data.archive_file.this.output_md5}.zip"
  bucket = var.cf_bucket_name
  source = data.archive_file.this.output_path
}

resource "google_cloudfunctions2_function" "this" {
  name        = var.cf_name
  location    = var.region
  description = "${var.cf_name}-function"

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.cf_bucket_name
        object = google_storage_bucket_object.this.name
      }
    }
  }

  service_config {
    max_instance_count    = var.max_instance_count
    available_memory      = var.available_memory
    timeout_seconds       = var.timeout_seconds
    service_account_email = google_service_account.this.email
  }
}

resource "google_service_account" "this" {
  project      = var.project
  account_id   = var.sa_name
  display_name = var.sa_name
}
