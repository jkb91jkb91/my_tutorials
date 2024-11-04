


```
# Pobierz GitLab Runner
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Nadaj uprawnienia do uruchamiania pliku
sudo chmod +x /usr/local/bin/gitlab-runner

# Zainstaluj i uruchom GitLab Runner jako usługę
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start



sudo curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-`uname -s`-`uname -m` -o /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine

sudo gitlab-runner register
```
