# INFO
jenkins run with casc.yaml in container  
docker agents dynamically run on host  


STEP1
YOU HAVE TO PUT IP OF HOST >>> to casc.yaml , use ip addr show  


STEP2  
in docker config >>  
 sudo vim /lib/systemd/system/docker.service  
set this >> ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock  

STEP3  
sudo systemctl daemon-reload  
sudo systemctl restart docker  

# HOW TO RUN
docker build -t jenkins_image . && docker run -d --name jenkins -v /var/run/docker.sock:/var/run/docker.sock --rm -p 8080:8080 -p 50000:50000 jenkins_image
