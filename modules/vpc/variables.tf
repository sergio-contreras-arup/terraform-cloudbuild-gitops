variable "vpc_name" {
  description = "El nombre de la red VPC."
  type        = string
}

variable "vpc_description" {
  description = "Una descripción de la red VPC."
  type        = string
  default     = ""
}

variable "routing_mode" {
  description = "El modo de enrutamiento de red a utilizar. Los valores posibles son 'GLOBAL' y 'REGIONAL'."
  type        = string
  default     = "REGIONAL"
}

variable "enable_internet_access" {
  description = "Indica si se debe habilitar el acceso a Internet para la VPC."
  type        = bool
  default     = false
}


