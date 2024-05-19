#PREREQUISUITES
# SET AWS CLI
# terraform init


# PARAMETERS
# ec2_count default value         = 1
# ec2_instance_type default value = t2.micro

########  HOW TO RUN TERRAFORM ########

#1) WITHOUT PARAMETERS WITH DEFAULT VALUES
## terraform apply

#2) WITH PASSED PARAMETER ec2_count and DEFAULT VALUE ec2_instance_type 
## terraform apply -var="ec2_count=2"

#3) WITH PASSED PARAMETER ec2_instance_type and DEFAULT VALUE ec2_count
## terraform apply -var="ec2_instance_type=t3.large"

#4)WITH PASSED BOTH PARAMETERS
## terraform apply -var="ec2_instance_type=t2.large" -var="ec2_instance_type=t2.small"
 
