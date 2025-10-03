output "bucket_name" {
  description = "Nombre del bucket de GCS"
  value       = google_storage_bucket.storage_carto.name
}
