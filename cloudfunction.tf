resource "random_id" "bucket_prefix" {
  byte_length = 4
}

resource "google_storage_bucket" "cloudfunc_bucket" {
  name                        = "gcf-${random_id.bucket_prefix.hex}"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "nodejs_code" {
  name   = "function-nodejs.zip"
  bucket = google_storage_bucket.cloudfunc_bucket.name
  source = "function-nodejs.zip"
}

resource "google_cloudfunctions2_function" "nodejs_cf" {
  name        = "nodejs-cf"
  location    = var.region
  description = "test node js function"

  build_config {
    runtime     = "nodejs16"
    entry_point = "helloHttp"
    source {
      storage_source {
        bucket = google_storage_bucket.cloudfunc_bucket.name
        object = google_storage_bucket_object.nodejs_code.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }
}
