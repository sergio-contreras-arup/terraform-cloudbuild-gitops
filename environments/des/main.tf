terraform {
  backend "gcs" {
    bucket = "madrid-pgoum-terraform"
    prefix = "state"
  }
}

# module "artifact_registry_pgoum" {
#   source = "../../modules/artifact-registry/artifact-registry-pgoum"

#   region                 = var.region
#   repository_name        = var.artifact_repository_name_pgoum
#   repository_description = var.artifact_repository_description_pgoum
#   repository_format      = var.artifact_repository_format_pgoum
# }

module "apis" {
  source = "../../modules/project"
  apis   = var.apis
}

########## Carto ##########
# module "cloudsql_postgres_carto" {
#   source = "../../modules/cloudsql-postgres/cloudsql-postgres-carto"

#   project_id          = var.project_id
#   region              = var.region
#   instance_name       = var.cloudsql_instance_name_carto
#   database_version    = var.cloudsql_database_version_carto
#   tier                = var.cloudsql_tier_carto
#   disk_type           = var.cloudsql_disk_type_carto
#   disk_size           = var.cloudsql_disk_size_carto
#   availability_type   = var.cloudsql_availability_type_carto
#   backup_enabled      = var.cloudsql_backup_enabled_carto
#   authorized_networks = var.cloudsql_authorized_networks_carto
#   database_name       = var.cloudsql_database_name_carto
#   user_name           = var.cloudsql_user_name_carto
#   deletion_protection = var.cloudsql_deletion_protection_carto
# }

# module "vpc_carto" {
#   source = "../../modules/networking/vpc-carto"

#   vpc_name = var.vpc_name_carto
# }

# module "subnet_carto" {
#   source = "../../modules/networking/subnet-carto"

#   subnet_name          = var.subnet_name_carto
#   vpc_id               = module.vpc_carto.vpc_id
#   subnet_ip_cidr_range = var.subnet_ip_cidr_range_carto
# }

# module "gke_carto" {
#   source = "../../modules/gke-cluster/gke-carto"

#   location        = var.gke_location_carto
#   cluster_name    = var.gke_cluster_name_carto
#   release_channel = var.gke_release_channel_carto
#   vpc_link        = module.vpc_carto.vpc_link
#   subnet_link     = module.subnet_carto.subnet_link
# }

# module "storage_bucket_carto" {
#   source = "../../modules/storage-bucket/storage-bucket-carto"

#   bucket_name = var.storage_bucket_bucket_name_carto
#   region      = var.region
# }

########## Frontend ##########
module "storage_bucket_pgoum_frontend" {
  source = "../../modules/storage-bucket/storage-bucket-pgoum-frontend"

  bucket_name = var.storage_bucket_bucket_name__pgoum_frontend
  region      = var.region
}
