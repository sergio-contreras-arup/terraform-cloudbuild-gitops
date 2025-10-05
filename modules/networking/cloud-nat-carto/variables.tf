variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "router_name" {
  description = "Nombre del Cloud Router"
  type        = string
}

variable "nat_name" {
  description = "Nombre del Cloud NAT"
  type        = string
}

variable "region" {
  description = "Región del Cloud Router y NAT"
  type        = string
}

variable "network_id" {
  description = "ID de la VPC para el Cloud Router"
  type        = string
}

variable "nat_ip_allocate_option" {
  description = "Opciones de asignación de IPs para NAT (AUTO_ONLY o MANUAL_ONLY)"
  type        = string
  default     = "AUTO_ONLY"
  validation {
    condition     = contains(["AUTO_ONLY", "MANUAL_ONLY"], var.nat_ip_allocate_option)
    error_message = "nat_ip_allocate_option debe ser AUTO_ONLY o MANUAL_ONLY."
  }
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "Rangos de IPs de subredes a usar para NAT (ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS)"
  type        = string
  default     = "LIST_OF_SUBNETWORKS"
  validation {
    condition = contains([
      "ALL_SUBNETWORKS_ALL_IP_RANGES",
      "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES",
      "LIST_OF_SUBNETWORKS"
    ], var.source_subnetwork_ip_ranges_to_nat)
    error_message = "source_subnetwork_ip_ranges_to_nat debe ser uno de: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS."
  }
}

variable "subnetworks" {
  description = "Lista de subredes que usarán el NAT"
  type = list(object({
    name                    = string
    source_ip_ranges_to_nat = list(string)
  }))
  default = []
}
