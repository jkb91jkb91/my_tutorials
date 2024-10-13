#!/bin/bash



#CREATE DOCKE IMAGE && RUN JENKINS SERVER
docker network create kuba_network
docker build -t customized_jenkins .
docker run -d --name jenkins --rm -p 8080:8080 -p 50000:50000 --network kuba_network customized_jenkins
sleep 40s
echo "WAIT 40s"

VM_IP='35.226.199.36'
export JENKINS_URL=http://localhost:8080
export JENKINS_USER=kuba
export JENKINS_USER_PASS=kuba


JENKINS_CRUMB=$(curl -u "$JENKINS_USER:$JENKINS_USER_PASS" -s --cookie-jar /tmp/cookies $JENKINS_URL'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
sleep 5s
echo "JENKINS_CRUMB=$JENKINS_CRUMB"

JENKINS_API_TOKEN=$(curl -u "$JENKINS_USER:$JENKINS_USER_PASS" -H $JENKINS_CRUMB -s --cookie /tmp/cookies $JENKINS_URL'/me/descriptorByName/jenkins.security.ApiTokenProperty/generateNewToken' --data 'newTokenName=GlobalToken' | jq -r '.data.tokenValue')
sleep 5s
echo "JENKINS_API_TOKEN=$JENKINS_API_TOKEN"

export NODE_NAME=testnode
export JSON_OBJECT="{ 'name':+'${NODE_NAME}',+'nodeDescription':+'Linux+slave',+'numExecutors':+'5',+'remoteFS':+'/home/jenkins/agent',+'labelString':+'SLAVE-DOCKER+linux',+'mode':+'EXCLUSIVE',+'':+['hudson.slaves.JNLPLauncher',+'hudson.slaves.RetentionStrategy\$Always'],+'launcher':+{'stapler-class':+'hudson.slaves.JNLPLauncher',+'\$class':+'hudson.slaves.JNLPLauncher',+'workDirSettings':+{'disabled':+true,+'workDirPath':+'',+'internalDir':+'remoting',+'failIfWorkDirIsMissing':+false},+'tunnel':+'',+'vmargs':+'-Xmx1024m'},+'retentionStrategy':+{'stapler-class':+'hudson.slaves.RetentionStrategy\$Always',+'\$class':+'hudson.slaves.RetentionStrategy\$Always'},+'nodeProperties':+{'stapler-class-bag':+'true',+'hudson-slaves-EnvironmentVariablesNodeProperty':+{'env':+[{'key':+'JAVA_HOME',+'value':+'/docker-java-home'},+{'key':+'JENKINS_HOME',+'value':+'/home/jenkins'}]},+'hudson-tools-ToolLocationNodeProperty':+{'locations':+[{'key':+'hudson.plugins.git.GitTool\$DescriptorImpl@Default',+'home':+'/usr/bin/git'},+{'key':+'hudson.model.JDK\$DescriptorImpl@JAVA-8',+'home':+'/usr/bin/java'},+{'key':+'hudson.tasks.Maven\$MavenInstallation\$DescriptorImpl@MAVEN-3.5.2',+'home':+'/usr/bin/mvn'}]}}}"

# CREATE NODE
curl -L -s -o /dev/null -v -k -w "%{http_code}" -u "${JENKINS_USER}:${JENKINS_API_TOKEN}" -H "Content-Type:application/x-www-form-urlencoded" -X POST -d "json=${JSON_OBJECT}" "${JENKINS_URL}/computer/doCreateItem?name=${NODE_NAME}&type=hudson.slaves.DumbSlave"


#GET AGENT SECRET
echo "****************************************************************"
NODE_SECRET=$(curl -L -s -u ${JENKINS_USER}:${JENKINS_API_TOKEN} -X GET ${JENKINS_URL}/computer/${NODE_NAME}/slave-agent.jnlp | sed "s/.*<application-desc main-class=\"hudson.remoting.jnlp.Main\"><argument>\([a-z0-9]*\).*/\1/"| grep -oP '(?<=<argument>).*?(?=</argument>)')

HASH=$(echo $NODE_SECRET | awk '{print $1}')
echo "*************************************************************************************************"
echo "SECRET FOR NODE=$HASH"

echo "**************************************************************************************************"
echo "CONECT NODE"
docker run --init --name work --network kuba_network -d --rm -v /home/jenkins_agent:/var/jenkins_home   jenkins/inbound-agent   -url http://${VM_IP}:8080 -secret ${HASH} -name testnode
