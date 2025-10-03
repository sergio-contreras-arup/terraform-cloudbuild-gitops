output "vpc_id" {
  description = "ID del VPC creado"
  value       = google_compute_network.vpc_carto.id
}

output "vpc_link" {
  description = "Self link del VPC creado"
  value       = google_compute_network.vpc_carto.self_link

}
