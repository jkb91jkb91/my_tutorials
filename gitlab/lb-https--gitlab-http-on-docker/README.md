
# WAIT FEW MINUTES TO CHECK IF GITLAB WORKS

IT IS BETTER TO RUN GITLAB AS NORMAL SERVER NOT DOCKER BECAUSE OF COMPLICITY

1. export

```
sudo apt-get install docker-compose
sudo apt update && sudo apt install -y apt-utils

export GITLAB_HOME=$(pwd)
sudo docker-compose up -d

```

2. RESTART DEFAULT PASSWORD  
```
sudo docker exec -it gitlab bash
sudo gitlab-rake "gitlab:password:reset"
root
YourNewPassword123
```
3. LOGIN WITH NEW CREDENTIALS
