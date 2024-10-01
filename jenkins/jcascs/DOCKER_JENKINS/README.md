# JCASC jenkins on Docker  

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


<!-- CONFIGS -->
## Configs description  
In config folder there are 2 required scripts  
-casc.yaml  
-check_if_dsl_installed.groovy # required to seed JENKINS JOBS  

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
## DSL JOBS
In folder dsl_jobs we have three different examples that will be uploaded to JENKINS instance
-pipeline job from repo # based on json file from repository
-freestyle job # fully written
-pipeline_job_from_code 

<!-- DOCKERFILE -->
## DOCKERFILE
Take a look in Dockerfile that we use path:  
/usr/share/jenkins/ref  
not /var/lib/jenkins  

Files from /usr/share/jenkins/ref will be copied to /var/lib/jenkins  
In normal VM installation you can use /var/lib/jenkins  



<!-- Others -->
## Others  
Folder: ALTERNATIVE_SCRIPT/init.groovy.d # it is alternative method not used in this tutorial    
