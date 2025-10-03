output "instance_connection_name" {
  description = "Nombre de conexión (<PROJECT>:<REGION>:<INSTANCE>)"
  value       = google_sql_database_instance.postgres_carto.master_instance_name
}

output "public_ip_address" {
  description = "Dirección IP pública de la instancia (si fue habilitada)"
  value       = try([for ip in google_sql_database_instance.postgres_carto.ip_address : ip.ip_address if ip.type == "PRIMARY"][0], null)
}

output "database_name" {
  description = "Nombre de la base de datos creada"
  value       = google_sql_database.app_db_carto.name
}

output "user_name" {
  description = "Usuario de aplicación"
  value       = google_sql_user.app_user_carto.name
}

output "user_password" {
  description = "Contraseña generada para el usuario (sensible)"
  value       = random_password.app_user_pwd_carto.result
  sensitive   = true
}


