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