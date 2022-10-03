output "secrets" {
  description = "Map of GCP Secret Manager secrets"
  value       = google_secret_manager_secret.main
}

output "secret_list" {
  description = "List of GCP Secret Manager secrets"
  value       = [for i in google_secret_manager_secret.main : i.name]
}