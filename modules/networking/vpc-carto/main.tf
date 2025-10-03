resource "google_compute_network" "vpc_carto" {
  name                            = var.vpc_name
  auto_create_subnetworks         = false
  description                     = var.vpc_description
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = true

  depends_on = [google_project_service.apis]
}
