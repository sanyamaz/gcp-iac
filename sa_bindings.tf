locals {
  cf_sa   = {for k, v in module.cloudfunction : replace(k, "-", "_") => v.sa_email}
  cf_name = {for k, v in module.cloudfunction : replace(k, "-", "_") => v.cf_name}
}

variable "cf_iam_binding" {
  type = set(string)
  default = [
    "roles/cloudfunctions.developer",
    "roles/cloudfunctions.invoker",
  ]
}

resource "google_cloudfunctions_function_iam_binding" "cf_iam_binding" {
  for_each = local.cf_sa

  project = var.project
  region = var.region
  cloud_function = local.cf_name[each.key]
  role = [for v in var.cf_iam_binding : tostring(v)]
  members = [
    "serviceAccount:${each.value}",
  ]
}














resource "google_project_iam_binding" "owner" {
  project = var.project
  role    = "roles/owner"
  members = [
    "user:sanyamazdop@gmail.com",
    "serviceAccount:${google_service_account.tf_admin_sa.email}",
  ]
}
