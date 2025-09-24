output "bucket_name" {
  description = "Nombre del bucket creado"
  value       = google_storage_bucket.this.name
}

output "bucket_url" {
  description = "URL del bucket"
  value       = "gs://${google_storage_bucket.this.name}"
}


