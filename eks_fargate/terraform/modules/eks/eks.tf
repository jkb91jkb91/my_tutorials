############################################
# eks.tf — RAW resources (bez modułów)
# Wymaga zmiennych:
#   var.cluster_name         (np. "mini-eks")
#   var.cluster_version      (np. "1.30")
#   var.subnet_ids           (lista subnetów, np. prywatnych)
#   var.instance_types       (lista, np. ["t3.small"])
############################################


resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  #version  = var.cluster_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.subnet_ids     # prefer prywatne
    endpoint_private_access = true               # Use Bastion Host to connect to Kube Api Server
    security_group_ids    = [aws_security_group.eks_cluster.id] # CREATE SG TO USE THIS
  }

  enabled_cluster_log_types = ["api","audit","authenticator"]
}

resource "aws_eks_fargate_profile" "default" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "${var.cluster_name}-fp"
  pod_execution_role_arn = aws_iam_role.eks_fargate_pod_execution_role.arn
  subnet_ids             = var.subnet_ids

  selector { namespace = "default" }
  selector { namespace = "apps" }

  depends_on = [
    aws_eks_cluster.this,
    aws_iam_role_policy_attachment.eks_fargate_pod_execution_role_policy
  ]
}


# === IAM: Rola dla control plane (EKS Cluster) ===
resource "aws_iam_role" "eks_cluster_role" {
  name               = "${var.cluster_name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

######################################### FARGATE POLICIES ##############################################
resource "aws_iam_role" "eks_fargate_pod_execution_role" {
  name = "${var.cluster_name}-fargate-pod-exec"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "eks-fargate-pods.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_fargate_pod_execution_role_policy" {
  role       = aws_iam_role.eks_fargate_pod_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}



# Polityki wymagane przez EKS control plane
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceController" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}



data "aws_eks_cluster" "this" {
  name = aws_eks_cluster.this.name
}
data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}

resource "aws_security_group" "eks_cluster" {
  name        = "${var.cluster_name}-cluster-sg"
  description = "EKS cluster security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Kubernetes API from bastion SG"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.aws_security_group_bastion_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


