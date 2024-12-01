
# INFORMATIONS
-Setup of Jenkins run on docker + dynamic docker agent  
-Jenkins is based on jcasc  
-After makins some changes in GUI remember to save and replace jcasc file on host manually  
-In Dockerfile install with root user but run finally with jenkins user  
-Docker Agent has to use this >> unix:///var/run/docker.sock so in image you have to add jenkins to docker group  
-Dynamic docker agent is described in jcasc  
-Remember that if container restart it will launch with "default" jcasc config so each new changes you have to add to jcasc config made in GUI  
-USE docker volumes instead of volumes mapping >> its recomended  
-After starting Jenkins remember to test persistence with docker restart jenkins  
-Always use specific version of IMAGE of Jenkins  
-Alwasy use specific PLUGIN VERSIONS  
-Container is run as jenkins user but for debugging you can enter with root later >> docker exec -u root -it jenkins bash  

AGENT
-your agent has to has privilleges to clone repo and so on


How it works
Load Balancer on gcp points to domain on GoDaddy  
GoDaddy has to A records  
-gitlab.projectdevops.eu  
-jenkins.projectdevops.eu  

GODADDY
a	@	34.49.185.177  
cname	gitlab	projectdevops.eu.  
cname	jenkins	projectdevops.eu.  


Why to use LoadBalancer here ??
Because jenkins and gitlab are in VPC with only internal IP addresses
LoadBalancer hides them  
LoadBalancer can use IAP to give privilleges only for specifif users  


# Details
0. Prerequisuites
1. Quick Start  
2. Descriptions of docker Image
3. Adding SSH to ~/.ssh/config to map DOMAIN on INTERNAL_IP not Public_IP
4. Connect with Gitlab

# 0. Prerequisuites for dynamic docker AGENT
You have to go into docker settings
```
sudo vim /lib/systemd/system/docker.service
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
```
Sprawdzamy IP dockera i wstawiamy do jenkins-casc.yaml
```
ip addr show | grep docker0 | tail -n1 | awk '{print $2}' | cut -d'/' -f1 #172.17.0.1
```
```
clouds:
  - docker:
      containerCap: 3
      dockerApi:
        connectTimeout: 23
        dockerHost:
          uri: "tcp://172.17.0.1:2375"
```

# 1. Quick Start
```
docker create volume jenkins_data
docker-compose up -d
```

# 2. Docker Image and docker-compose
```
FROM jenkins/jenkins:2.479.1-lts
USER root
# Skopiowanie pliku plugins.txt do kontenera
COPY plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
# Instalowanie wtyczek z plugins.txt
RUN jenkins-plugin-cli --plugins $(cat /usr/share/jenkins/ref/plugins.txt)
COPY dsl_jobs/ /var/lib/jenkins/dsl_jobs/
RUN apt-get update && apt-get install -y groovy && apt-get clean && apt-get install -y vim
COPY configs/disable-initial-setup.groovy /usr/share/jenkins/ref/init.groovy.d/disable-initial-setup.groovy
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ARG DOCKERGID=994
# Setup users and groups: Required for dynamic docker agent
RUN addgroup --gid ${DOCKERGID} docker
RUN usermod -aG docker jenkins
USER jenkins
```
You can read also about this case here:  
```
https://stackoverflow.com/questions/63095927/give-permission-to-jenkins-to-access-unix-var-run-docker-sock
```

docker-compose.yaml  

required for dynamic-agent
```
volumes
  - /var/run/docker.sock:/var/run/docker.sock
```

```
version: '3.8'

services:
  jenkins:
    build:
      context: . 
      dockerfile: Dockerfile
    container_name: jenkins
    ports:
      - "80:8080"    #Map to local port 80
      - "50000:50000"  #Port dla agentów
    volumes:
      - jenkins_data:/var/jenkins_home  
      - ./jenkins-casc.yaml:/var/jenkins_conf.yaml
      - ./ssh_config/config:/var/jenkins_home/.ssh/config
      - ./ssh_config/gitlab-key:/var/jenkins_home/.ssh/gitlab-key
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
    environment:
      - CASC_JENKINS_CONFIG=/var/jenkins_conf.yaml

volumes:
  jenkins_data:
    driver: local
```

# 3. Adding SSH to ~/.ssh/config to map DOMAIN on INTERNAL_IP not Public_IP 
We want to make git clone by only internal IP address of Gitlab so we have to map URL somewhere
in files: ssh_config we have:  
config  
gitlab-key  
gitlab-key.pub  

HostName: 10.0.3.2 is internal IP of gitlab VM  
Below file is already mapped in volume in docker-compose.yaml
```
volumes
  - ./ssh_config/gitlab-key:/var/jenkins_home/.ssh/gitlab-key
```

```
Host gitlab.projectdevops.eu
    HostName 10.0.3.2
    User jenkins
    IdentityFile ~/.ssh/gitlab-key
```

After starting jenkins possibly below also will be required   
SSH PORT OF JENKINS: 2022 # for my case instead of 22 I used 2022  
domain where gitlab runs: gitlab.projectdevops.eu  
```
docker exec -it jenkins bash
ssh-keyscan -p 2022 -t rsa gitlab.projectdevops.eu >> ~/.ssh/known_hosts

```

# 4 Plugins
```
workflow-aggregator
git:5.6.0
job-dsl:1.90
configuration-as-code:1897.v79281e066ea_7
pipeline-stage-view:2.34
generic-webhook-trigger:2.2.5
multibranch-scan-webhook-trigger:1.0.11
gitlab-api:5.6.0-97.v6603a_83f8690
gitlab-branch-source:715.v4c830b_ca_ef95
gitlab-plugin:1.9.6
jersey2-api:2.44-151.v6df377fff741
credentials-binding:687.v619cb_15e923f
docker-plugin:1.7.0
```

# 5 Connect with Gitlab
Add to known_hosts
```
root@5a4705f118d1:/var/jenkins_home/.ssh# touch known_hosts
root@5a4705f118d1:/var/jenkins_home/.ssh# chmod 600 known_hosts 
root@5a4705f118d1:/var/jenkins_home/.ssh# ssh-keyscan -p 2022 gitlab.projectdevops.eu >> known_hosts
root@5a4705f118d1:/var/jenkins_home/.ssh# 
```
