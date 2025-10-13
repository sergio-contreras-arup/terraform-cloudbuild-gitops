resource "google_storage_bucket" "storage_pgoum_frontend" {
  location                    = var.region
  name                        = var.bucket_name
  uniform_bucket_level_access = true
  labels                      = var.labels

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = var.cors_origins
    method          = ["GET", "HEAD"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}
