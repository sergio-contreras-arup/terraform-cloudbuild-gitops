variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "auto_create_subnetworks" {
  description = "Si se deben crear subredes automáticamente"
  type        = bool
  default     = false
}

variable "enable_private_service_connection" {
  description = "Habilitar Private Service Connection para CloudSQL y otros servicios de Google"
  type        = bool
  default     = false
}
