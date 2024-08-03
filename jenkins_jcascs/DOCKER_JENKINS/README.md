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
| BUILD             | docker build -t jenkins:latest .                                                              | 
| RUN               | docker run -p 8080:8080 -p 50000:50000 -d jenkins:latest                                      | 


<!-- DETAILS -->
## DETAILS  
Dockerfile requires:  
plugins/plugins.txt  
config/check_if_dsl_installed.groovy  
config/casc.yaml  
dsl_jobs/freestyle_JOB.groovy  
dsl_jobs/pipeline_JOB_A.groovy  

Folder: ALTERNATIVE_SCRIPT/init.groovy.d # it is alternative method not used in this tutorial  



Content of plugins.txt:
|--------------------|  
| workflow-aggregator|   
| git                |  
| job-dsl            |  
