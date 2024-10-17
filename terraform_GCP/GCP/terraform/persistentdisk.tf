resource "google_compute_disk" "primary" {
  name  = "my-disk"
  type  = "pd-ssd"
  zone  = "us-central1-a"

  physical_block_size_bytes = 4096
  size = 10
}
