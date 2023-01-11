provider "google" {
  #credentials = file("tf-admin-evl-dev.json")                      // export GCLOUD_KEYFILE_JSON="tf-admin-evl-dev.json"
  project = var.project
  region = var.region
}

module "apis" {
  source     = "./modules/enable_api"
  project = var.project
  app_cloud_services = [
    "storage.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
  ]
}