# 1 PACKAGE REGISTRY JFROG
# 2 Docker REGISTRY JFROG






# 1 Package REGISTRY JFROG

https://www.youtube.com/watch?v=PyF73VTIWVM  

USE THIS SITE TO FOLLOW: https://www.coachdevops.com/2023/01/install-artifactory-using-docker.html
SITE JFROG
https://jfrog.com/download-jfrog-platform/


PREVIOUS RELEASES> https://jfrog.com/download-legacy/

1.) DOWNLOAD FILE with SCRIPT FROM above site for DOCKER COMPOSE  
2.) CHANGE DOCKER_COMPOSE FILE  
3.) CHANGE IMAGE, dont download pro version > docker.bintray.io/jfrog/artifactory-oss:7.49.6  
4.) untar file from point 1  
5.) cd untared file/templates && vim docker-compose.yaml  
6.) sudo hostnamectl set-hostname Artifactory  

7.) Paste this
```
version: "3.3"  
services:  
  artifactory-service:  
    image: docker.bintray.io/jfrog/artifactory-oss:7.49.6  
    container_name: artifactory  
    restart: always  
    networks:  
      - ci_net  
    ports:  
      - 8081:8081  
      - 8082:8082  
    volumes:  
      - artifactory:/var/opt/jfrog/artifactory  
volumes:  
  artifactory:  
networks:  
  ci_net:  
```

8.) sudo docker-compose up -d   

# 2 Docker REGISTRY JFROG + artifactory-config/artifactory.config.import.xml
```
version: "3.3"
services:
  artifactory-service:
    image: docker.bintray.io/jfrog/artifactory-jcr:latest 
    container_name: artifactory
    restart: always
    networks:
      - ci_net
    ports:
      - 8081:8081
      - 8082:8082
    volumes:
      - jfrog:/var/opt/jfrog/artifactory
      - ./artifactory-config:/var/opt/jfrog/artifactory/etc/artifactory
    environment:
      - JCR_HOME=/var/opt/jfrog/artifactory

volumes:
  jfrog:
networks:
  ci_net:
```

```
GeneralConfiguration: 
  eula: 
    accepted: true  # Akceptacja EULA
    
OnboardingConfiguration:
  repoTypes:
    - docker
    - helm  # Typy repozytoriów, które chcesz włączyć
```
