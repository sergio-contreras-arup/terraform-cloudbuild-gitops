resource "google_compute_router" "cloud_router" {
  name = var.router_name
  region = var.region
  network = var.vpc_id
 
  bgp {
    asn = var.router_asn
  }
}
 
resource "google_compute_router_nat" "cloud_nat" {
  name = var.nat_name
  router = google_compute_router.cloud_router.name
  region = var.region
  nat_ip_allocate_option = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
 
  log_config {
    enable = var.log_config_enable
    filter = var.log_config_filter
  }
 
  min_ports_per_vm = var.min_ports_per_vm
  enable_endpoint_independent_mapping = var.enable_endpoint_independent_mapping
}