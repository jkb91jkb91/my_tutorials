#!/bin/bash


#INSTALL APACHE
sudo apt update
sudo apt install -y apache2
sudo apt-get install lsof -y  


# RUN THIS TO RUN APACHE_EXPORTER ON LOCALHOST
sudo wget https://github.com/Lusitaniae/apache_exporter/releases/download/v0.11.0/apache_exporter-0.11.0.linux-amd64.tar.gz -O ~/apache-exporter.tar.gz
sudo tar -xzf ~/apache-exporter.tar.gz  && cd apache_exporter-0.11.0.linux-amd64 && sudo mv apache_exporter /usr/bin/local/

sudo bash -c 'cat > /etc/systemd/system/apache_exporter.service <<EOF
[Unit]
Description=Apache Exporter
After=network.target

[Service]
ExecStart=/usr/local/bin/apache_exporter --scrape_uri="http://localhost/server-status?auto"
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

sudo systemctl daemon-reload
sudo systemtctl enable apache_exporter
sudo systemctl start apache_exporter


sudo rm -rf /etc/apache2/sites-available/000-default.conf
sudo bash -c 'cat > /etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
       
        <Location "/server-status">
           SetHandler server-status
           Require local  # Ogranicza dostęp tylko do localhost
        </Location>
</VirtualHost>t
EOF'

sudo systemtctl restart apache2


