output "instance_name" {
  description = "Nombre de la instancia de Cloud SQL"
  value       = google_sql_database_instance.postgres.name
}

output "instance_connection_name" {
  description = "Connection name para Cloud SQL Proxy"
  value       = google_sql_database_instance.postgres.connection_name
}

output "instance_self_link" {
  description = "Self link de la instancia"
  value       = google_sql_database_instance.postgres.self_link
}

output "instance_ip_address" {
  description = "Dirección IP de la instancia (puede ser pública o null si solo usa PSC)"
  value       = length(google_sql_database_instance.postgres.ip_address) > 0 ? google_sql_database_instance.postgres.ip_address[0].ip_address : null
}

output "psc_service_attachment_link" {
  description = "Service Attachment link para Private Service Connect"
  value       = try(google_sql_database_instance.postgres.psc_service_attachment_link, null)
}

output "dns_name" {
  description = "DNS name de la instancia CloudSQL"
  value       = google_sql_database_instance.postgres.dns_name
}

output "database_name" {
  description = "Nombre de la base de datos"
  value       = google_sql_database.database.name
}

output "user_name" {
  description = "Nombre del usuario de la base de datos"
  value       = google_sql_user.user.name
}

output "user_password" {
  description = "Contraseña del usuario (IMPORTANTE: Guardar de forma segura, no se almacena en Secret Manager)"
  value       = google_sql_user.user.password
  sensitive   = true
}

output "connection_string" {
  description = "String de conexión para la base de datos (sin contraseña)"
  value       = "postgresql://${google_sql_user.user.name}@${google_sql_database_instance.postgres.dns_name}/${google_sql_database.database.name}"
}

