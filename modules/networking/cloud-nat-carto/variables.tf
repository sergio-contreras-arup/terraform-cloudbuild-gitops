variable "router_name" {
  description = "Nombre del Cloud Router"
  type        = string
}
 
variable "nat_name" {
  description = "Nombre del Cloud NAT"
  type        = string
}
 
variable "region" {
  description = "Región donde se creará el Cloud NAT"
  type        = string
}
 
variable "vpc_id" {
  description = "ID de la VPC donde se creará el Cloud Router"
  type        = string
}
 
variable "router_asn" {
  description = "ASN local del Cloud Router para BGP"
  type        = number
  default     = 64514
}
 
variable "nat_ip_allocate_option" {
  description = "Cómo se asignan las IPs externas para Cloud NAT. Valores posibles: AUTO_ONLY, MANUAL_ONLY"
  type        = string
  default     = "AUTO_ONLY"
}
 
variable "source_subnetwork_ip_ranges_to_nat" {
  description = "Cómo se traducen las IPs de las subredes. Valores posibles: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS"
  type        = string
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
 
variable "log_config_enable" {
  description = "Indica si se habilita el logging para Cloud NAT"
  type        = bool
  default     = true
}
 
variable "log_config_filter" {
  description = "Especifica el filtro de logging deseado. Valores posibles: ERRORS_ONLY, TRANSLATIONS_ONLY, ALL"
  type        = string
  default     = "ERRORS_ONLY"
}
 
variable "min_ports_per_vm" {
  description = "Número mínimo de puertos asignados a una VM desde este NAT"
  type        = number
  default     = 64
}
 
variable "enable_endpoint_independent_mapping" {
  description = "Especifica si habilitar el mapeo independiente de endpoints"
  type        = bool
  default     = false
}