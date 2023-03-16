resource "google_service_account" "this" {
  project      = var.project
  account_id   = var.sa_name
  display_name = var.sa_name
}

resource "google_project_iam_member" "this" {
  for_each = var.iam_role

  project  = var.project
  role     = each.key
  member   = "${var.sa_type}:${google_service_account.this.email}"
}
