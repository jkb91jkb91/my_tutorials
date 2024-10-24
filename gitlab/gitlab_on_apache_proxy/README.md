# INFO
In gitlab you won't set /gitlab , instead you will set only /  
httpd uses httpd.conf configuration from file  
httpd run on 80  
gitlab run on 80:8081 BUT STILL in httpd.conf you will use 80 >>>  

```
<VirtualHost *:80>
    ProxyPreserveHost On

    ProxyRequests Off
    ProxyPass / http://gitlab:80/
    ProxyPassReverse / http://gitlab:80/

    RewriteEngine On
    RewriteCond %{REQUEST_URI} ^/gitlab/(assets/.*|uploads/.*|-/.*|favicon.ico|robots.txt)
    RewriteRule .* http://gitlab:80%{REQUEST_URI} [P,QSA]

    # Proxy dla WebSocketów GitLaba
    RewriteCond %{HTTP:UPGRADE} websocket [NC]
    RewriteCond %{HTTP:CONNECTION} upgrade [NC]
    RewriteRule .* ws://gitlab:80%{REQUEST_URI} [P]

    Header set Access-Control-Allow-Origin "*"
    Header set Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept"
    Header set Access-Control-Allow-Methods "GET, POST, OPTIONS"
</VirtualHost>
```

# HOW TO RUN
docker-compose up -d   


# RUN WITH COMMAND

```
http://localhost:8081/gitlab
```

# RESULT
You will have running gitlab as localhost/gitlab instead of localhost  


# NEXT STEPS
1) Please add http://domain
2) Please add https://domain
