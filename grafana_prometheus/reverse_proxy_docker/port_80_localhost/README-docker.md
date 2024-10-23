# DOCKER INSTALLATION
sudo apt update && sudo apt-get install docker-compose && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io && sudo systemctl status docker




# Running on docker container >> pass ENV with localhost and path /grafana << this is ESSENTIAL
# default login admin:admin
docker run -d --name grafana -p 3000:3000   -e GF_SERVER_ROOT_URL="http://localhost:3000/grafana/"   grafana/grafana  


# Run httpd as another container
sudo docker run -d --name apache -v $(pwd)/httpd.conf:/usr/local/apache2/conf/httpd.conf  -p 80:80 httpd:2.4  


# Create docker network
docker network  create reverse_proxy

# Add to this network
docker network connect reverse_proxy apache
docker network connect reverse_proxy grafana



# Config

``
ServerName localhost
DocumentRoot "/usr/local/apache2/htdocs"
ServerRoot "/usr/local/apache2"
Listen 80

ErrorLog "/usr/local/apache2/logs/error_log"
CustomLog "/usr/local/apache2/logs/access_log" common

LoadModule proxy_module modules/mod_proxy.so
LoadModule unixd_module modules/mod_unixd.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule dir_module modules/mod_dir.so
LoadModule headers_module modules/mod_headers.so
LoadModule rewrite_module modules/mod_rewrite.so
LoadModule access_compat_module modules/mod_access_compat.so


<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>

<VirtualHost *:80>

    ProxyPass         "/grafana" "http://grafana:3000"
    ProxyPassReverse  "/grafana"  "http://grafana:3000"
    RewriteEngine On
    RewriteRule ^/grafana$ /grafana/ [R=301,L]

</VirtualHost>
``
