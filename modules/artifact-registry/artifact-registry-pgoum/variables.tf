variable "region" {
  description = "Región de GCP"
  type        = string
}

variable "repository_name" {
  description = "Nombre del repositorio de Artifact Registry"
  type        = string
}

variable "repository_description" {
  description = "Descripción del repositorio de Artifact Registry"
  type        = string
  default     = "Repositorio de Artifact Registry"
}

variable "repository_format" {
  description = "Formato del repositorio de Artifact Registry"
  type        = string
  default     = "DOCKER"
}
