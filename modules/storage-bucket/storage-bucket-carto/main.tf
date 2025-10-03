resource "google_storage_bucket" "storage_static_site_carto" {
  location = var.region
  name     = var.bucket_name

  versioning {
    enabled = true
  }
}
