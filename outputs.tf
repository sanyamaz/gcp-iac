output "cloudf_uri" {
  value = {
    for k, v in google_cloudfunctions2_function.cloud_function : replace(k, "-", "_") => v.service_config[*].uri
  }
}