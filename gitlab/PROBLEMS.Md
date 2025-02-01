
git@35.223.44.15:root/gitflow.git <<<< THIS IS NOT VALID LINK >> PORT NOT EXPOSED  
ssh://git@35.223.44.15:2424/root/gitflow.git <<< THIS IS VALID >>> PORT EXPOSED

# docker-compose ssh ports 2424:22 << PROBLEMS WITH SSH 22  
gitlab_rails['gitlab_shell_ssh_port'] = 2424  
UBLOCK 2424 on cloud in such case  
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
        external_url 'http://35.223.44.15:80'
        gitlab_rails['gitlab_shell_ssh_port'] = 2424
    ports:
      - "80:80"
      - "2424:22"
    volumes:
      - '$GITLAB_HOME/config:/etc/gitlab'
      - '$GITLAB_HOME/logs:/var/log/gitlab'
      - '$GITLAB_HOME/data:/var/opt/gitlab' 

```


# SSH CLONE
```git clone ssh://git@35.223.44.15:2424/root/gitflow.git```

# ~/.ssh/config
```
Host 35.223.44.15
  HostName 35.223.44.15
  User root
  IdentityFile ~/.ssh/lab  # wskazujesz konkretny klucz do GitLab
  IdentitiesOnly yes
```

# CLONING

If you set >>> localhost instead of domain/IP address and clone looks like that >> git remote add origin git@localhost:root/gitflow.git  
You want be able to clone even if you have SSH Keys , onlu such will work >> git remote add origin git@25.223.44.15:root/gitflow.git

so in docker-compose set IP/domain name  



```


```
