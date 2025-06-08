#aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
#aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 311141565994.dkr.ecr.us-east-1.amazonaws.com
#docker push 311141565994.dkr.ecr.us-east-1.amazonaws.com/mdp-navigator-repo:mdp-navigator-app_latest



resource "aws_ecr_repository" "example" {
  name                 = "mdp-navigator-repo"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "mdp-navigator-repo"
    App  = "mdp-navigator"
  }
}

resource "aws_ecr_repository_policy" "allow_pull_for_role" {
  repository = aws_ecr_repository.example.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowPullForSpecificRole"
        Effect = "Allow"
        Principal = {
          AWS = var.fargate_extra_role_arn
        }
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",

        ]
      }
    ]
  })
}
