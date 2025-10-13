# Private Service Connect Endpoint
# Permite conectar desde la VPC al servicio CloudSQL vía PSC

resource "google_compute_address" "psc_endpoint_ip" {
  name         = "${var.endpoint_name}-ip"
  address_type = "INTERNAL"
  subnetwork   = var.subnetwork_id
  region       = var.region
  project      = var.project_id
}

resource "google_compute_forwarding_rule" "psc_endpoint" {
  name                  = var.endpoint_name
  region                = var.region
  project               = var.project_id
  load_balancing_scheme = ""
  network               = var.network_id
  ip_address            = google_compute_address.psc_endpoint_ip.id
  target                = var.service_attachment
  labels                = var.labels
}

