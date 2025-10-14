resource "google_storage_bucket" "storage_carto" {
  location                    = var.region
  name                        = var.bucket_name
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  labels                      = var.labels

  versioning {
    enabled = true
  }

  cors {
    origin          = ["*"]
    method          = ["GET", "POST", "PUT"]
    max_age_seconds = 3600
    response_header = ["Content-Type", "Content-MD5", "Content-Disposition", "Cache-Control", "x-goog-content-length-range", "x-goog-meta-filename"]
  }
}
