variable "project" {
  type    = string
  default = "evl-dev"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}

variable "app_cloud_services" {
  description = "List of API to enable for projects"
  type        = set(string)
  default = [
    "storage.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "compute.googleapis.com",
  ]
}


