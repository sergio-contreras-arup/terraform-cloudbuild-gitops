output "vpc_id" {
  description = "ID del VPC creado"
  value       = google_compute_network.vpc.id
}

output "vpc_link" {
  description = "Self link del VPC creado"
  value       = google_compute_network.vpc.self_link

}
