output "cf_uri" {
  value = google_cloudfunctions2_function.cloud_function.service_config[*].uri
}
