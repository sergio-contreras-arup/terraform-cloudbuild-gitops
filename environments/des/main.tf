terraform {
  backend "gcs" {
    bucket = "madrid-pgoum-terraform-des"
    prefix = "state"
  }
}

module "artifact_registry_pgoum" {
  source = "../../modules/artifact-registry/artifact-registry-pgoum"

  region                 = var.region
  repository_name        = var.artifact_repository_name_pgoum
  repository_description = var.artifact_repository_description_pgoum
  repository_format      = var.artifact_repository_format_pgoum
}

module "apis" {
  source = "../../modules/project"
  apis   = var.apis
}

########## Carto ##########
# Networking resources for GKE
module "vpc_carto" {
  source = "../../modules/networking/vpc-carto"

  project_id                      = var.project_id
  vpc_name                        = "gke-vpc"
  auto_create_subnetworks         = false
  enable_private_service_connection = true # Required for CloudSQL private networking
}

module "subnet_carto" {
  source = "../../modules/networking/subnet-carto"

  project_id     = var.project_id
  subnet_name    = "gke-subnet-eu-west1"
  ip_cidr_range  = "10.0.0.0/20"
  region         = var.gke_location
  network_id     = module.vpc_carto.vpc_id

  secondary_ip_ranges = [
    {
      range_name    = "pods-range"
      ip_cidr_range = "10.4.0.0/14"
    },
    {
      range_name    = "services-range"
      ip_cidr_range = "10.0.32.0/20"
    }
  ]
}

module "cloud_nat_carto" {
  source = "../../modules/networking/cloud-nat-carto"

  project_id                         = var.project_id
  router_name                        = "gke-nat-router"
  nat_name                           = "gke-nat"
  region                             = var.gke_location
  network_id                         = module.vpc_carto.vpc_id
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetworks = [
    {
      name                    = module.subnet_carto.subnet_id
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  ]
}

# CloudSQL PostgreSQL Instance
module "cloudsql_postgres_carto" {
  source = "../../modules/cloudsql-postgres/cloudsql-postgres-carto"

  project_id       = var.project_id
  region           = var.region
  instance_name    = "carto-des-environment"
  database_version = "POSTGRES_15"
  tier             = "db-custom-1-3840" # 1 vCPU, 3.75 GB RAM (mínimo 2GB)
  disk_type        = "PD_SSD"
  disk_size        = 20
  availability_type = "ZONAL"
  
  # Database and user (using defaults: carto/carto)
  database_name = "carto"
  user_name     = "carto"
  
  # Security
  deletion_protection = false # Set to true for production
  require_ssl         = true
  ipv4_enabled        = false
  private_network     = module.vpc_carto.vpc_self_link
  
  # Backups
  backup_enabled                     = true
  point_in_time_recovery_enabled     = true
  transaction_log_retention_days     = 7
  
  # Monitoring
  query_insights_enabled = true
  
  depends_on = [module.apis, module.vpc_carto]
}

# GKE Cluster
module "gke" {
  source = "../../modules/gke-cluster/gke-carto"

  project_id       = var.project_id
  location         = var.gke_location
  cluster_name     = var.gke_cluster_name
  release_channel  = var.gke_release_channel
  network          = module.vpc_carto.vpc_self_link
  subnetwork       = module.subnet_carto.subnet_self_link
  resource_labels  = { env = "dev-carto" }
}

module "storage_bucket_carto" {
  source = "../../modules/storage-bucket/storage-bucket-carto"

  bucket_name = var.storage_bucket_bucket_name_carto
  region      = var.region

  depends_on = [module.apis]
}

########## Frontend ##########
module "storage_bucket_pgoum_frontend" {
  source = "../../modules/storage-bucket/storage-bucket-pgoum-frontend"

  bucket_name = var.storage_bucket_bucket_name__pgoum_frontend
  region      = var.region

  depends_on = [module.apis]
}
