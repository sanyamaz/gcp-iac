resource "google_storage_bucket" "tf_state_bucket" {
  name     = "tfstate-bucket-1b922bf9"
  project  = var.project
  location = "US"
  force_destroy = true

  versioning {
    enabled = true
  }

}

