# # #resource "google_service_account" "default" {
# # #  account_id   = "my-custom-sa"
# # #  display_name = "Custom SA for VM Instance"
# # #}

# resource "google_compute_instance" "default" {
#   name         = local.name
#   machine_type = "e2-micro"
#   zone         = "us-central1-a"

#   tags = ["web"]

#   boot_disk {
#     auto_delete = false
#     initialize_params {
#       image = "debian-cloud/debian-11"
#       labels = {
#         my_label = "value"
#       }
#     }
#   }

#    desired_status = "RUNNING"

# #    attached_disk {
# #     source = google_compute_disk.primary.id  # Odwołanie do dysku, który utworzyłeś
# #     mode   = "READ_WRITE"  # Tryb odczytu i zapisu (read-write)
# #   }
  

# #     metadata_startup_script = <<-EOT
# #     #!/bin/bash
# #     # Sprawdź, czy dysk /dev/sdb istnieje
# #     if lsblk | grep -q "sdb"; then
# #       echo "Dysk /dev/sdb wykryty"
# #       # Sprawdź, czy dysk jest już sformatowany
# #       if ! blkid /dev/sdb; then
# #         echo "Formatowanie dysku /dev/sdb"
# #         sudo mkfs.ext4 /dev/sdb
# #       fi
# #       # Tworzenie katalogu do montowania
# #       sudo mkdir -p /mnt/data-disk
# #       # Montowanie dysku
# #       sudo mount /dev/sdb /mnt/data-disk
# #       # Zapisz montowanie do /etc/fstab, aby dysk automatycznie montował się przy restarcie
# #       echo '/dev/sdb /mnt/data-disk ext4 defaults 0 2' | sudo tee -a /etc/fstab
# #     else
# #       echo "Dysk /dev/sdb nie wykryty"
# #     fi
# #   EOT


#   network_interface {
#     network = "kuba-vpc"
#     subnetwork = "log-test-subnetwork"

#     #EPHEMERAL PUBLIC IP WITHOUT STATIC IP
#     access_config {}
#   }
#   allow_stopping_for_update = true
  
#   service_account {
#     # Google recommends c access_config {}ustom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     email  = "default"
#     scopes = ["cloud-platform"]
#   }
# }


# #PERSISTENT DISK


# #STATIC IP
# # resource "google_compute_address" "static_ip" {
# #   name         = "my-static-ip"
# #   region       = "us-central1"  # Zmień na region, w którym ma być przypisany adres IP
# # }