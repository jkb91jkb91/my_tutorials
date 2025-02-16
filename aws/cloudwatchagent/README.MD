# 0 IAM ROLE for EC2  
# 1 Downlaod agent  
# 2 Paste configuration to config >> Logs(apache) && Metrics  
# 3 Run  

# 0 IAM ROLE for EC2  
Create custom role cloudwatch-ec2  
CloudWatchAgentServerPolicy  
CloudWatchFullAccess  

# 1 Downlaod agent
```
wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E amazon-cloudwatch-agent.deb
```
check json

```
sudo cat /opt/aws/amazon-cloudwatch-agent/bin/config.json | jq .
```
# 2 Paste configuration to config  

# 3 Run
```
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl     -a fetch-config     -m ec2     -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json     -s
```
