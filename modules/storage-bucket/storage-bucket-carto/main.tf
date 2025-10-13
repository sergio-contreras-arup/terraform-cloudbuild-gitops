resource "google_storage_bucket" "storage_carto" {
  location                    = var.region
  name                        = var.bucket_name
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  labels                      = var.labels

  versioning {
    enabled = true
  }
}
