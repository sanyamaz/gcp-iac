resource "google_service_account" "tf_admin_sa" {
  account_id   = "tf-admin"
  display_name = "tf-admin"
  project      = var.project
}

resource "google_service_account" "cloudfunction_sa" {
  account_id   = "cloudfunction-sa-${var.project}"
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

resource "google_project_iam_binding" "cloudfunctions_admin" {
  project = var.project
  role    = "roles/cloudfunctions.admin"
  members = [
    "serviceAccount:${google_service_account.cloudfunction_sa.email}",
  ]
}
