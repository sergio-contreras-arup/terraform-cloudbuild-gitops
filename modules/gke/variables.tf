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


