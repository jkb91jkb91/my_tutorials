PREREQUISUITE FOR DOCKER COMPOSE
-build WEBAPP IMAGE from Dockerfile webapp
-build DATABASE IMAGE from Dockerfile database
-build NGINX IMAGE from Dockerfile nginx
-in docker-compose.yaml use names of THESE 3x IMAGES
-in nginx configuration file >> write name of the container of webapp, instruction below


FROM INSIDE OF NGINX CONTAINER make a curl to web app using NAME OF THE CONTAINER OF WEBAPP >> docker ps
BELOW NAME OF THE CONTAINER IS >nginx_php_mysql_app_1:80;



/etc/nginx/conf.d/vproapp.conf 
server {
    listen 8080;
    server_name localhost;
    location / {
        proxy_pass http://nginx_php_mysql_app_1:80;
    }
}

