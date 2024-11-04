
resource "google_container_cluster" "gke_cluster" {
  name     = "gke-public-cluster"
  location = "us-central1"
  node_locations = ["us-central1-a","us-central1-b"]

  deletion_protection = false
  network    = var.network_name
  subnetwork = var.subnetwork_id

  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20
    service_account = "gke-sa@gowno-439010.iam.gserviceaccount.com"
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.secondary_pods_ip_range_name
    services_secondary_range_name = var.secondary_service_ip_range_name
  }

  private_cluster_config {
    enable_private_nodes = false
  }
}