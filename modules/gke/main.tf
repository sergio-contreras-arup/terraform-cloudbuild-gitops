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

  depends_on = [google_project_service.container]
}


