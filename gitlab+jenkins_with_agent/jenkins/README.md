# 1 Pamietaj gdy wszystko postawisz zrob docker restart jenkins zeby sprawdzic czy wszystko dziala.
Importuje jcasc co jakis czas, musisz podmieniac go manualnie  
W innym wypadku przy restarcie jcasc uruchomi zawsze to co ma w konfiguracji wiec tracisz dane  



Gdy wejdziesz do kontenera i sprawdzisz id usera to jenkins ma 1000
```
docker exec -it jenkins bash
id # 1000
```

Tworzymy volume i nadajemy prawa do zapisu przez usera jenkins  
W kontenerze glowny user to jenkins  

```
mkdir jenkins_home
chown -R 1000:1000 jenkins_home

docker-compose up -d
```


# ENABLE SSH ON PRIVATE IP IN VPC TO PRIVATE IP GITLAB
REQUIRED FOR MULTIBRANCH PIPELINE WITH GITLAB


```
docker exec -it jenkins bash
```


BELOW IS MAPPED IN docker-compose.yaml >> look into docker-compose.yaml
BELOW IS NECESSARRY TO ENABLE SSH NOT ON PUBLIC DOMAIN > gitlab.projectdevops.eu <<  
THIS DOMAIN WILL BE MAPPED INTO HostName 10.0.3.2  
SO THE SSH TRAFFIC WILL BE ROUTED TGROUGH INTERNAL IP  
 
Create private-key > ~/.ssh/gitlab-key  
ADD to ~/.ssh/config    
```
chmod 600 ./ssh_config/gitlab-key  
chmod 644 ./ssh_config/config  
```

/var/jenkins_home/.ssh/config  
```
Host gitlab.projectdevops.eu
    HostName 10.0.3.2
    User jenkins
    IdentityFile ~/.ssh/gitlab-key
```

NA KONTENERZE MUSIMY NADAC NORMALNE UPRAWNIENIA
```
chmod 600 /var/jenkins_home/.ssh/gitlab-key
jenkins@3afafe0430e0:~/.ssh$ ssh -p 2022 git@gitlab.projectdevops.eu # sprawdzamy polaczenie
```

# ADD DYNAMIC DOCKER AGENT
Put into jenkins-casc.yaml
```
jenkins:
  clouds:
    - docker:
        containerCap: 3  # Maksymalna liczba kontenerów
        dockerApi:
          connectTimeout: 23  # Timeout dla połączenia
          dockerHost:
            uri: "unix:///var/run/docker.sock"  # Lokalny Docker daemon
          readTimeout: 43  # Timeout dla odczytu
        errorDuration: 313  # Czas trwania błędów
        name: "my-docker-cloud"  # Nazwa chmury Dockera
        templates:
          - connector:
              jnlp:
                jenkinsUrl: "http://jenkins:8080/"  # Adres kontenera Jenkinsa w sieci Dockera
                user: "1000"  # UID użytkownika
            dockerTemplateBase:
              cpuPeriod: 0
              cpuQuota: 0
              image: "jenkins/inbound-agent:latest-alpine-jdk21"  # Obraz agenta
            labelString: "alpine jdk21 alpine-jdk21 git-2.43"  # Etykiety agenta
            name: "alpine-jdk21"  # Nazwa agenta
            pullTimeout: 171  # Timeout pobierania obrazu
            remoteFs: "/home/jenkins/agent"  # Katalog roboczy w kontenerze
```
