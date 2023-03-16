variable "project" {
  type    = string
  default = "evl-dev"
}

variable "region" {
  type    = string
  default = "us-east1"
}
variable "zone" {
  type = string
  default = "us-east1-a"
}

variable "app_cloud_services" {
  description = "List of API to enable for projects"
  type        = set(string)
  default = [
    "storage.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "containerregistry.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}
