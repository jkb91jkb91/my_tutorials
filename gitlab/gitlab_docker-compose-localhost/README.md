

# WAIT FEW MINUTES TO CHECK IF GITLAB WORKS

IT IS BETTER TO RUN GITLAB AS NORMAL SERVER NOT DOCKER BECAUSE OF COMPLICITY >>> BELOW UBUNTU 24
```
sudo apt update && sudo apt upgrade -y && sudo apt install -y ca-certificates curl gnupg && sudo install -m 0755 -d /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null && sudo chmod a+r /etc/apt/keyrings/docker.asc && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && sudo usermod -aG docker $USER && newgrp docker && sudo systemctl enable --now docker && docker --version && docker compose version && sudo systemctl status docker
```
1. export

```
sudo apt-get install docker-compose
sudo apt update && sudo apt install -y apt-utils

export GITLAB_HOME=$(pwd)
sudo docker-compose up -d

sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password

PASSWORD RESET FOR ROOT AND SET new_password
sudo docker exec -it gitlab bash -c "gitlab-rails console -e production <<EOF
user = User.find_by(username: 'root')
user.password = 'new_password'
user.password_confirmation = 'new_password'
user.save!
EOF"

```
