output "cluster_name" {
  description = "Nombre del clúster"
  value       = google_container_cluster.this.name
}

output "endpoint" {
  description = "Endpoint del clúster"
  value       = google_container_cluster.this.endpoint
}

output "location" {
  description = "Ubicación del clúster"
  value       = google_container_cluster.this.location
}


