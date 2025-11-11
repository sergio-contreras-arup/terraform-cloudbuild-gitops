variable "service_name" {
  description = "Nombre del servicio Cloud Run"
  type        = string
  default     = "cr-eusw1-des-pgoum-carto-01"
}

variable "region" {
  description = "Región de GCP"
  type        = string
}

variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "repository" {
  description = "Nombre del repositorio de imágenes"
  type        = string
}

variable "image" {
  description = "Nombre de la imagen"
  type        = string
}
variable "tag" {
  description = "Etiqueta de la imagen"
  type        = string
  default     = "latest"
}

variable "labels" {
  description = "Etiquetas para el servicio Cloud Run"
  type        = map(string)
  default     = {}
}

variable "shared_network_name" {
  description = "Nombre de la red compartida VPC"
  type        = string
}

variable "shared_subnet_name" {
  description = "Nombre de la subred compartida VPC"
  type        = string
}

variable "service_account_email" {
  description = "Correo electrónico de la cuenta de servicio para Cloud Run"
  type        = string
  default     = ""
}
