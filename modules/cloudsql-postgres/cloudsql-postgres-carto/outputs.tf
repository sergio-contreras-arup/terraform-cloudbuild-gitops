output "instance_connection_name" {
  description = "Nombre de conexión (<PROJECT>:<REGION>:<INSTANCE>)"
  value       = google_sql_database_instance.postgres.connection_name
}

output "public_ip_address" {
  description = "Dirección IP pública de la instancia (si fue habilitada)"
  value       = try([for ip in google_sql_database_instance.postgres.ip_address : ip.ip_address if ip.type == "PRIMARY"][0], null)
}

output "database_name" {
  description = "Nombre de la base de datos creada"
  value       = google_sql_database.app_db.name
}

output "user_name" {
  description = "Usuario de aplicación"
  value       = google_sql_user.app_user.name
}

output "user_password" {
  description = "Contraseña generada para el usuario (sensible)"
  value       = random_password.app_user_pwd.result
  sensitive   = true
}


