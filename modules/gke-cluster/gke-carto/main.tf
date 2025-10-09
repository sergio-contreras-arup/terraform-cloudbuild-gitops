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

  deletion_protection = false

  # VPC-native (IP aliasing) ranges for Pods and Services
  ip_allocation_policy {
    # cluster_ipv4_cidr_block  = "10.90.0.0/20"  # Para Pods
    # services_ipv4_cidr_block = "10.90.32.0/24"  # Para Servicios
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  # Private cluster to avoid public IPs on nodes
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  depends_on = [google_project_service.container]
}