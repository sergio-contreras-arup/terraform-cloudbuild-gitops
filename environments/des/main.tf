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

# module "gke" {
#   source = "../../modules/gke"

#   project_id       = var.project_id
#   location         = var.gke_location
#   cluster_name     = var.gke_cluster_name
#   release_channel  = var.gke_release_channel
#   network          = null
#   subnetwork       = null
#   resource_labels  = { env = "dev" }
# }

module "cloud_storage" {
  source = "../../modules/cloud_storage"

  project_id                     = var.project_id
  bucket_name                    = var.gcs_bucket_name
  location                       = var.gcs_location
  storage_class                  = var.gcs_storage_class
  uniform_bucket_level_access    = true
  versioning                     = true
  labels                         = { env = "dev" }
}
