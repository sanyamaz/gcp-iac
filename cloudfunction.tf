resource "google_storage_bucket" "cloudfunc_bucket" {
  name                        = "gcf-bucket-wert"
  location                    = "US"
  uniform_bucket_level_access = true
}

data "archive_file" "nodejs_code" {
  type = "zip"
  source_dir = "./nodejs-cf"
  output_path = "./nodejs-cf.zip"
}

resource "google_storage_bucket_object" "cf_nodejs_source_archive" {
  name   = "${data.archive_file.nodejs_code.output_md5}.zip"
  bucket = google_storage_bucket.cloudfunc_bucket.name
  source = data.archive_file.nodejs_code.output_path
}

//// nodejs cf

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
        object = google_storage_bucket_object.cf_nodejs_source_archive.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }
}

//// python cf

data "archive_file" "python_code" {
  type = "zip"
  source_dir = "./python-cf"
  output_path = "./python-cf.zip"
}

resource "google_storage_bucket_object" "cf_python_source_archive" {
  name   = "${data.archive_file.python_code.output_md5}.zip"
  bucket = google_storage_bucket.cloudfunc_bucket.name
  source = data.archive_file.python_code.output_path
}

resource "google_cloudfunctions2_function" "python_cf" {
  name        = "python-cf"
  location    = var.region
  description = "test python function"

  build_config {
    runtime     = "python310"
    entry_point = "hello_get"
    source {
      storage_source {
        bucket = google_storage_bucket.cloudfunc_bucket.name
        object = google_storage_bucket_object.cf_python_source_archive.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
  }
}

