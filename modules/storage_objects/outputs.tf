output "bucket_name" {
  description = "Nombre del bucket de GCS"
  value       = google_storage_bucket.object_storage.name
}
