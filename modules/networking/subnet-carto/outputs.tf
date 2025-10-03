output "subnet_id" {
  description = "ID de la subred creada"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_link" {
  description = "Self link de la subred creada"
  value       = google_compute_subnetwork.subnet.self_link
}
