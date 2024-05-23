

locals {
  common_tags = {
    Owner_1 = "kuba"
    Owner_2 = "bartek"
    Project = "devops_project_aws"
  }
}

resource "aws_security_group" "web_sg" {
  name        = var.security_group.sg_name
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  ingress {
    from_port   = var.security_group.ssh_port
    to_port     = var.security_group.ssh_port
    protocol    = var.security_group.protocol
    cidr_blocks = var.security_group.cidr_blocks
  }
}

resource "aws_instance" "instance" {
  count         = var.ec2_count
  ami           = var.ami_us_east_2
  instance_type = var.ec2_instance_type
  tags          = local.common_tags
  subnet_id     = var.public_subnet_ids[0]
  
  tags = {
    Name = "Master Node"
  }
  vpc_security_group_ids = [aws_security_group.web_sg.id]
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