resource "google_compute_router" "cloud_router" {
  name = var.router_name
  region = var.region
  network = var.vpc_id
}
 
resource "google_compute_router_nat" "cloud_nat" {
  name = var.nat_name
  router = google_compute_router.cloud_router.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
 
  subnetwork {
    name = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
 
}