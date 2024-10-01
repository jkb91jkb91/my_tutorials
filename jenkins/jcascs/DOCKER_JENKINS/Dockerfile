# /var/lib/jenkins/ is the main init folder but we have to put scripts into /usr/share/jenkins/ref << from here they will be copied
# When you dont use DOCKER but normal installation then use:
#COPY config/basic-security.groovy /var/lib/jenkins/init.groovy.d/basic-security.groovy
#COPY config/check_if_dsl_installed.groovy /var/lib/jenkins/init.groovy.d/check_if_dsl_installed.groovy
#COPY config/casc.yaml /var/lib/jenkins/casc_configs/casc.yaml


FROM jenkins/jenkins:lts


USER root
RUN apt-get update && apt-get install -y groovy && apt-get clean

#INSTALACJA WTYCZEK
COPY plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

#COPY DSL JOBS
COPY dsl_jobs/ /var/lib/jenkins/dsl_jobs/

# CHECK IF DSL INSTALLED
COPY configs/check_if_dsl_installed.groovy /usr/share/jenkins/ref/init.groovy.d/check_if_dsl_installed.groovy


# JCASC 
COPY configs/casc.yaml /var/jenkins_home/casc_configs/jcasc.yaml
ENV CASC_JENKINS_CONFIG=var/jenkins_home/casc_configs/jcasc.yaml


#ALTERNATIVE WAY OF USING DOCKER AND JENKINS
#RUN jenkins-plugin-cli --plugins configuration-as-code git job-dsl
#Copy init script
#COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d/
#COPY JCASC
#COPY casc.yaml /var/jenkins_home/casc_configs/jcasc.yaml
#ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc_configs/jcasc.yaml
