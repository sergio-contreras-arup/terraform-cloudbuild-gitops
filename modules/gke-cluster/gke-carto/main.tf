resource "google_container_cluster" "gke_carto" {
  name     = var.cluster_name
  location = var.location

  enable_autopilot = true

  release_channel {
    channel = var.release_channel
  }

  network    = var.vpc_link
  subnetwork = var.subnet_link

  deletion_protection = false

  depends_on = [google_project_service.apis]
}
