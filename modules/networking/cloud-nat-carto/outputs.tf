output "router_id" {
  description = "ID del Cloud Router"
  value       = google_compute_router.nat_router.id
}

output "router_name" {
  description = "Nombre del Cloud Router"
  value       = google_compute_router.nat_router.name
}

output "nat_id" {
  description = "ID del Cloud NAT"
  value       = google_compute_router_nat.nat.id
}

output "nat_name" {
  description = "Nombre del Cloud NAT"
  value       = google_compute_router_nat.nat.name
}
