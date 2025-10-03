variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "location" {
  description = "Ubicación del clúster (región o zona). Para Autopilot usar región."
  type        = string
}

variable "cluster_name" {
  description = "Nombre del clúster de GKE"
  type        = string
}

variable "release_channel" {
  description = "Canal de release del clúster: RAPID, REGULAR o STABLE"
  type        = string
  default     = "REGULAR"
  validation {
    condition     = contains(["RAPID", "REGULAR", "STABLE"], var.release_channel)
    error_message = "release_channel debe ser uno de: RAPID, REGULAR, STABLE."
  }
}

variable "network" {
  description = "VPC a usar para el clúster. Si es null, usa la por defecto."
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "Subred a usar para el clúster. Si es null, usa la por defecto."
  type        = string
  default     = null
}

variable "resource_labels" {
  description = "Etiquetas a aplicar al clúster"
  type        = map(string)
  default     = {}
}

variable "master_ipv4_cidr_block" {
  description = "Bloque CIDR para el plano de control privado (master). Requerido para clúster privado."
  type        = string
  default     = "172.16.0.0/28"
}

variable "pods_secondary_range_name" {
  description = "Nombre del rango secundario para Pods en la subred"
  type        = string
  default     = "pods-range"
}

variable "services_secondary_range_name" {
  description = "Nombre del rango secundario para Services en la subred"
  type        = string
  default     = "services-range"
}