
```
mkdir jenkins_home
chown -R jenkins:jenkins

docker-compose up -d
```


# ENABLE SSH ON PRIVATE IP IN VPC TO PRIVATE IP GITLAB
REQUIRED FOR MULTIBRANCH PIPELINE WITH GITLAB


```
docker exec -it jenkins bash
```

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
