variable "region" {
  description = "Región de GCP"
  type        = string
}

variable "bucket_name" {
  description = "Nombre del bucket de GCS"
  type        = string
}

variable "cors_origins" {
  description = "Lista de orígenes permitidos para CORS"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "labels" {
  description = "Etiquetas para el bucket (ej: environment, resource-type)"
  type        = map(string)
  default     = {}
}