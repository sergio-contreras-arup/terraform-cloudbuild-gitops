# CloudSQL Outputs - Private Service Connect (PSC)
output "cloudsql_instance_connection_name" {
  description = "Connection name para Cloud SQL Proxy"
  value       = module.cloudsql_postgres_carto.instance_connection_name
}

output "cloudsql_dns_name" {
  description = "DNS name de CloudSQL (usar para conexión)"
  value       = module.cloudsql_postgres_carto.dns_name
}

output "cloudsql_psc_endpoint_ip" {
  description = "IP del PSC endpoint (usar desde GKE para conectar a CloudSQL)"
  value       = module.psc_endpoint_cloudsql.psc_endpoint_ip
}

output "cloudsql_psc_service_attachment" {
  description = "Service Attachment link de CloudSQL"
  value       = module.cloudsql_postgres_carto.psc_service_attachment_link
}

output "cloudsql_database_name" {
  description = "Nombre de la base de datos"
  value       = module.cloudsql_postgres_carto.database_name
}

output "cloudsql_user_name" {
  description = "Usuario de la base de datos"
  value       = module.cloudsql_postgres_carto.user_name
}

output "cloudsql_user_password" {
  description = "Contraseña del usuario (IMPORTANTE: Guardar en lugar seguro, NO se almacena en Secret Manager)"
  value       = module.cloudsql_postgres_carto.user_password
  sensitive   = true
}

output "cloudsql_connection_string" {
  description = "String de conexión (sin contraseña) - Usar cloudsql_psc_endpoint_ip como host"
  value       = "postgresql://${module.cloudsql_postgres_carto.user_name}@${module.psc_endpoint_cloudsql.psc_endpoint_ip}:5432/${module.cloudsql_postgres_carto.database_name}?sslmode=require"
}

# GKE Outputs
# output "gke_cluster_name" {
#   description = "Nombre del clúster GKE"
#   value       = module.gke.cluster_name
# }

# output "gke_endpoint" {
#   description = "Endpoint del clúster GKE"
#   value       = module.gke.endpoint
# }

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
