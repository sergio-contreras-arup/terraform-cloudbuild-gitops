resource "google_compute_subnetwork" "subnet_carto" {
  name                     = var.subnet_name
  description              = var.subnet_description
  ip_cidr_range            = var.subnet_ip_cidr_range
  network                  = var.vpc_id
  private_ip_google_access = var.private_ip_google_access
  stack_type               = "IPV4_ONLY"

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

  depends_on = [google_compute_network.vpc]
}
