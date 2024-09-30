helm repo add jenkins https://charts.jenkins.io
helm repo update
helm pull jenkins/jenkins
tar -xf jenkins.tgz
