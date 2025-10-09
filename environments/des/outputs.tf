# CloudSQL Outputs
# output "cloudsql_instance_connection_name" {
#   description = "Connection name para Cloud SQL Proxy (usar en GKE)"
#   value       = module.cloudsql_postgres_carto.instance_connection_name
# }

# output "cloudsql_instance_ip_address" {
#   description = "Dirección IP privada de CloudSQL (para conexión directa desde GKE)"
#   value       = module.cloudsql_postgres_carto.instance_ip_address
# }

# output "cloudsql_database_name" {
#   description = "Nombre de la base de datos"
#   value       = module.cloudsql_postgres_carto.database_name
# }

# output "cloudsql_user_name" {
#   description = "Usuario de la base de datos"
#   value       = module.cloudsql_postgres_carto.user_name
# }

# output "cloudsql_user_password" {
#   description = "Contraseña del usuario (sensible - almacenada en Secret Manager)"
#   value       = module.cloudsql_postgres_carto.user_password
#   sensitive   = true
# }

# output "cloudsql_secret_manager_id" {
#   description = "ID del secret en Secret Manager con la contraseña"
#   value       = module.cloudsql_postgres_carto.secret_manager_secret_id
# }

# output "cloudsql_connection_string" {
#   description = "String de conexión (sin contraseña)"
#   value       = module.cloudsql_postgres_carto.connection_string
# }

# GKE Outputs
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

# output "cloud_nat_router_name" {
#   description = "Nombre del Cloud Router para NAT"
#   value       = module.cloud_nat_carto.router_name
# }
 
# output "cloud_nat_name" {
#   description = "Nombre del Cloud NAT"
#   value       = module.cloud_nat_carto.nat_name
# }
