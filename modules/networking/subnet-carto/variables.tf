variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
}

variable "ip_cidr_range" {
  description = "Rango CIDR principal de la subred"
  type        = string
}

variable "region" {
  description = "Región de la subred"
  type        = string
}

variable "network_id" {
  description = "ID de la VPC a la que pertenece la subred"
  type        = string
}

variable "secondary_ip_ranges" {
  description = "Rangos IP secundarios para la subred (ej: para Pods y Services de GKE)"
  type = list(object({
    range_name    = string
    ip_cidr_range = string
  }))
  default = []
}
