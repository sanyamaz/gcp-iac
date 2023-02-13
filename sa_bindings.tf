locals {
  cf_sa = { for k, v in module.cloudfunction : replace(k, "-", "_") => v.sa_email }
}

variable "cf_iam_binding" {
  type = set(string)
  default = [
    "roles/cloudfunctions.developer",
    "roles/cloudfunctions.invoker",
  ]
}
#variable "cf_iam_binding" {
#  type = string
#  default = "roles/owner"
#}

resource "google_project_iam_member" "cf_iam_binding" {
  for_each = local.cf_sa

  project = var.project
  role    = var.cf_iam_binding
  member  = "serviceAccount:${each.value}"
}

resource "google_project_iam_binding" "owner" {
  project = var.project
  role    = "roles/owner"
  members = [
    "user:sanyamazdop@gmail.com",
    "serviceAccount:${google_service_account.tf_admin_sa.email}",
  ]
}
