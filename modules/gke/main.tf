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

  network    = var.network
  subnetwork = var.subnetwork

  resource_labels = var.resource_labels

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }

  deletion_protection = false

  depends_on = [google_project_service.container]
}


