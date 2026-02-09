#  EKS PLATFORM: MANAGED NODE

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

1. **AWS credentials** configured in your local environment    

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

## EKS  WORKLOAD TYPES #######################################################################################
There are 4 types of running workloads  
1)  Managed Node Groups (EC2)  

2) Self-managed nodes (EC2, own ASG)  
3) Karpenter (EC2 without ASG)  
4) Fargate (serverless pods)

```
Managed Node Groups (EC2, zarządzane przez EKS)

EKS tworzy ASG + LT za Ciebie.

Plusy: prostota, aktualizacje rolling, integracja z eksctl/Terraform.

Minusy: nadal zarządzasz EC2 (AMI, pojemność, koszty).

Self-managed nodes (EC2, własne ASG)

Sam tworzysz ASG/Launch Template i dołączasz węzły do klastra.

Plusy: pełna kontrola (np. niestandardowe AMI).

Minusy: najwięcej operacyjnej roboty.

Karpenter (EC2 bez ASG)

Provisoner skaluje bezpośrednio instancje EC2 pod potrzeby Podów.

Plusy: świetne dopasowanie rozmiaru/typów, szybki scale-up, niższe koszty.

Minusy: nowy komponent do utrzymania, inny model niż ASG.

Fargate (serverless pods)

Bez węzłów EC2/ASG — płacisz za CPU/RAM Podów.

Plusy: zero zarządzania infrastrukturą, dobry dla małych/niekrytycznych zadań.

Minusy: ograniczenia sieci/daemonów/CSI, wyższy koszt przy stałym obciążeniu.
```



## EKS RESOURCES  
#########################################################################################################
1) VPC/subnets  
1) OIDC  (connected with issuer)  
2) EKS Control Plane  
    - name  
    - role  
    - vpc_config  
4) Managed Node Group  
    - cluster_name  
    - node_role_arn  
    - subnets_ids  
    - ami_type  
    - capacity_type  
    - scalling_config  
6) Managed add-ons  
    - cni  
    - coredns  
    - kubeproxy  
    - ebs_csi  
7) IAM Role eks_cluster  
8) IAM Role eks_node  
   - arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy  
   - arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy  
   - arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
7) Access Entries ( instead aws-auth ) # Responsible for access into CLUSTER   
8) EKS Access Policy association   

## EKS LOGGING INTO CLUSTER  
#########################################################################################################
FOR LOGGING INTO CLUSTER WE HAVE TWO OPTIONS >>>  
    - Access Entries <<< preferred and used below  
    - aws-auth  

