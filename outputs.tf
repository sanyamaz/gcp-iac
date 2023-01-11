output "node_function_uri" {
  value = google_cloudfunctions2_function.nodejs_cf.service_config[0].uri
}

output "python_function_uri" {
  value = google_cloudfunctions2_function.python_cf.service_config[0].uri
}