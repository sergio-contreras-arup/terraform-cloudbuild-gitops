variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región para la instancia de Cloud SQL"
  type        = string
}

variable "instance_name" {
  description = "Nombre de la instancia de Cloud SQL (ej: carto-des-environment)"
  type        = string
}

variable "database_version" {
  description = "Versión de PostgreSQL (recomendado: POSTGRES_14 o superior)"
  type        = string
  default     = "POSTGRES_15"
  validation {
    condition     = can(regex("^POSTGRES_(14|15|16)$", var.database_version))
    error_message = "La versión de PostgreSQL debe ser 14 o superior (POSTGRES_14, POSTGRES_15, POSTGRES_16)."
  }
}

variable "tier" {
  description = "Tier de la instancia (ej: db-custom-1-3840 para 1 vCPU y 3.75 GB RAM)"
  type        = string
  default     = "db-custom-1-3840" # 1 vCPU, 3.75 GB RAM (mínimo 2GB de RAM)
  validation {
    condition     = can(regex("^db-(custom|f1|g1|n1|e2)-", var.tier))
    error_message = "El tier debe seguir el formato válido de Cloud SQL."
  }
}

variable "disk_type" {
  description = "Tipo de disco (PD_SSD o PD_HDD)"
  type        = string
  default     = "PD_SSD"
  validation {
    condition     = contains(["PD_SSD", "PD_HDD"], var.disk_type)
    error_message = "El tipo de disco debe ser PD_SSD o PD_HDD."
  }
}

variable "disk_size" {
  description = "Tamaño del disco en GB (mínimo 20 GB para producción)"
  type        = number
  default     = 20
  validation {
    condition     = var.disk_size >= 20
    error_message = "El tamaño del disco debe ser al menos 20 GB para producción."
  }
}

variable "disk_autoresize" {
  description = "Habilitar el redimensionamiento automático del disco"
  type        = bool
  default     = true
}

variable "availability_type" {
  description = "Tipo de disponibilidad (ZONAL o REGIONAL)"
  type        = string
  default     = "ZONAL"
  validation {
    condition     = contains(["ZONAL", "REGIONAL"], var.availability_type)
    error_message = "El tipo de disponibilidad debe ser ZONAL o REGIONAL."
  }
}

variable "deletion_protection" {
  description = "Protección contra eliminación (recomendado true para producción)"
  type        = bool
  default     = false
}

# Backup configuration
variable "backup_enabled" {
  description = "Habilitar backups automáticos"
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "Hora de inicio de backups (formato HH:MM)"
  type        = string
  default     = "03:00"
}

variable "point_in_time_recovery_enabled" {
  description = "Habilitar recuperación point-in-time"
  type        = bool
  default     = true
}

variable "transaction_log_retention_days" {
  description = "Días de retención de logs de transacciones (requerido para PITR)"
  type        = number
  default     = 7
  validation {
    condition     = var.transaction_log_retention_days >= 1 && var.transaction_log_retention_days <= 7
    error_message = "Los días de retención deben estar entre 1 y 7."
  }
}

variable "retained_backups" {
  description = "Número de backups a retener"
  type        = number
  default     = 7
}

# Network configuration
variable "ipv4_enabled" {
  description = "Habilitar IPv4 público"
  type        = bool
  default     = false
}

variable "private_network" {
  type        = string
  default     = null
  description = "Self link de la VPC para Private IP. Ej: google_compute_network.vpc.self_link"
}

variable "authorized_networks" {
  type        = list(object({ name = string, value = string }))
  default     = []
  description = "Solo válido si ipv4_enabled=true"
}

variable "require_ssl" {
  description = "Requerir SSL para conexiones"
  type        = bool
  default     = true
}

# Maintenance window
variable "maintenance_window_day" {
  description = "Día de la semana para mantenimiento (1=Lunes, 7=Domingo)"
  type        = number
  default     = 7
  validation {
    condition     = var.maintenance_window_day >= 1 && var.maintenance_window_day <= 7
    error_message = "El día debe estar entre 1 (Lunes) y 7 (Domingo)."
  }
}

variable "maintenance_window_hour" {
  description = "Hora del día para mantenimiento (0-23)"
  type        = number
  default     = 3
  validation {
    condition     = var.maintenance_window_hour >= 0 && var.maintenance_window_hour <= 23
    error_message = "La hora debe estar entre 0 y 23."
  }
}

variable "maintenance_window_update_track" {
  description = "Track de actualizaciones (stable o canary)"
  type        = string
  default     = "stable"
  validation {
    condition     = contains(["stable", "canary"], var.maintenance_window_update_track)
    error_message = "El track debe ser 'stable' o 'canary'."
  }
}

# Query insights
variable "query_insights_enabled" {
  description = "Habilitar Query Insights para monitoreo"
  type        = bool
  default     = true
}

variable "query_string_length" {
  description = "Longitud máxima de query string a registrar"
  type        = number
  default     = 1024
}

variable "record_application_tags" {
  description = "Registrar tags de aplicación en Query Insights"
  type        = bool
  default     = false
}

variable "record_client_address" {
  description = "Registrar dirección de cliente en Query Insights"
  type        = bool
  default     = false
}

# Database and user configuration
variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "carto"
}

variable "user_name" {
  description = "Nombre del usuario de la base de datos"
  type        = string
  default     = "carto"
}

variable "user_password" {
  description = "Contraseña del usuario (si es null, se genera automáticamente)"
  type        = string
  default     = null
  sensitive   = true
}

variable "store_password_in_secret_manager" {
  description = "Almacenar la contraseña en Secret Manager"
  type        = bool
  default     = true
}

# Database flags
variable "max_connections" {
  description = "Número máximo de conexiones a la base de datos"
  type        = string
  default     = "100"
}

variable "additional_database_flags" {
  description = "Flags adicionales de configuración de PostgreSQL"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

