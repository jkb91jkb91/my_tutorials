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
