# JCASC(jenkins configuration as code) jenkins on Docker  


<!-- Details -->  
1. [About The Project](#About-The-Project)
2. [HOW TO RUN](#HOW-TO-RUN)
3. [Dockerfile description](#Dockerfile-description)
4. [Config description](#Config-description)
5. [Plugin description](#Plugin-description)
6. [DSL JOBS](#DSL-JOBS)
7. [Others](#Others)


<!-- ABOUT THE PROJECT -->  
## About The Project   
Run Jenkins with jcasc  
-automatically added user after init  
-automatically installed plugins   
-automatically added pipeline JOB  
-automatically added freestyle JOB  



<!-- HOW TO RUN -->
## HOW TO RUN

| Step              | COMMAND                                                                                       |
|-------------------|-----------------------------------------------------------------------------------------------|
| BUILD             | docker build -t customized_jenkins .                                                          | 
| RUN               | docker run -p 8080:8080 -p 50000:50000 -d customized_jenkins                                  | 


<!-- DOCKERFILE -->
## Dockerfile description  
Dockerfile requires: 

Dockerfile dependencies
|--------------------|  
| plugins/plugins.txt                  |   
| config/check_if_dsl_installed.groovy |  
| config/casc.yaml                     |
| dsl_jobs/freestyle_JOB.groovy        |
| dsl_jobs/pipeline_JOB_A.groovy       |

Take a look in Dockerfile that we use path:  
/usr/share/jenkins/ref  
not /var/lib/jenkins  

Files from /usr/share/jenkins/ref will be copied to /var/lib/jenkins  
In normal VM installation you can use /var/lib/jenkins  
```
FROM jenkins/jenkins:lts


USER root
RUN apt-get update
RUN apt-get install -y groovy
RUN apt-get clean

#INSTALACJA WTYCZEK
COPY plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

#COPY DSL JOBS
COPY dsl_jobs/ /var/lib/jenkins/dsl_jobs/

# CHECK IF DSL INSTALLED
COPY configs/check_if_dsl_installed.groovy /usr/share/jenkins/ref/init.groovy.d/check_if_dsl_installed.groovy


# JCASC
COPY configs/casc.yaml /var/jenkins_home/casc_configs/jcasc.yaml
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jcasc.yaml


#ALTERNATIVE WAY OF USING DOCKER AND JENKINS
#RUN jenkins-plugin-cli --plugins configuration-as-code git job-dsl
#Copy init script
#COPY init.groovy.d /usr/share/jenkins/ref/init.groovy.d/
#COPY JCASC
#COPY casc.yaml /var/jenkins_home/casc_configs/jcasc.yaml
#ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc_configs/jcasc.yaml
```

<!-- CONFIGS -->
## Configs description  
In config folder there are 2 required scripts  
-casc.yaml                     #Jenkins configuration as file
-check_if_dsl_installed.groovy #Required to seed JENKINS JOBS  
```
jenkins:
  securityRealm:
    local:
      allowsSignup: false
      users:
        - id: "kuba"
          password: "kuba"
  authorizationStrategy:
    loggedInUsersCanDoAnything:
      allowAnonymousRead: false
credentials:
  system:
    domainCredentials:
    - credentials:
      - string:
          description: "TERRAFORM_CLOUD_TOKEN"
          id: "TERRAFORM_CLOUD_TOKEN"
          scope: GLOBAL
          secret: "{AQAsdsdsdsda3fsdfsfsdfsdfsfsdfsdfsdf=}"
```

<!-- Plugins -->
## Plugins description  
Content of plugins.txt:

plugins.txt
|--------------------|  
| workflow-aggregator|   
| git                |  
| job-dsl            |  

You have to know that job-dsl is required to seed jenkins JOBS
Installation of this plugin is checked by script configs/check_if_dsl_installed.groovy 


<!-- DSL JOBS -->
## DSL JOBS , 3 different types of jenkins JOBS will be imported
In folder dsl_jobs we have three different examples that will be uploaded to JENKINS instance  
-pipeline job from repo # based on json file from repository  
-freestyle job # fully written  
-pipeline_job_from_code   


<!-- Others -->
## Others  
Folder: ALTERNATIVE_SCRIPT/init.groovy.d # it is alternative method not used in this tutorial    
