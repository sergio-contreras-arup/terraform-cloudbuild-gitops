output "psc_endpoint_ip" {
  description = "IP interna del endpoint PSC (usar para conectar desde GKE)"
  value       = google_compute_address.psc_endpoint_ip.address
}

output "psc_endpoint_id" {
  description = "ID del forwarding rule PSC"
  value       = google_compute_forwarding_rule.psc_endpoint.id
}

output "psc_endpoint_name" {
  description = "Nombre del endpoint PSC"
  value       = google_compute_forwarding_rule.psc_endpoint.name
}

