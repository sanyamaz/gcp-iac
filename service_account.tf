resource "google_service_account" "tf_admin_sa" {
  account_id   = "tf-admin"
  display_name = "tf-admin"
  project      = var.project
}

resource "google_service_account" "gke_sa" {
  account_id   = "gke-sa"
  display_name = "gke-sa"
  project      = var.project
}
