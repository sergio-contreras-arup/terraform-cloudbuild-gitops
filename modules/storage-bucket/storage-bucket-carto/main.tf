resource "google_storage_bucket" "storage_carto" {
  location      = var.region
  name          = var.bucket_name
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }
}
