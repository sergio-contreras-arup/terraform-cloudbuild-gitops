resource "google_cloud_run_v2_service" "default" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  labels = var.labels

  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository}/${var.image}:${var.tag}"
    }

    vpc_access {
      network_interfaces {
        network    = var.shared_network_id
        subnetwork = var.shared_subnet_id
      }
    }
  }
}

