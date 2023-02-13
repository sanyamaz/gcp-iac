output "cf_uri" {
  value = google_cloudfunctions2_function.this.service_config[*].uri
}

output "sa_email" {
  value = google_service_account.this.email
}