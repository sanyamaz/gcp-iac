terraform {
  backend "gcs" {
    bucket = "tfstate-bucket-1b922bf9"
    prefix = "terraform/state"
  }
}
// if got an error, should run "gcloud auth application-default login"