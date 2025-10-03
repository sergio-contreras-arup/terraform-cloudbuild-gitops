
resource "google_container_cluster" "gke_carto" {
  name     = var.cluster_name
  location = var.location

  enable_autopilot = true

  release_channel {
    channel = var.release_channel
  }
  
  network    = var.vpc_link
  subnetwork = var.subnet_link
  resource_labels = var.resource_labels

  deletion_protection = false
# VPC-native (IP aliasing) ranges for Pods and Services
  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  # Private cluster to avoid public IPs on nodes
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

}


# Cloud NAT to provide outbound internet access for private nodes
resource "google_compute_router" "nat_router" {
  name    = "gke-nat-router"
  region  = var.location
  network = var.vpc_link
}

resource "google_compute_router_nat" "nat" {
  name                               = "gke-nat"
  router                             = google_compute_router.nat_router.name
  region                             = var.location
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = var.subnet_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}
