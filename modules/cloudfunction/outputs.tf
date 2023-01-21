output "cf_uri" {
  value = google_cloudfunctions2_function.this.service_config[*].uri
}
