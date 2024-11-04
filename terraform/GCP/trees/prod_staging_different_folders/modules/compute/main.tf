resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = var.network

     dynamic "access_config" {
      for_each = var.assign_public_ip ? [1] : []
      content {
        # Pusty blok access_config, który przydzieli publiczny IP
      }
    }
  }

  # AT LEAST COMPUTE ENGINE ADMIN ROLE NEEDED TO FIND OPS AGENT
  service_account {
    email  = "computeengine@gowno-439010.iam.gserviceaccount.com"  # Adres e-mail konta serwisowego
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]  # Zakresy dostępu
  }

  metadata_startup_script = <<-EOF
  #!/bin/bash
  sudo apt update
  sudo apt install -y apache2

  # Usuwanie domyślnego pliku index.html
  sudo rm -rf /var/www/html/index.html

  # Tworzenie nowego pliku index.html z zawartością HTML
  cat << 'HTML' | sudo tee /var/www/html/index.html > /dev/null
  <!DOCTYPE html>
  <html lang="pl">
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Czerwona Strona</title>
      <style>
          body {
              background-color: #FF69B4;
              color: white; /* Biały kolor tekstu */
              font-family: Arial, sans-serif; /* Ustawienie czcionki */
              text-align: center; /* Wyśrodkowanie tekstu */
              padding: 50px; /* Odstęp wewnętrzny */
          }
      </style>
  </head>
  <body>
      <p>Kssdsdse</p>
  </body>
  </html>
  HTML

  # Restart Apache, aby załadować nowy plik
  sudo systemctl restart apache2
  sudo wget https://github.com/Lusitaniae/apache_exporter/releases/download/v0.11.0/apache_exporter-0.11.0.linux-amd64.tar.gz -O ~/node-exporter.tar.gz && sudo tar -xzf ~/node-exporter.tar.gz
EOF

    metadata = {
    google-ops-agent-enabled = "true"  # Ustawienie, aby włączyć Ops Agent
  }

  tags = var.tags
}

