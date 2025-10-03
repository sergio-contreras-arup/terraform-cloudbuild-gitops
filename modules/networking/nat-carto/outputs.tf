output "router_id" {
  description = "ID del Cloud Router creado"
  value       = google_compute_router.cloud_router.id
}
 
output "router_name" {
  description = "Nombre del Cloud Router creado"
  value       = google_compute_router.cloud_router.name
}
 
output "nat_id" {
  description = "ID del Cloud NAT creado"
  value       = google_compute_router_nat.cloud_nat.id
}
 
output "nat_name" {
  description = "Nombre del Cloud NAT creado"
  value       = google_compute_router_nat.cloud_nat.name
}   