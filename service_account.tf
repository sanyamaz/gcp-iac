locals {
  cf_service_accounts = {
    "cf-nodejs" = { iam_role = toset(["roles/cloudfunctions.developer", "roles/cloudfunctions.invoker"]) },
    "cf-python" = { iam_role = toset(["roles/cloudfunctions.developer", "roles/cloudfunctions.invoker"]) },
  }
  gke_service_acc = {
    "gke-sa" = { iam_role = toset(["roles/container.admin", "roles/iam.serviceAccountUser"]) },
  }
}

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

module "cf_service_accounts" {
  source   = "./modules/service_account"
  for_each = local.cf_service_accounts

  sa_name  = each.key
  iam_role = each.value.iam_role
  project  = var.project
}

module "gke_sa" {
  source   = "./modules/service_account"
  for_each = local.gke_service_acc

  sa_name  = each.key
  iam_role = each.value.iam_role
  project  = var.project
}
