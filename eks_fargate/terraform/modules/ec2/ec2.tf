data "aws_ami" "al2023" {
  owners      = ["137112412989"] # Amazon
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment_name
    Cluster     = var.cluster_name
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  subnet_id                   = var.private_subnet_for_bastion_host_id
  associate_public_ip_address = true
  iam_instance_profile        = var.iam_role #aws_iam_instance_profile.bastion.name
  vpc_security_group_ids      = [var.aws_security_group_bastion_id]
  tags = merge(local.common_tags, {
    Name = "${var.vpc_name}-ec2-bastion-host"
  })


  user_data = <<-EOF
    #!/bin/bash
    set -e
    dnf -y update
    dnf -y install unzip
    curl -sSL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x /usr/local/bin/kubectl
    mkdir -p /home/ec2-user/.kube
    aws eks update-kubeconfig --region us-east-1 --name fargate --kubeconfig /home/ec2-user/.kube/config
    chown -R ec2-user:ec2-user /home/ec2-user/.kube
    chmod 600 /home/ec2-user/.kube/config
    kubectl patch deployment coredns -n kube-system --type json -p='[{"op": "remove", "path": "/spec/template/spec/tolerations"}]' # THIS IS REQUIRED TO NOT HAVE coreDns as PENDING >>>https://repost.aws/questions/QUCuFoRCw4SQuLKhUZFeM9Xw/coredns-pods-in-eks-fargate-are-in-pending-state-and-the-addon-is-in-error-due-to-insufficientnumberofreplicas
  EOF

  # Enforce IMDSv2 as good practice
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size = 16
    volume_type = "gp3"
    encrypted   = false
  }
}

