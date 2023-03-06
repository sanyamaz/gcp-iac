locals {
  cf_sa   = { for k, v in module.cloudfunction : replace(k, "-", "_") => v.sa_email }
  cf_name = { for k, v in module.cloudfunction : replace(k, "-", "_") => v.cf_name }
}

resource "google_cloudfunctions2_function_iam_member" "iam_cf_invoker" {
  for_each = local.cf_sa

  project        = var.project
  location       = var.region
  cloud_function = local.cf_name[each.key]
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${each.value}"
}

resource "google_project_iam_binding" "owner" {
  project = var.project
  role    = "roles/owner"
  members = [
    "user:sanyamazdop@gmail.com",
    "serviceAccount:${google_service_account.tf_admin_sa.email}",
  ]
}
