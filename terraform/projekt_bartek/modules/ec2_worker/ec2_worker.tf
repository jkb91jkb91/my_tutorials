

locals {
  common_tags = {
    Name = "Worker"
    Owner_2 = "bartek"
    Project = "devops_project_aws"
  }
}

resource "aws_instance" "instance" {
  count         = var.ec2_count
  ami           = var.ami_us_east_2
  instance_type = var.ec2_instance_type
  tags          = local.common_tags
  subnet_id     = var.public_subnet_ids[0]
  
  vpc_security_group_ids = [var.sg_id]
}

# resource "local_file" "TF_key" {
#   content    = tls_private_key.rsa.private_key_pem
#   filename   = "tfkey"
#   provisioner "local-exec" {
#     command  = "chmod 400 tfkey"
#   }
# }

# resource "aws_key_pair" "TF_key" {
#   key_name   = "TF_key"
#   public_key = tls_private_key.rsa.public_key_openssh
# }

# # RSA key of size 4096 bits
# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }