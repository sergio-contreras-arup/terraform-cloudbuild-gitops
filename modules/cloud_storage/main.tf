resource "google_project_service" "storage" {
  project            = var.project_id
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}

locals {
  derived_bucket_name = var.bucket_name != null ? var.bucket_name : "${var.project_id}-bucket"
}

resource "google_storage_bucket" "this" {
  name          = local.derived_bucket_name
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class

  uniform_bucket_level_access = var.uniform_bucket_level_access

  versioning {
    enabled = var.versioning
  }

  labels = var.labels

  force_destroy = false

  depends_on = [google_project_service.storage]
}


