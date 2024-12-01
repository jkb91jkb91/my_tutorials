
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
Always use specific version of IMAGE of Jenkins  
-Alwasy use specific PLUGIN VERSIONS  

# Details
1. Quick Start  
2. Descriptions of docker Image
3. Adding SSH to ~/.ssh/config to map DOMAIN on INTERNAL_IP not Public_IP  

# 1. Quick Start
```
docker-compose up -d
```

# 2. Docker Image
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


