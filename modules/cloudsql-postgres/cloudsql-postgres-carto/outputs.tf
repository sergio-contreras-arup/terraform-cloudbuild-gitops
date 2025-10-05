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
  description = "Dirección IP privada de la instancia"
  value       = length(google_sql_database_instance.postgres.ip_address) > 0 ? google_sql_database_instance.postgres.ip_address[0].ip_address : null
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
  description = "Contraseña del usuario de la base de datos"
  value       = google_sql_user.user.password
  sensitive   = true
}

output "secret_manager_secret_id" {
  description = "ID del secret en Secret Manager (si está habilitado)"
  value       = var.store_password_in_secret_manager ? google_secret_manager_secret.db_password[0].secret_id : null
}

output "connection_string" {
  description = "String de conexión para la base de datos (sin contraseña)"
  value       = "postgresql://${google_sql_user.user.name}@${google_sql_database_instance.postgres.connection_name}/${google_sql_database.database.name}"
}

