module "cloudsql_postgres" {
  source = "../../modules/cloudsql_postgres"

  project_id          = var.project_id
  region              = var.region
  instance_name       = var.instance_name
  database_version    = var.database_version
  tier                = var.tier
  disk_type           = var.disk_type
  disk_size           = var.disk_size
  availability_type   = var.availability_type
  backup_enabled      = var.backup_enabled
  authorized_networks = var.authorized_networks
  database_name       = var.database_name
  user_name           = var.user_name
  deletion_protection = var.deletion_protection
}

module "gcs_web_storage" {
  source = "../../modules/cloud_storage"

  bucket_name   = var.frontend_bucket_name
  region        = var.region
}