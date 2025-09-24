variable "project_id" {
  description = "ID del proyecto de GCP (p.ej., my-gcp-project)"
  type        = string
}

variable "region" {
  description = "Región de GCP donde crear la instancia (p.ej., europe-west1)"
  type        = string
  default     = "europe-west1"
}

variable "instance_name" {
  description = "Nombre de la instancia de Cloud SQL"
  type        = string
  default     = "pg-main"
}

variable "database_version" {
  description = "Versión de PostgreSQL para Cloud SQL"
  type        = string
  default     = "POSTGRES_16"
}

variable "tier" {
  description = "Tipo de máquina (p.ej., db-custom-1-3840)"
  type        = string
  default     = "db-custom-1-3840"
}

variable "disk_type" {
  description = "Tipo de disco: PD_SSD o PD_HDD"
  type        = string
  default     = "PD_SSD"
}

variable "disk_size" {
  description = "Tamaño de disco en GB"
  type        = number
  default     = 10
}

variable "availability_type" {
  description = "ZONAL (por defecto) o REGIONAL para alta disponibilidad"
  type        = string
  default     = "ZONAL"
}

variable "backup_enabled" {
  description = "Activa copias de seguridad automáticas"
  type        = bool
  default     = true
}

variable "authorized_networks" {
  description = "Lista de redes autorizadas para acceder por IP pública"
  type = list(object({
    name = string
    cidr = string
  }))
  default = []
}

variable "database_name" {
  description = "Nombre de la base de datos de aplicación"
  type        = string
  default     = "app_db"
}

variable "user_name" {
  description = "Usuario de la aplicación"
  type        = string
  default     = "app_user"
}

variable "deletion_protection" {
  description = "Evita borrado accidental de la instancia"
  type        = bool
  default     = false
}

# GKE
variable "gke_cluster_name" {
  description = "Nombre del clúster GKE"
  type        = string
  default     = "pre-gke"
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

# Cloud Storage
variable "gcs_bucket_name" {
  description = "Nombre del bucket (si null, se deriva)"
  type        = string
  default     = null
}

variable "gcs_location" {
  description = "Ubicación del bucket"
  type        = string
  default     = "EU"
}

variable "gcs_storage_class" {
  description = "Clase de almacenamiento"
  type        = string
  default     = "STANDARD"
}


