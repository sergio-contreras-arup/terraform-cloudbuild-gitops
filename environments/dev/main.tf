terraform {
  backend "gcs" {
    bucket = "pgoum-des-terraform-state"
    prefix = "terraform/state"
  }
}

########## Base ##########
# module "artifact_registry" {
#   source = "../../modules/artifact_registry"

#   region                 = var.region
#   repository_name        = var.artifact_repository_name
#   repository_description = var.artifact_repository_description
#   repository_format      = var.artifact_repository_format
# }

module "project" {
  source = "../../modules/project"
  apis   = var.apis
}

########## Carto ##########
# module "cloudsql_postgres" {
#   source = "../../modules/cloudsql_postgres"

#   project_id          = var.project_id
#   region              = var.region
#   instance_name       = var.instance_name
#   database_version    = var.database_version
#   tier                = var.tier
#   disk_type           = var.disk_type
#   disk_size           = var.disk_size
#   availability_type   = var.availability_type
#   backup_enabled      = var.backup_enabled
#   authorized_networks = var.authorized_networks
#   database_name       = var.database_name
#   user_name           = var.user_name
#   deletion_protection = var.deletion_protection
# }

# module "carto_vpc" {
#   source = "../../modules/vpc"

#   vpc_name = var.carto_vpc_name
# }

# module "carto_subnet" {
#   source = "../../modules/subnet"

#   subnet_name          = var.carto_subnet_name
#   subnet_ip_cidr_range = var.carto_subnet_ip_cidr_range
#   vpc_id               = module.vpc_carto.vpc_id
#   secondary_ip_ranges  = var.carto_secondary_ip_ranges
# }

# module "carto_gke_cluster" {
#   source = "../../modules/gke"

#   cluster_name = var.carto_gke_cluster_name
#   location     = var.region
#   vpc_link     = module.vpc_carto.vpc_id
#   subnet_link  = module.subnet_carto.subnet_id
# }

# module "carto_object_storage" {
#   source = "../../modules/storage_objects"

#   bucket_name = var.carto_object_storage_name
#   region      = var.region
# }

########## Frontend ##########
module "static_site" {
  source = "../../modules/storage_static_site"

  bucket_name = var.frontend_storage_static_name
  region      = var.region
}

########## Backend ##########
