variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "bucket_name" {
  description = "Nombre del bucket (globalmente único). Si null, se deriva."
  type        = string
  default     = null
}

variable "location" {
  description = "Región o multirregión del bucket (p.ej., europe-southwest1)"
  type        = string
}

variable "storage_class" {
  description = "Clase de almacenamiento (STANDARD, NEARLINE, COLDLINE, ARCHIVE)"
  type        = string
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  description = "Habilita control uniforme de nivel de bucket"
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Habilita el versionado de objetos"
  type        = bool
  default     = true
}

variable "labels" {
  description = "Etiquetas a aplicar al bucket"
  type        = map(string)
  default     = {}
}


