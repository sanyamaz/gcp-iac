resource "google_project_service" "app_cloud_services" {
  for_each                   = toset(var.app_cloud_services)
  project                    = var.project
  service                    = each.value
  disable_on_destroy         = var.api_enable
}
