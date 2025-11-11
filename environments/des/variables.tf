variable "project_id" {
  description = "ID del proyecto de GCP (p.ej., my-gcp-project)"
  type        = string
}

variable "region" {
  description = "Región de GCP donde crear la instancia (p.ej., europe-west1)"
  type        = string
  default     = "europe-west1"
}

variable "environment" {
  description = "Entorno de despliegue (p.ej., dev, des, prod)"
  type        = string
  default     = "des"
}

variable "apis" {
  description = "Lista de APIs de GCP a habilitar"
  type        = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com", # Required for PSC endpoints
    "container.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "sqladmin.googleapis.com", # Required for CloudSQL
    "storage.googleapis.com",
    "run.googleapis.com", # Required for Cloud Run
  ]
}

variable "artifact_repository_name_pgoum" {
  description = "Nombre del repositorio de Artifact Registry"
  type        = string
  default     = "art-eusw1-des-pgoum-repository-01"
}

variable "artifact_repository_description_pgoum" {
  description = "Descripción del repositorio de Artifact Registry"
  type        = string
  default     = "Repositorio de Artifact Registry"
}

variable "artifact_repository_format_pgoum" {
  description = "Formato del repositorio de Artifact Registry"
  type        = string
  default     = "DOCKER"
}

########## Carto ##########
# Cloud SQL PostgreSQL
variable "cloudsql_instance_name_carto" {
  description = "Nombre de la instancia de Cloud SQL"
  type        = string
  default     = "sql-eusw1-des-pgoum-carto-01"
}

variable "cloudsql_database_version_carto" {
  description = "Versión de PostgreSQL para Cloud SQL"
  type        = string
  default     = "POSTGRES_16"
}

variable "cloudsql_tier_carto" {
  description = "Tipo de máquina (p.ej., db-custom-1-3840)"
  type        = string
  default     = "db-custom-1-3840"
}

variable "cloudsql_disk_type_carto" {
  description = "Tipo de disco: PD_SSD o PD_HDD"
  type        = string
  default     = "PD_SSD"
}

variable "cloudsql_disk_size_carto" {
  description = "Tamaño de disco en GB"
  type        = number
  default     = 10
}

variable "cloudsql_availability_type_carto" {
  description = "ZONAL (por defecto) o REGIONAL para alta disponibilidad"
  type        = string
  default     = "ZONAL"
}

variable "cloudsql_backup_enabled_carto" {
  description = "Activa copias de seguridad automáticas"
  type        = bool
  default     = true
}

variable "cloudsql_authorized_networks_carto" {
  description = "Lista de redes autorizadas para acceder por IP pública"
  type = list(object({
    name = string
    cidr = string
  }))
  default = []
}

variable "cloudsql_database_name_carto" {
  description = "Nombre de la base de datos de aplicación"
  type        = string
  default     = "app_db"
}

variable "cloudsql_user_name_carto" {
  description = "Usuario de la aplicación"
  type        = string
  default     = "app_user"
}

variable "cloudsql_deletion_protection_carto" {
  description = "Evita borrado accidental de la instancia"
  type        = bool
  default     = false
}

# GKE
variable "gke_cluster_name" {
  description = "Nombre del clúster GKE"
  type        = string
  default     = "gke-eusw1-des-pgoum-carto-01"
}

variable "gke_location" {
  description = "Ubicación (región) para GKE Autopilot"
  type        = string
  default     = "europe-southwest1"
}

variable "gke_release_channel" {
  description = "Canal de release del clúster: RAPID, REGULAR o STABLE"
  type        = string
  default     = "REGULAR"
}

# Storage bucket
variable "import_storage_bucket_bucket_name_carto" {
  description = "Nombre del bucket (si null, se deriva)"
  type        = string
  default     = "bck-eusw1-des-pgoum-carto-01"
}

variable "thumbnails_storage_bucket_bucket_name_carto" {
  description = "Nombre del bucket (si null, se deriva)"
  type        = string
  default     = "bck-eusw1-des-pgoum-carto-02"
}

########## Frontend ##########
variable "storage_bucket_bucket_name__pgoum_frontend" {
  description = "Nombre del bucket para frontend (si null, se deriva)"
  type        = string
  default     = "bck-eusw1-des-pgoum-frontend-01"
}

variable "host_project_id" {
  type    = string
  default = "prj-pro-hub-n0acos"
  # default="prj-pro-hub-n0acos"
} # prj-pro-hub-n0acos

variable "shared_network_name" {
  type    = string
  default = "vpc-trust"
} # vpc-trust

variable "shared_subnet_name" {
  type    = string
  default = "snet-eusw1-des-pgoum-01"
} # snet-eusw1-pro-pgoum-auto-01

########## CLOUD RUN SERVICE PGOUM ##########
variable "cloud_run_service_name_pgoum" {
  description = "Nombre del servicio Cloud Run"
  type        = string
  default     = "cr-eusw1-des-pgoum"
}

variable "cloud_run_image_name_pgoum" {
  description = "Nombre de la imagen en Artifact Registry"
  type        = string
  default     = "pgoum-api"
}
