# 1

BUILD NGINX IMAGE >> PUSH TO ECR
BUILD STREAMLIT   >> PUSH TO ECR

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 311141565994.dkr.ecr.us-east-1.amazonaws.com
docker build -t my-streamlit-app .
docker tag my-streamlit-app:latest 311141565994.dkr.ecr.us-east-1.amazonaws.com/mdp-navigator-repo:my-streamlit-app
docker push 311141565994.dkr.ecr.us-east-1.amazonaws.com/mdp-navigator-repo:my-streamlit-app

docker build -t nginx .


