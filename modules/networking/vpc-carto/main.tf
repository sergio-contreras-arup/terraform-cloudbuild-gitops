resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnetworks
  project                 = var.project_id
}

# Private IP allocation for Google services (CloudSQL, etc.)
resource "google_compute_global_address" "private_ip_alloc" {
  count         = var.enable_private_service_connection ? 1 : 0
  name          = "${var.vpc_name}-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

# Private VPC connection for Google services
resource "google_service_networking_connection" "private_vpc_connection" {
  count                   = var.enable_private_service_connection ? 1 : 0
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc[0].name]
}
