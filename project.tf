resource "google_project" "gcp_project" {
  name            = "evl-dev"
  project_id      = "evl-dev"
  billing_account = "017434-7C2AB2-62916C"
}

resource "google_project_service" "app_cloud_services" {
  for_each = var.app_cloud_services

  project = var.project
  service = each.value
}
