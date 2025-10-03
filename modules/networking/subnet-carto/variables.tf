variable "subnet_name" {
  description = "El nombre de la subred."
  type        = string
}

variable "subnet_description" {
  description = "Una descripción de la subred."
  type        = string
  default     = ""
}

variable "subnet_ip_cidr_range" {
  description = "El rango IP CIDR de la subred."
  type        = string
}

variable "vpc_id" {
  description = "El ID de la red VPC donde se creará la subred."
  type        = string
}

variable "private_ip_google_access" {
  description = "Si se debe habilitar el acceso privado a Google para la subred."
  type        = bool
  default     = true
}

variable "secondary_ip_ranges" {
  description = "Mapeo de rangos IP secundarios para la subred. La clave es el nombre del rango secundario y el valor es un objeto que contiene ip_cidr_range y range_name."
  type = map(object({
    ip_cidr_range = string
    range_name    = string
  }))
  default = {}
}

