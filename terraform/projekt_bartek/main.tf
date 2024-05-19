module "vpc" {
 source = "./modules/vpc/"
}


module "ec2" {
 source = "./modules/ec2/"
 ec2_count         = var.ec2_count                 #Przekazujemy w terraform apply argument
 public_subnet_ids = module.vpc.public_subnet_ids
 vpc_id            = module.vpc.vpc_id
}


#data "aws_availability_zones" "available" {
#  state = "available"
#}

#output "list_of_az" {
#  value = data.aws_availability_zones.available.names
#}
