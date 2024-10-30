# JENKINS ON HTTPD REVERSE PROXY WITH JCASC

```
version: '3.7'

services:
  apache:
    build:
      context: .
      dockerfile: Dockerfile.httpd
    container_name: apache
    volumes:
      - ./httpd.conf:/usr/local/apache2/conf/httpd.conf
    ports:
      - "80:80"
    networks:
      - kuba_network

  jenkins:
    build:
      context: .
      dockerfile: Dockerfile.jenkins
    container_name: jenkins
    networks:
      - kuba_network

networks:
  kuba_network:
```

# RUN DOCKER COMPOSE  
```
docker-compose up -d
```


