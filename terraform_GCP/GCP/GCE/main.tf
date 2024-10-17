resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
}
