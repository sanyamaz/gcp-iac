resource "google_service_account" "tf_admin_sa" {
  account_id   = "tf-admin"
  display_name = "tf-admin"
  project      = var.project
}

resource "google_project_iam_binding" "owner" {
  project = var.project
  role    = "roles/owner"
  members = [
    "user:sanyamazdop@gmail.com",
    "serviceAccount:${google_service_account.tf_admin_sa.email}",
  ]
}

module "cf_service_acc" {
  source   = "./modules/service_account"
  for_each = var.cf_service_account_name

  service_account_name = each.value
  iam_role             = var.cf_iam_role
  project              = var.project
}

variable "cf_service_account_name" {
  type = set(any)
  default = [
    "cf-nodejs",
    "cf-python"
  ]
}

variable "cf_iam_role" {
  description = "IAM roles for cloudfunction"
  type        = set(any)
  default     = ["roles/cloudfunctions.developer", "roles/cloudfunctions.invoker"]
}
