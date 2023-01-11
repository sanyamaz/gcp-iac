resource "google_project_service" "app_cloud_services" {
  for_each                   = toset(var.app_cloud_services)
  project                    = var.project
  service                    = each.value
  disable_on_destroy         = var.enable
}

variable "project" {
  description = "Project ID to enable services"
}

variable "enable" {
  description = "Actually disabled the APIs listed"
  default     = false
}

variable "app_cloud_services" {
  description = "List of API to enable for projects"
  type = list(string)
}