variable "project" {
  type    = string
  default = "evl-dev"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "api_enable" {
  description = "Actually disabled the APIs listed"
  default     = false
}

variable "app_cloud_services" {
  description = "List of API to enable for projects"
  type        = list(string)
  default = [
    "storage.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "run.googleapis.com",
    "cloudfunctions.googleapis.com",
  ]
}
