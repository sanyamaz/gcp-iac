locals {
  cloudfunctions = {
    "cf-nodejs" = { runtime = "nodejs16", entry_point = "helloHttp" },
    "cf-python" = { runtime = "python310", entry_point = "hello_get" },
  }
}

module "cloudfunction" {
  source   = "./modules/cloudfunction"
  for_each = local.cloudfunctions

  project        = var.project
  region         = var.region
  sa_name        = each.key
  cf_iam_roles   = var.cf_iam_roles
  source_code    = each.key
  cf_bucket_name = var.cf_bucket_name
  cf_name        = each.key
  runtime        = each.value.runtime
  entry_point    = each.value.entry_point
}
