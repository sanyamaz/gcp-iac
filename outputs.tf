output "function_uri" {
  value = google_cloudfunctions2_function.nodejs_cf.service_config[0].uri
}