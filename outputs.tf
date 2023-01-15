output "cloudf_uri" {
  value = toset([for k, v in google_cloudfunctions2_function.cloud_function : v.service_config])
}