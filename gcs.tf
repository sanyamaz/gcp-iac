resource "google_storage_bucket" "cf_bucket" {
  name          = "cf-bucket-wert"
  project       = var.project
  location      = var.region
  force_destroy = true

  versioning {
    enabled = true
  }
}

