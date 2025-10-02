resource "google_storage_bucket" "object_storage" {
  location = var.region
  name     = var.bucket_name

  versioning {
    enabled = true
  }
}
