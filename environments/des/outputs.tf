# output "instance_connection_name" {
#   description = "Nombre de conexión (<PROJECT>:<REGION>:<INSTANCE>)"
#   value       = module.cloudsql_postgres.instance_connection_name
# }

# output "public_ip_address" {
#   description = "Dirección IP pública de la instancia (si fue habilitada)"
#   value       = module.cloudsql_postgres.public_ip_address
# }

# output "database_name" {
#   description = "Nombre de la base de datos creada"
#   value       = module.cloudsql_postgres.database_name
# }

# output "user_name" {
#   description = "Usuario de aplicación"
#   value       = module.cloudsql_postgres.user_name
# }

# output "user_password" {
#   description = "Contraseña generada para el usuario (sensible)"
#   value       = module.cloudsql_postgres.user_password
#   sensitive   = true
# }

output "gke_cluster_name" {
  description = "Nombre del clúster GKE"
  value       = module.gke.cluster_name
}

output "gke_endpoint" {
  description = "Endpoint del clúster GKE"
  value       = module.gke.endpoint
}

# output "gcs_bucket_name" {
#   description = "Nombre del bucket de Cloud Storage"
#   value       = module.cloud_storage.bucket_name
# }

# output "gcs_bucket_url" {
#   description = "URL del bucket de Cloud Storage"
#   value       = module.cloud_storage.bucket_url
# }
