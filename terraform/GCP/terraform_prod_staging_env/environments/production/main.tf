module "compute_instance" {
  source        = "../../modules/compute"  # Ścieżka do modułu
  instance_name = "my-vm-instance"
  machine_type  = "n1-standard-1"
  zone          = "us-central1-a"
  disk_image    = "debian-cloud/debian-9"
  network       = "default"
  tags          = ["web", "dev"]
}



