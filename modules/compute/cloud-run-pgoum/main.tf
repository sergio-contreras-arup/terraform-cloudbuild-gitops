resource "google_cloud_run_v2_service" "default" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  labels = var.labels

  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository}/${var.image}:${var.tag}"
    }

    service_account = var.service_account_email

    vpc_access {
      connector = google_vpc_access_connector.connector.name
      egress    = "ALL_TRAFFIC"
    }
  }
}

resource "google_vpc_access_connector" "connector" {
  name = "run-vpc"
  subnet {
    name = var.shared_subnet_name
  }
  min_instances = 2
  max_instances = 3
  region        = var.region
}
