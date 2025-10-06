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
module "cloudsql_postgres_carto" {
  source = "../../modules/cloudsql-postgres/cloudsql-postgres-carto"

  project_id          = var.project_id
  region              = var.region
  instance_name       = var.cloudsql_instance_name_carto
  database_version    = var.cloudsql_database_version_carto
  tier                = var.cloudsql_tier_carto
  disk_type           = var.cloudsql_disk_type_carto
  disk_size           = var.cloudsql_disk_size_carto
  availability_type   = var.cloudsql_availability_type_carto
  backup_enabled      = var.cloudsql_backup_enabled_carto
  authorized_networks = [
    {
      name    = "pods-range"
      cidr = "10.4.0.0/14"
    },
    {
      name    = "services-range"
      cidr = "10.0.32.0/20"
    }
  ]
  database_name       = var.cloudsql_database_name_carto
  user_name           = var.cloudsql_user_name_carto
  deletion_protection = var.cloudsql_deletion_protection_carto

  depends_on = [module.apis]
}

# Networking resources for GKE
module "vpc_carto" {
  source = "../../modules/networking/vpc-carto"

  project_id             = var.project_id
  vpc_name               = "gke-vpc"
  auto_create_subnetworks = false
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
