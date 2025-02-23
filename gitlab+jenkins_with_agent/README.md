
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
4. Docker agent configuration
5. Plugins
6. Connect with Gitlab

# 0. Prerequisuites for dynamic docker AGENT



a) USE THIS SETTINGS ONLY IF YOUR AGENT IS SETUP REMOTELY  NOT USE IN THIS TUTORIAL !!!!
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
b) USE THIS FOR THIS TUTORIAL ON LOCAL HOST MACHINE TO START DOCKER AGENT <<< USE THIS

jenkins-casc.yaml
```
clouds:
  - docker:
      containerCap: 3
      dockerApi:
        connectTimeout: 23
        dockerHost:
          uri: "unix:///var/run/docker.sock"
```

Dockerfile.agent
Agent to copy repository uses keys so you have to prepare IMAGE  
In this image you have to place ssh keys and config and known host to eneable cloning repository
```
FROM jenkins/agent


USER root
RUN mkdir -p /home/jenkins/.ssh
# Skopiowanie plików SSH z build context do obrazu
COPY ssh_config/config  /home/jenkins/.ssh/config
COPY ssh_config/gitlab-key /home/jenkins/.ssh/gitlab-key


USER root
# Ustawienie odpowiednich uprawnień dla katalogu i plików SSH
RUN chmod 700 /home/jenkins/.ssh 
RUN chmod 600 /home/jenkins/.ssh/gitlab-key 
RUN chmod 644 /home/jenkins/.ssh/config 
RUN chown -R jenkins:jenkins /home/jenkins/.ssh

COPY ssh_config/known_hosts /home/jenkins/.ssh/known_hosts
RUN chown jenkins:jenkins /home/jenkins/.ssh/known_hosts


USER jenkins
```

```
docker login 
docker build --no-cache -t jkb91/custom_agent:5.0 -f Dockerfile.agent .
docker push jkb91/custom_agent:5.0
```

IN GUI on the settings you have to set >> https://jenkins.projectdevops.eu/manage/cloud/my-docker-cloud/configure >> Docker Agent Templates: Docker Image: jkb91/custom_agent:5.0  

Set  
In GUI >> https://jenkins.projectdevops.eu/manage/configureSecurity/ >> Host Key Verification Stratedy >> No Verfication  


# 1. Quick Start
```
docker create volume jenkins_data
docker-compose up -d
```

# 2. Docker Image and docker-compose
Installing requires root
On the end set jenkins user

Allow jenkins user to use docker to run docker agent locally
a) check >> getent group docker # docker:x:994:kuba  >> ARG DOCKERGID=994 >> Add jenkins user to docker group inside of the container  
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

File docker-compose.yaml  

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

# 3. Adding SSH to ~/.ssh/config to map DOMAIN on INTERNAL_IP not Public_IP >> ONLY ON AGENT IMAGE REQUIRED
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

DO ONLY IF ON JENKINS YOU WONT DISABLE >> CHECKING KNOWN_HOSTS>> IF YOU DISABLE IT > BELOW IS NOT REQUIRED  
After starting jenkins possibly below also will be required   
SSH PORT OF JENKINS: 2022 # for my case instead of 22 I used 2022  
domain where gitlab runs: gitlab.projectdevops.eu  
gitlab.projectdevops.eu  IP: 10.0.3.2
```
docker exec -it agent bash
ssh-keyscan -p 2022 -t rsa 10.0.3.2:2022  >> ~/.ssh/known_hosts

```

#4. Docker agent configuration
look in section >> required for dynamic-agent  


# 5 Plugins: Better to give directly PLUGIN VERSIONS
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

# 6 Connect with Gitlab
Agent Image has to have ssh keys inside and in Jenkins turn off known_hosts
