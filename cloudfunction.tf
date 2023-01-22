locals {
  cloudfunctions = {
    "cf-nodejs" = {
      runtime            = "nodejs16",
      entry_point        = "helloHttp",
      max_instance_count = "1",
      available_memory   = "256M",
      timeout_seconds    = "60",
      service_acc        = module.cf_service_accounts["cf-nodejs"].sa_email,
    },
    "cf-python" = {
      runtime            = "python310",
      entry_point        = "hello_get",
      max_instance_count = "1",
      available_memory   = "256M",
      timeout_seconds    = "60",
      service_acc        = module.cf_service_accounts["cf-python"].sa_email,
    },
  }
}

module "cloudfunction" {
  source   = "./modules/cloudfunction"
  for_each = local.cloudfunctions

  project            = var.project
  region             = var.region
  sa_email           = each.value.service_acc
  source_code        = each.key
  cf_bucket_name     = "gcf-bucket-wert"
  cf_name            = each.key
  runtime            = each.value.runtime
  entry_point        = each.value.entry_point
  available_memory   = each.value.available_memory
  max_instance_count = each.value.max_instance_count
  timeout_seconds    = each.value.timeout_seconds
}
