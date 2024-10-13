FROM jenkins/jenkins:lts


USER root
#RUN apt-get update && apt-get install -y groovy && apt-get clean

#INSTALACJA WTYCZEK
COPY plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

#COPY DSL JOBS
#COPY dsl_jobs/ /var/lib/jenkins/dsl_jobs/

# CHECK IF DSL INSTALLED
#COPY configs/check_if_dsl_installed.groovy /usr/share/jenkins/ref/init.groovy.d/check_if_dsl_installed.groovy

# JCASC
COPY configs/casc.yaml /var/jenkins_home/casc_configs/jcasc.yaml
ENV CASC_JENKINS_CONFIG=var/jenkins_home/casc_configs/jcasc.yaml
