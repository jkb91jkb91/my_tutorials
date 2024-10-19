resource "google_compute_network" "vpc_network" {
  name                    = "kuba-vpc"
  auto_create_subnetworks = false
}

#Private subnet
resource "google_compute_subnetwork" "subnet-with-logging" {
  name          = "log-test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}