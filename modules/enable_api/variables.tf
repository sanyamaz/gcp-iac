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

