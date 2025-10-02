output "gke_cluster_id" {
  description = "The ID of the GKE cluster"
  value       = google_container_cluster.gke_cluster.id
}
