variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "endpoint_name" {
  description = "Nombre del endpoint PSC"
  type        = string
}

variable "region" {
  description = "Región del endpoint"
  type        = string
}

variable "network_id" {
  description = "ID de la VPC donde crear el endpoint"
  type        = string
}

variable "subnetwork_id" {
  description = "ID de la subnet donde asignar la IP"
  type        = string
}

variable "service_attachment" {
  description = "Service Attachment URI del servicio CloudSQL"
  type        = string
}

variable "labels" {
  description = "Etiquetas para el endpoint PSC (ej: environment, resource-type)"
  type        = map(string)
  default     = {}
}

