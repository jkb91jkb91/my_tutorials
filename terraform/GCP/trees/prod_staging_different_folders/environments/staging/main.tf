module "compute_instance" {
  source        = "../../modules/compute"  # Ścieżka do modułu
  instance_name = "my-vm-instance"
  machine_type  = "e2-micro"
  zone          = "us-central1-a"
  disk_image    = "debian-11-bullseye-v20241009"
  network       = "default"
  tags          = ["web", "dev"]
}



