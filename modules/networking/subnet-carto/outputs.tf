output "subnet_id" {
  description = "ID de la subred"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_self_link" {
  description = "Self link de la subred"
  value       = google_compute_subnetwork.subnet.self_link
}

output "subnet_name" {
  description = "Nombre de la subred"
  value       = google_compute_subnetwork.subnet.name
}

output "subnet_region" {
  description = "Región de la subred"
  value       = google_compute_subnetwork.subnet.region
}
