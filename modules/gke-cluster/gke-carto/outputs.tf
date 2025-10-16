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

output "node_pool_name" {
  description = "Nombre del node pool principal"
  value       = google_container_node_pool.primary_nodes.name
}

output "node_pool_instance_group_urls" {
  description = "URLs de los instance groups del node pool"
  value       = google_container_node_pool.primary_nodes.instance_group_urls
}

output "cluster_ca_certificate" {
  description = "Certificado CA del clúster (base64 encoded)"
  value       = google_container_cluster.this.master_auth[0].cluster_ca_certificate
  sensitive   = true
}