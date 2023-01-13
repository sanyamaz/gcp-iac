resource "google_service_account" "tf_admin_sa" {
  account_id   = "tf-admin"
  display_name = "tf-admin"
  project      = var.project
}

resource "google_project_iam_binding" "owner" {
  project = var.project
  role    = "roles/owner"
  members = [
    "serviceAccount:${google_service_account.tf_admin_sa.email}",
    "user:sanyamazdop@gmail.com"
  ]
}
