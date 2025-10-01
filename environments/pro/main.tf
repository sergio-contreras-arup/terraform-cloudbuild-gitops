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

# Denegar IPs externas a nivel de proyecto
module "vm_external_ip_policy" {
  source     = "../../modules/org_policy_vm_external_ip"
  project_id = var.project_id
}

