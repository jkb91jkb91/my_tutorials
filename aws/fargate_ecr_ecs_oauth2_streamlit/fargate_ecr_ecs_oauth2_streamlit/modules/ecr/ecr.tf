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
    App = "mdp-navigator"
  }
}

resource "aws_ecr_repository_policy" "allow_pull_for_role" {
  repository = aws_ecr_repository.example.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "AllowPullForSpecificRole"
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
