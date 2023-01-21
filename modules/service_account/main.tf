resource "google_service_account" "this" {
  project      = var.project
  account_id   = "${var.service_account_name}-sa"
  display_name = "${var.service_account_name}-sa"
}

resource "google_project_iam_member" "this" {
  for_each = var.iam_role

  project  = var.project
  role     = each.key
  member   = "${var.sa_type}:${google_service_account.this.email}"
}

variable "service_account_name" {}
variable "project" {}
variable "iam_role" {}
variable "sa_type" {
  default = "serviceAccount"
}

output "sa_email" {
  value = google_service_account.this[*].email
}
