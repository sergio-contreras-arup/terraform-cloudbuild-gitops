resource "google_storage_bucket" "gcs" {
  location = var.region
  name     = var.bucket_name

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["http://localhost:3000"]
    method          = ["GET", "HEAD"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}