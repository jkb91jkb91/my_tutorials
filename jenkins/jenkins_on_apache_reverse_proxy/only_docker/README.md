# ODPAL APACHE(httpd) w DOCKERZE DO HOSTOWANIA STRON

Config bedzie tutaj przekopiowany >> /usr/local/apache2/conf/httpd.conf
```
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
    ProxyPass         "/jenkins" "http://jenkins:8080/jenkins" nocanon
    ProxyPassReverse  "/jenkins"  "http://jenkins:8080/jenkins"
</VirtualHost>
```

```
sudo docker run -d --name apache -v $(pwd)/httpd.conf:/usr/local/apache2/conf/httpd.conf -p 80:80 httpd:2.4
```

# JENKINS

W obrazie jenkinsa ustawiamy to
```
ENV JENKINS_OPTS="--prefix=/jenkins"
```
czyli caly Dockerfile.jenkins
```
FROM jenkins/jenkins:lts  
ENV JENKINS_OPTS="--prefix=/jenkins"
```

```
docker build -t customized_jenkins -f Dockerfile.jenkins .  
docker run -d --name jenkins -p 8080:8080 customized_jenkins
```

Ta zmienna jest takze tutaj /etc/default/jenkins ale jej zmiana moze nie dac rezultatu wiec lepiej ustawic to w obrazie  

Dostaniemy dostep po prefixie /jenkins   
http://localhost:8080/jenkins << bedzie tutaj stal wiec potrzeba proxy jeszcze                                     


# Create Network ALTERNATIVE  
#docker network create --subnet=172.20.0.0/16 --gateway=172.20.0.1 my_internal_network  
docker network create kuba_networ  




# Create network  
docker network connect kuba_network apache  
docker network connect kuba_network jenkins  


# Check if both are in network  
docker network inspect kuba_network  

