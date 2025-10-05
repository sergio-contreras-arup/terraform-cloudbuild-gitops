output "vpc_id" {
  description = "ID de la VPC"
  value       = google_compute_network.vpc.id
}

output "vpc_self_link" {
  description = "Self link de la VPC"
  value       = google_compute_network.vpc.self_link
}

output "vpc_name" {
  description = "Nombre de la VPC"
  value       = google_compute_network.vpc.name
}

output "private_vpc_connection_id" {
  description = "ID de la conexión VPC privada (si está habilitada)"
  value       = var.enable_private_service_connection ? google_service_networking_connection.private_vpc_connection[0].id : null
}
