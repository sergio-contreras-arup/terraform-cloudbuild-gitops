output "bucket_name" {
  description = "Nombre del bucket de GCS"
  value       = google_storage_bucket.static_site_bucket.name
}
