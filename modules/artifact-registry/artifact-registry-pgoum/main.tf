resource "google_artifact_registry_repository" "artifact_registry_pgoum" {
  location      = var.region
  repository_id = var.repository_name
  description   = var.repository_description
  format        = var.repository_format
}
