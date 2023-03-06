resource "google_service_account" "tf_admin_sa" {
  account_id   = "tf-admin"
  display_name = "tf-admin"
  project      = var.project
}