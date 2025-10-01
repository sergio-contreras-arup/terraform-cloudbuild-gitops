# VPC
resource "google_compute_network" "vpc" {
  name                    = "gke-vpc"
  auto_create_subnetworks = false
}

# Subnet with secondary ranges (required for VPC-native GKE)
resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet-eu-west1"
  ip_cidr_range = "10.0.0.0/20"
  region        = var.location
  network       = google_compute_network.vpc.id

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.4.0.0/14"
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.0.32.0/20"
  }
}

resource "google_project_service" "container" {
  project            = var.project_id
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_container_cluster" "this" {
  name     = var.cluster_name
  location = var.location

  enable_autopilot = true

  release_channel {
    channel = var.release_channel
  }

  network = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link
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

  depends_on = [google_project_service.container]
}


# Cloud NAT to provide outbound internet access for private nodes
resource "google_compute_router" "nat_router" {
  name    = "gke-nat-router"
  region  = var.location
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "gke-nat"
  router                             = google_compute_router.nat_router.name
  region                             = var.location
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


