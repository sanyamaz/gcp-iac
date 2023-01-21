locals {
  cloudfunctions = {
    "cf-nodejs" = { runtime = "nodejs16", entry_point = "helloHttp" },
    "cf-python" = { runtime = "python310", entry_point = "hello_get" },
  }
}
#
#module "cloudfunction" {
#  source   = "./modules/cloudfunction"
#  for_each = local.cloudfunctions
#
#  project        = var.project
#  region         = var.region
#  sa_email        = module.cf_service_acc.*.sa_email
#  source_code    = each.key
#  cf_bucket_name = "gcf-bucket-wert"
#  cf_name        = each.key
#  runtime        = each.value.runtime
#  entry_point    = each.value.entry_point
#}
