

# DESCRIPTION
GoDaddy domain projectdevops.eu  

VPC  

jenkins-subnet >> compute engine without PUBLIC_IP  
gitlab-subnet  >> compute engine without PUBLIC_IP  

LoadBalancer gitlab.projectdevops.eu   IAP turned ON  
LoadBalancer jenkins.projectdevops.eu  IAP turned ON  



CONNECTION SSH WILL BE BY USING INTERNAL NETWORK VPC 


To not disturb local sshd 22 map port to 2022 and notify gitlab
```
gitlab_rails['gitlab_shell_ssh_port'] = 2022
```

LoadBalancer resolves HTTPS <--------80-------> compute engines
  

```
version: '3'

services:
  web:
    build:
      context: ./
      dockerfile: Dockerfile.gitlab
    container_name: gitlab
    restart: always
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'https://gitlab.projectdevops.eu'
        gitlab_rails['gitlab_shell_ssh_port'] = 2022
        nginx['redirect_http_to_https'] = false
        nginx['listen_port'] = 80

gitlab_rails['initial_root_password'] = 'rootroot'
    ports:
      - "80:80"
      - "2022:22"
    volumes:
      - '/home/kuba/gitlab_backup/config:/etc/gitlab'
      - '/home/kuba/gitlab_backup/logs:/var/log/gitlab'
      - '/home/kuba/gitlab_backup/data:/var/opt/gitlab'
```



# Jenkins Setup
The most important part on jenkins is to notify that domain
```
gitlab.projectdevops.eu
```
will be mapped to local internalIP address in ~/.ssh/config

```
root@a818cdc69506:/# cat ~/.ssh/config
Host gitlab.projectdevops.eu
    HostName 10.0.3.2
    User root
    IdentityFile /var/jenkins_home/.ssh/gitlab-key
```


# Run Jenkins

