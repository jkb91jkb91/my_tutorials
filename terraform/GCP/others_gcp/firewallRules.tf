# resource "google_compute_firewall" "default" {
#   name    = "test-firewall"
#   network = "default"

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "8080"]
#   }

#   target_tags = ["web"]
#   source_tags = ["web"]
# }


resource "google_compute_firewall" "allow_ssh_iap" {
  name    = "allow-ssh-iap"
  network = "kuba-vpc"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["web"]
}