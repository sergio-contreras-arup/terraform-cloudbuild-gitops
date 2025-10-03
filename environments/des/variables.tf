variable "project_id" {
  description = "ID del proyecto de GCP (p.ej., my-gcp-project)"
  type        = string
}

variable "region" {
  description = "Región de GCP donde crear la instancia (p.ej., europe-west1)"
  type        = string
  default     = "europe-west1"
}

variable "apis" {
  description = "Lista de APIs de GCP a habilitar"
  type        = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
  ]
}

variable "artifact_repository_name_pgoum" {
  description = "Nombre del repositorio de Artifact Registry"
  type        = string
  default     = "backend-image-repository"
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
  default     = "pg-main"
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
variable "gke_cluster_name_carto" {
  description = "Nombre del clúster GKE"
  type        = string
  default     = "dev-carto-gke"
}

variable "gke_location_carto" {
  description = "Ubicación (región) para GKE Autopilot"
  type        = string
  default     = "europe-southwest1"
}

variable "gke_release_channel_carto" {
  description = "Canal de release del clúster: RAPID, REGULAR o STABLE"
  type        = string
  default     = "REGULAR"
}

# VPC
variable "vpc_name_carto" {
  description = "Nombre de la VPC"
  type        = string
  default     = "carto-vpc"
}

#Subnet
variable "subnet_name_carto" {
  description = "Nombre de la subred para CARTO"
  type        = string
  default     = "carto-subnet"
}

variable "subnet_ip_cidr_range_carto" {
  description = "Rango de IPs para la subred de CARTO"
  type        = string
  default     = "10.0.1.0/20"
}

variable "secondary_ip_ranges_carto" {
  description = "Rangos de IPs secundarios para la subred de CARTO"
  type = map(object({
    ip_cidr_range = string
    range_name    = string
  }))
  default = {
    pods = {
      ip_cidr_range = "10.4.0.0/24"
      range_name    = "pods"
    }
    services = {
      ip_cidr_range = "10.0.32.0/24"
      range_name    = "services"
    }
  }
}

# Storage bucket
variable "storage_bucket_bucket_name_carto" {
  description = "Nombre del bucket (si null, se deriva)"
  type        = string
  default     = null
}

########## Frontend ##########
variable "storage_bucket_bucket_name__pgoum_frontend" {
  description = "Nombre del bucket para frontend (si null, se deriva)"
  type        = string
  default     = "pem-frontend"
}
