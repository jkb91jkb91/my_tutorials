# Firstly install jenkins based on this Dockerfile that set path to /jenkins

```
FROM jenkins/jenkins:lts                                                                                                      ENV JENKINS_OPTS="--prefix=/jenkins"
```
# REQUIRED PLUGIN ON JENKINS >> Wihtout this plugin you wont connect AGENT
Instance Identity

# Create network
docker create network kuba_network


# Port 5000 has to be mapped for AGENT > Run jenkins
docker run -d --name jenkins --rm -p 8080:8080 -p 50000:50000 --network kuba_network customized_jenkins

# IMPORTANT >> ON AGENT YOU WONT USE PROXY ADDRES OF JENKINS
EXAMPLE
docker ps
jenkins   
httpd          reverseproxy jenkins >>> http://IP/jenkins  BUT you still use on your agent http://CONTAINEROFJENKINSNAME:8080/jenkins  <<<< 8080 will stil be here because the connection is not based on proxy
jenkins_agent

# Create in Jenkins GUI AGENT MANUALLY >> Get command from GUI and create container
docker run --init --name work --network kuba_network -d --rm -v /home/jenkins_agent:/var/jenkins_home   jenkins/inbound-agent   -url http://jenkins:8080/jenkins/ -secret f505625119f27df3ecf7a34b395b59939818c8d9d3abea9b9db5b9fddac3b064 -name koworker
#docker run --init -d -v /home/jenkins_agent:/var/jenkins_home   jenkins/inbound-agent   -url http://localhost:8080/jenkins/    f901ac2478dc2121abb80d89106b98e0d3388006198664b41520358134b8b016 worker
