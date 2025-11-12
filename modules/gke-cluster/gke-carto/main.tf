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

  network         = var.network
  subnetwork      = var.subnetwork
  resource_labels = var.resource_labels

  deletion_protection = false

  # VPC-native (IP aliasing) ranges for Pods and Services
  ip_allocation_policy {
    # cluster_ipv4_cidr_block  = "10.90.0.0/20"  # Para Pods
    # services_ipv4_cidr_block = "10.90.32.0/24"  # Para Servicios
    cluster_secondary_range_name  = "snet2-eusw1-des-pgoum-pods"
    services_secondary_range_name = "snet2-eusw1-des-pgoum-services"
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "vpc-trust"
      cidr_block   = "10.248.78.0/27"
    }
  }

  # Private cluster to avoid public IPs on nodes
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  depends_on = [google_project_service.container]
}
