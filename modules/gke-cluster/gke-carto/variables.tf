variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "location" {
  description = "Ubicación del clúster (región o zona). Para Standard usar zona o región."
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
  description = "Self link de la VPC a usar para el clúster"
  type        = string
}

variable "subnetwork" {
  description = "Self link de la subred a usar para el clúster"
  type        = string
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

# Node Pool Configuration
variable "node_count" {
  description = "Número de nodos por zona en el node pool"
  type        = number
  default     = 3
  validation {
    condition     = var.node_count >= 3
    error_message = "El número de nodos debe ser al menos 3."
  }
}

variable "machine_type" {
  description = "Tipo de máquina para los nodos (ej: e2-standard-4 = 4 vCPUs, 16GB RAM)"
  type        = string
  default     = "e2-standard-4"
}

variable "disk_size_gb" {
  description = "Tamaño del disco en GB para cada nodo"
  type        = number
  default     = 100
}

variable "disk_type" {
  description = "Tipo de disco (pd-standard o pd-ssd)"
  type        = string
  default     = "pd-standard"
  validation {
    condition     = contains(["pd-standard", "pd-ssd", "pd-balanced"], var.disk_type)
    error_message = "disk_type debe ser pd-standard, pd-ssd o pd-balanced."
  }
}

variable "min_node_count" {
  description = "Número mínimo de nodos para autoscaling"
  type        = number
  default     = 3
}

variable "max_node_count" {
  description = "Número máximo de nodos para autoscaling"
  type        = number
  default     = 10
}

variable "node_labels" {
  description = "Etiquetas adicionales para los nodos"
  type        = map(string)
  default     = {}
}

variable "node_tags" {
  description = "Network tags para los nodos"
  type        = list(string)
  default     = []
}