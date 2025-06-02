



module "vpc" {
  source = "./modules/vpc"
}

# EC2
module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_ec2_subnet_id
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
}



# LB MODULE
module "lb" {
  source     = "./modules/lb"
  vpc_id     = module.vpc.vpc_id
  subnet1_id = module.vpc.public1_subnet_id
  subnet2_id = module.vpc.public2_subnet_id
  ec2_id     = module.ec2.ec2_id
}

# ROUTE53
module "route53" {
  source        = "./modules/route53"
  dns           = module.lb.alb_dns_name
  zone_id       =  module.lb.alb_zone_id
}