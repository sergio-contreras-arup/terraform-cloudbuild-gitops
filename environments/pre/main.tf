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

# Networking resources for GKE
module "vpc_carto" {
  source = "../../modules/networking/vpc-carto"

  project_id                      = var.project_id
  vpc_name                        = "gke-vpc"
  auto_create_subnetworks         = false
  enable_private_service_connection = true # Required for CloudSQL private networking
  labels = {
    env      = var.environment
    resource = "vpc-carto"
  }
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
  
  labels = {
    env      = var.environment
    resource = "cloud-nat-carto"
  }
}

# GKE Cluster
module "gke" {
  source = "../../modules/gke-cluster/gke-carto"

  project_id      = var.project_id
  location        = var.gke_location
  cluster_name    = var.gke_cluster_name
  release_channel = var.gke_release_channel
  network         = module.vpc_carto.vpc_self_link
  subnetwork      = module.subnet_carto.subnet_self_link
  resource_labels = {
    env      = var.environment
    resource = "gke-carto"
  }
}

# module "cloud_storage" {
#   source = "../../modules/cloud_storage"

#   project_id                     = var.project_id
#   bucket_name                    = var.gcs_bucket_name
#   location                       = var.gcs_location
#   storage_class                  = var.gcs_storage_class
#   uniform_bucket_level_access    = true
#   versioning                     = true
#   labels                         = { env = "pre" }
# }


