output "cloudf_uri" {
  value = { for k, v in module.cloudfunction : replace(k, "-", "_") => v.cf_uri }
}

output "service_acc_email" {
  value = { for k, v in module.cloudfunction : replace(k, "-", "_") => v.sa_email }
}

output "cloudf_name" {
  value = { for k, v in module.cloudfunction : replace(k, "-", "_") => v.cf_name }
}
