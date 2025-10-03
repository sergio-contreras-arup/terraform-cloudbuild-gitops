variable "cluster_name" {
  description = "Nombre del clúster de GKE"
  type        = string
}

variable "location" {
  description = "Ubicación del clúster de GKE (región o zona)"
  type        = string
}

variable "release_channel" {
  description = "Canal de lanzamiento para el clúster de GKE (RAPID, REGULAR, STABLE)"
  type        = string
  default     = "REGULAR"
}

variable "vpc_link" {
  description = "ID de la VPC donde se desplegará el clúster de GKE"
  type        = string
}

variable "subnet_link" {
  description = "ID de la subred donde se desplegará el clúster de GKE"
  type        = string
}

