resource "google_project" "gcp_project" {
  name            = "evl-dev"
  project_id      = "evl-dev"
  billing_account = "017434-7C2AB2-62916C"
}

resource "google_project_service" "app_cloud_services" {
  for_each           = toset(var.app_cloud_services)
  project            = var.project
  service            = each.value
  disable_on_destroy = var.api_enable
}
