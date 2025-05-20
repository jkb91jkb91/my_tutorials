
# terraform destroy \
#  -target=module.vpc \
#  -target=module.iam \
#  -target=module.sg \
#  -target=module.lb \
#  -target=module.ecs \
#  -target=module.vpcEndpoints




module "vpc" {
  source = "./modules/vpc"
}

# IAM
module "iam" {
  source = "./modules/iam"
}

# SG
module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

# LB MODULE
module "lb" {
  source     = "./modules/lb"
  vpc_id     = module.vpc.vpc_id
  subnet1_id = module.vpc.public1_subnet_id
  subnet2_id = module.vpc.public2_subnet_id
}

# ECS
module "ecs" {
  source               = "./modules/ecs"
  execution_role_arn   = module.iam.execution_role_arn
  task_role_arn        = module.iam.task_role_arn
  ecr_repo_url         = module.ecr.ecr_repo_url
  subnet1_id           = module.vpc.subnet1_id
  subnet2_id           = module.vpc.subnet2_id
  sg1_id               = module.sg.sg1_id
  alb_target_group_arn = module.lb.target_group_arn
  depends_on           = [module.sg, module.vpc, module.lb]
}


# VPC-ENDPOINT
module "vpcEndpoints" {
  source             = "./modules/vpcEndpoints"
  vpc_id             = module.vpc.vpc_id
  endpoint_sg_id     = module.sg.endpoint_sg_id
  task_sg_id         = module.sg.task_sg_id
  priv_subnet1_id    = module.vpc.private1_subnet_id
  priv_subnet2_id    = module.vpc.private2_subnet_id
  s3_route_table_ids = module.vpc.s3_route_table_ids
  depends_on         = [module.sg, module.vpc]
}

# ECR
module "ecr" {
  source                 = "./modules/ecr"
  fargate_extra_role_arn = module.iam.fargate_extra_role_arn
}

# EC2
# module "ec2" {
#   source        = "./modules/ec2"
#   vpc_id        = module.vpc.vpc_id
#   subnet_id     = module.vpc.public_ec2_subnet_id
#   ami           = "ami-04b4f1a9cf54c11d0"
#   instance_type = "t2.micro"
# }












# ROUTE53
# module "route53" {
#   source        = "./modules/route53"
#   dns           = module.lb.alb_dns_name
#   zone_id       =  module.lb.alb_zone_id
# }