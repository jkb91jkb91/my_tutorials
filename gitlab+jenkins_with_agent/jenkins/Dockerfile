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
# Setup users and groups
RUN addgroup --gid ${DOCKERGID} docker
RUN usermod -aG docker jenkins

USER jenkins
