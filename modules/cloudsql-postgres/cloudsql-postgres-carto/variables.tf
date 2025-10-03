variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región de GCP"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia de Cloud SQL"
  type        = string
}

variable "database_version" {
  description = "Versión de PostgreSQL para Cloud SQL"
  type        = string
  default     = "POSTGRES_16"
}

variable "tier" {
  description = "Tipo de máquina"
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
  description = "ZONAL o REGIONAL"
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


