output "cloudf_uri" {
  value = {
    for k, v in module.cloudfunction : replace(k, "-", "_") => v.cf_uri
  }
}
