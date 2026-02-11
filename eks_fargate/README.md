#  EKS ON FARGATE: 
#  PLATFORM TO LAUNCH CRONJOBS THAT SEND LOGS INTO CLOUDWATCH  

## WHAT YOU GET  #############################################################################  
With only one command you will get:  
1.) Fully working EKS on Fargate  
2.) EC2 bastion host without public IP  
3.) Fully configured and working kubectl connection  

Whole setup is placed into terraform modules:  

## ✅ What’s included?

| Component                   |  Description                                      |
|-----------------------------|---------------------------------------------------|
| **Terraform**               | Modular infrastructure definition                 |
| `modules/vpc`               | VPC with public and private subnets               |
| `modules/vpc_endpoints`     | For Bastion host in priv subnet to connect SSM    |
| `modules/sg`                | Security Groups                                   |
| `modules/iam`               | IAM roles and policies for EKS                    |
| `modules/eks`               | EKS                                               |
| `dev.auto.tfvars`           | Example configuration with domain and certificate |

---



############################ PRACTICAL PART ################################################  
############################################################################################
## PREQUISUITES  ##############################################################################  
1. **AWS credentials** configured in your local environment or use SSO ( not included in this project )  

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
```

or set your ~/.aws/credentials  
```
[default]
aws_access_key_id = "your-access-key"
aws_secret_access_key = "your-secret-key"
```
## DEPLOYMENT  #############################################################################  
1. 🚀 Deploy resources  

```
cd <PROJECT>
terraform init
terraform plan
terraform apply
```

## CONNECTING INTO CLUSTER  #################################################################   

1. Connection to AWS from your machine is done by using SSM Agent. EC2 does not use public IP.
```
aws ssm start-session --target i-XXXXXXXXXXXX --region <region>
kubectl get pods
```






########################################## THEORETICAL PART ##################################  
##############################################################################################  
## EKS  WORKLOAD TYPE ########################################################################  
1) Fargate (serverless pods)  
-Lack of Nodes (serverless)  
-You pay only for used CPU/RAM  

Advantages  
```
1) No infrastructure management
2) Easy to start with
```

Disadvantages  
```
1) No deamon sets
2) sometimes it might cost more during highest overloads
```

## EKS RESOURCES  
###############################################################################################  
Strikethrough lines shows which resources are required for EKS on EC2  
It is clearly visible how much simple is EKS on Fargate without Nodes on EC2s  

1) VPC/subnets  
1) OIDC  (connected with issuer)  
2) EKS Control Plane  
    - name  
    - role  
    - vpc_config  
~~4) Managed Node Group~~     
    ~~- cluster_name~~                        
    ~~- node_role_arn~~                    
    ~~- subnets_ids~~              
    ~~- ami_type~~                         
    ~~- capacity_type~~     
    ~~- scalling_config~~    
6) Managed add-ons  
    - cni  
    - coredns  
    - kubeproxy  
  ~~- ebs_csi~~           
7) IAM Role eks_cluster  
~~8) IAM Role eks_node~~    
   ~~- arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy~~    
   ~~- arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy~~   
   ~~- arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly~~   
8) Access Entries ( instead aws-auth ) # Responsible for access into CLUSTER  
9) EKS Access Policy association   

## CREATE CRON JOB IN THE CLUSTER  
1) Create namspace for jobs  
```
kubectl create ns job-ns
```
2)
```

```

## HOW TO CONFIGURE CLOUDWATCH LOGS FOR RUNNING POD  
1) Create namespace  aws-observability  
```
apiVersion: v1
kind: Namespace
metadata:
  name: aws-observability
  labels:
    aws-observability: enabled
```
2) Create Config-Map aws-logging  inside of the aws-observability  namespace  


## HOW TO LOG IN INTO CLUSTER FROM BASTION HOST EC2  
###############################################################################################   
FOR LOGGING INTO CLUSTER WE HAVE TWO OPTIONS >>>  
    - Access Entries <<< preferred and used below  
    - aws-auth  

