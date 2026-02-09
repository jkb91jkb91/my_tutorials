#  EKS PLATFORM: FARGATE

---

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

## 🔧 Prerequisites

To run this project, you’ll need:

1. **AWS credentials** configured in your local environment    NOT RECOMMENDED BUT THE SIMPLEST WAY  

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

## 🚀 Deploy resources  

```
terraform init
terraform plan
terraform apply
```

## ARTICLE  ##################################################################################################

🚀 ....

Connection to AWS from your machine is done by using SSM Agent. EC2 does not use public IP.
```
aws ssm start-session --target i-XXXXXXXXXXXX --region <region>
```

## EKS  WORKLOAD TYPE #######################################################################################
1) Fargate (serverless pods)

```
Fargate (serverless pods)
Lack of Nodes, you pay only for CPU/RAM
Advamtages: no infrastructure management, easy to start with
Disadvangates: No deamon sets, sometimes it might cost more during highest overload
```

## EKS RESOURCES  
#########################################################################################################
1) VPC/subnets  
1) OIDC  (connected with issuer)  
2) EKS Control Plane  
    - name  
    - role  
    - vpc_config  
~~4) Managed Node Group  ~~
~~    - cluster_name  ~~
~~    - node_role_arn  ~~
~~    - subnets_ids  ~~
~~    - ami_type  ~~
~~    - capacity_type  ~~
~~    - scalling_config  ~~
6) Managed add-ons  
    - cni  
    - coredns  
    - kubeproxy  
   ~~ - ebs_csi   ~~                                                            # NOT USED ON FARGATE  
7) IAM Role eks_cluster  
~~8) IAM Role eks_node  ~~                                                      # NOT USED ON FARGATE  
~~  - arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy  ~~                     # NOT USED ON FARGATE  
~~   - arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy  ~~                         # NOT USED ON FARGATE  
~~   - arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly ~~            # NOT USED ON FARGATE  
8) Access Entries ( instead aws-auth ) # Responsible for access into CLUSTER    # NOT USED ON FARGATE  
9) EKS Access Policy association   

## EKS LOGGING INTO CLUSTER  
#########################################################################################################
FOR LOGGING INTO CLUSTER WE HAVE TWO OPTIONS >>>  
    - Access Entries <<< preferred and used below  
    - aws-auth  

