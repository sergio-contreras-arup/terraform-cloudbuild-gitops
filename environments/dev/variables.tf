########## Configuración base ##########
variable "project_id" {
  description = "ID del proyecto de GCP (p.ej., my-gcp-project)"
  type        = string
}

variable "region" {
  description = "Región de GCP donde crear la instancia (p.ej., europe-west1)"
  type        = string
  default     = "europe-west1"
}

########## CARTO ##########
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

########## Frontend ##########
variable "frontend_storage_static_name" {
    description = "Nombre del bucket de GCS para la web estática"
    type        = string
    default     = "frontend"
}

########## Backend ##########
variable "artifact_repository_name" {
  description = "Nombre del repositorio de Artifact Registry"
  type        = string
  default     = "backend-repo"
}

variable "artifact_repository_description" {
  description = "Descripción del repositorio de Artifact Registry"
  type        = string
}

variable "artifact_repository_format" {
  description = "Formato del repositorio de Artifact Registry"
  type        = string
  default     = "DOCKER"
}