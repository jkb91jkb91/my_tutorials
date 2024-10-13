# CREATE JENKINS ON DOCKER WITH ONE DOCKER STATIC AGENT 
Run script createagent.sh and pass there VM_IP of your VM  



# INFO
This script uses jcasc for:  
-create kuba:kuba user  
-install necessarry plugin (instance-identity required to have AGENT)  

# Result
After using this script you will have 2 containers running  
-jenkins  
-docker agent already connected  
