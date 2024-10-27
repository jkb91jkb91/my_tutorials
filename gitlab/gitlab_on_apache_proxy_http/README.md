# IMPORTANT
1 DO NOT TRY RUN WITH localhost  
THIS WONT WORK >> 
```
external_url=http://localhost:80/gitlab
```

YOU HAVE TO USE NORMAL IP ADRESS ON GCP INSTANCE  NOT ON WSL LOCALLY
```
external_url=http://IP:80/gitlab
```
2 YOU DONT NEED TO MAP PORTS ON HOST, HTTPD WILL SERVER CONTAINER GITLAB 
TO START DOCKER COMPOSE ON ROOT USER(IMPORTANT)  
GITLAB RUN AS ROOT ON CONTAINER  
```
sudo su && export GITLAB_HOME=$(pwd) && docker-compose up -d 
```

AFTER YOU START GITLAB + HTTPD IT WILL TAKE SOME TIME FOR GITLAB TO START  
1) go into container and wait till nginx in 80 will start
```
docker exec -it gitlab netstat -tuln | grep LISTEN
```
2) If 80 works you can check in browser >> http://IP/gitlab  

3) login: root  
   pass:  JakBar97*%%Lucyna  

# PREREQUISUITE

```
mkdir -p gitlab_data/logs
mkdir -p gitlab_data/config
mkdir -p gitlab_data/data

sudo su
export GITLAB_HOME=$(pwd)/gitlab_data
chown -R root:root gitlab_data
```

# DEBUGGING
-on gitlab container checks LISTENING PORTS
```
netstat -tuln | grep LISTEN
```

-ong gitlab container
```
gitlab-ctl status
```

-gitlab.rb
```
 /etc/gitlab/gitlab.rb
```
-cat error.log
```
/usr/local/apache2/logs/error_log
```

# INFO
In gitlab you won't set /gitlab , instead you will set only /  
httpd uses httpd.conf configuration from file  
httpd run on 80  
gitlab run on 80:8081 BUT STILL in httpd.conf you will use 80 >>>  


# INIT PASSWORD
USER=root  
PASSWORD=$(docker exec -it gitlab cat /etc/gitlab/initial_root_password | grep Password | tail -n1 | awk -F ': ' '{ print $2 }')  



# STEPS
0) set GITLAB_HOME  
export GITLAB_HOME=$(pwd)  


RUN DOCKER COMPOSE AS A ROOT >>>  
WITHOUT THIS YOU WILL HAVE PROBLEMS WITH VOLUMES 
```
sudo su
```
1.) SET docker-compose.yaml  
SET external_url=http://IP/gitlab  
OR  
SET external_url=http://IP/gitlab  
```
version: '3'
services:
  apache:
    build:
      context: ./
      dockerfile: Dockerfile.httpd
    container_name: 'apache'
    restart: always
    volumes:
      - ./httpd.conf:/usr/local/apache2/conf/httpd.conf
    ports:
      - '80:80'
    networks:
      - mynetwork

  gitlab:
    build:
      context: ./
      dockerfile: Dockerfile.gitlab
    container_name: gitlab
    restart: always
    depends_on:
      - apache
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://34.44.80.191:80/gitlab'
    volumes:
      - '$GITLAB_HOME/config:/etc/gitlab'
      - '$GITLAB_HOME/logs:/var/log/gitlab'
      - '$GITLAB_HOME/data:/var/opt/gitlab'
    networks:
      - mynetwork

networks:
  mynetwork:
    driver: bridge

```
2.) httpd.conf

```
ServerName localhost
DocumentRoot "/usr/local/apache2/htdocs"
ServerRoot "/usr/local/apache2"
Listen 80

ErrorLog "/usr/local/apache2/logs/error_log"
CustomLog "/usr/local/apache2/logs/access_log" combined

LoadModule proxy_module modules/mod_proxy.so
LoadModule unixd_module modules/mod_unixd.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule dir_module modules/mod_dir.so
LoadModule headers_module modules/mod_headers.so
LoadModule rewrite_module modules/mod_rewrite.so

<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>

<VirtualHost *:80>
    ProxyPreserveHost On
    ProxyRequests Off
    RewriteEngine On

    ProxyPass         "/gitlab" "http://gitlab:80/gitlab"
    ProxyPassReverse  "/gitlab"  "http://gitlab:80/gitlab"
    #RewriteRule ^/gitlab$ /gitlab/ [R=301,L]


    # Proxy dla WebSocketów GitLaba

    Header set Access-Control-Allow-Origin "*"
    Header set Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept"
    Header set Access-Control-Allow-Methods "GET, POST, OPTIONS"
</VirtualHost>
```
