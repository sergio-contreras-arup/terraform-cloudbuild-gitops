############################
# STORAGE TERRAFORM STATE
############################
terraform {
  backend "gcs" {
    bucket = "madrid-pgoum-terraform-des"
    prefix = "state"
  }
}

############################
# DATA: RED/SUBRED EN HOST
############################
data "google_compute_network" "shared" {
  name    = var.shared_network_name
  project = var.host_project_id
}

data "google_compute_subnetwork" "shared" {
  name    = var.shared_subnet_name
  region  = var.region # europe-southwest1
  project = var.host_project_id
}
############################
# REGISTRY DE ARTEFACTOS (IMAGENES CONTENEDOR) 
############################
module "artifact_registry_pgoum" {
  source = "../../modules/artifact-registry/artifact-registry-pgoum"

  region                 = var.region
  repository_name        = var.artifact_repository_name_pgoum
  repository_description = var.artifact_repository_description_pgoum
  repository_format      = var.artifact_repository_format_pgoum
  labels = {
    env      = var.environment
    resource = "registry-pgoum"
  }
}

############################
# APIS
############################
module "apis" {
  source = "../../modules/project"
  apis   = var.apis
}

############################
# CLOUD SQL - PRIVATE SERVICE CONNECT (PSC)
############################
module "cloudsql_postgres_carto" {
  source = "../../modules/cloudsql-postgres/cloudsql-postgres-carto"

  project_id        = var.project_id
  region            = var.region
  instance_name     = "sql-eusw1-des-pgoum-carto-01"
  database_version  = "POSTGRES_15"
  tier              = "db-custom-1-3840" # 1 vCPU, 3.75 GB RAM (mínimo 2GB)
  disk_type         = "PD_SSD"
  disk_size         = 20
  availability_type = "ZONAL"

  # Database and user
  database_name = "carto"
  user_name     = "carto"

  # Security - Using Private Service Connect (PSC) instead of PSA
  deletion_protection           = false # Set to true for production
  ssl_mode                      = "ENCRYPTED_ONLY"
  ipv4_enabled                  = false            # No public IP
  psc_enabled                   = true             # Enable Private Service Connect
  psc_allowed_consumer_projects = [var.project_id] # Allow both service and host project

  # Backups
  backup_enabled                 = true
  point_in_time_recovery_enabled = true
  transaction_log_retention_days = 7

  # Monitoring
  query_insights_enabled = true

  labels = {
    env      = var.environment
    resource = "cloudsql-carto"
  }

  depends_on = [module.apis]
}

############################
# PSC ENDPOINT - CONECTA GKE CON CLOUDSQL
############################
module "psc_endpoint_cloudsql" {
  source = "../../modules/networking/psc-endpoint"

  project_id         = var.project_id
  endpoint_name      = "psc-eusw1-des-pgoum-carto-01"
  region             = var.region
  network_id         = data.google_compute_network.shared.id
  subnetwork_id      = data.google_compute_subnetwork.shared.id
  service_attachment = module.cloudsql_postgres_carto.psc_service_attachment_link
  labels = {
    env      = var.environment
    resource = "psc-endpoint-carto"
  }

  depends_on = [module.cloudsql_postgres_carto]
}

############################
# GKE CLUSTER 
############################
module "gke" {
  source = "../../modules/gke-cluster/gke-carto"

  project_id      = var.project_id
  location        = var.gke_location
  cluster_name    = var.gke_cluster_name
  release_channel = var.gke_release_channel
  network         = data.google_compute_network.shared.self_link
  subnetwork      = data.google_compute_subnetwork.shared.self_link
  
  # Secondary IP ranges for pods and services
  pods_secondary_range_name     = "snet2-eusw1-des-pgoum-pods"
  services_secondary_range_name = "snet2-eusw1-des-pgoum-services"
  
  # Node pool configuration - Standard mode (not Autopilot)
  node_count     = 3              # At least 3 nodes
  machine_type   = "e2-standard-4" # 4 vCPUs, 16GB RAM (exceeds 3 vCPUs minimum)
  disk_size_gb   = 100
  disk_type      = "pd-standard"
  min_node_count = 3
  max_node_count = 10
  
  resource_labels = {
    env      = var.environment
    resource = "gke-carto"
  }
}

############################
# STORAGE BUCKET CARTO 
############################
module "import_storage_bucket_carto" {
  source = "../../modules/storage-bucket/storage-bucket-carto"

  bucket_name = var.import_storage_bucket_bucket_name_carto
  region      = var.region
  labels = {
    env      = var.environment
    resource = "storage-bucket-carto"
  }

  depends_on = [module.apis]
}

module "thumbnails_storage_bucket_carto" {
  source = "../../modules/storage-bucket/storage-bucket-carto"

  bucket_name = var.thumbnails_storage_bucket_bucket_name_carto
  region      = var.region
  labels = {
    env      = var.environment
    resource = "storage-bucket-carto"
  }

  depends_on = [module.apis]
}
############################
# STORAGE BUCKET FRONTEND SIMULADOR 
############################
module "storage_bucket_pgoum_frontend" {
  source = "../../modules/storage-bucket/storage-bucket-pgoum-frontend"

  bucket_name = var.storage_bucket_bucket_name__pgoum_frontend
  region      = var.region
  labels = {
    env      = var.environment
    resource = "storage-bucket-frontend-pgoum"
  }

  depends_on = [module.apis]
}
