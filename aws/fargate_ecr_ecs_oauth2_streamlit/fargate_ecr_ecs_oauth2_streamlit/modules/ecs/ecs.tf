resource "aws_ecs_cluster" "fargate_cluster" {
  name = "fargate-mdp-navigator-cluster"
}


# resource "aws_ecs_task_definition" "terraform_mdp" {
#   family                   = "terraform-mdp"
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = "awsvpc"
#   cpu                      = "256"
#   memory                   = "512"

#   execution_role_arn = var.execution_role_arn # "arn:aws:iam::311141565994:role/fargateEcsTaskExecutionRole"
#   task_role_arn      = var.task_role_arn      #"arn:aws:iam::311141565994:role/fargateExtraRole"

#   container_definitions = jsonencode([
#     {
#       name      = "streamlit"
#       image     = "${var.ecr_repo_url}:latest" #"311141565994.dkr.ecr.us-east-1.amazonaws.com/mdp-navigator-repo:latest"
#       essential = true
#       portMappings = [
#         {
#           containerPort = 8080
#           protocol      = "tcp"
#         }
#       ]
#     }
#   ])
# }

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/terraform-mdp"
  retention_in_days = 7

  tags = {
    Name = "ecs-logs"
  }
}


resource "aws_ecs_task_definition" "terraform_mdp" {
  family                   = "terraform-mdp"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "${var.ecr_repo_url}:nginx"
      essential = true
      portMappings = [
        {
          containerPort = 90
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "proxy"
        }
      }
      dependsOn = [
        {
          containerName = "streamlit"
          condition     = "HEALTHY"
        }
      ]
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:90 || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }
    },
    {
      name      = "streamlit"
      image     = "${var.ecr_repo_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "streamlit"
        }
      }
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:8080 || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }
    }
  ])
}



resource "aws_ecs_service" "terraform_service" {
  name                   = "terraform-service"
  cluster                = aws_ecs_cluster.fargate_cluster.id
  task_definition        = aws_ecs_task_definition.terraform_mdp.arn
  launch_type            = "FARGATE"
  desired_count          = 1
  enable_execute_command = true

  network_configuration {
    subnets         = [var.subnet1_id, var.subnet2_id]
    security_groups = [var.sg1_id]
    assign_public_ip = false
  }

    load_balancer {
    target_group_arn = var.alb_target_group_arn #   module.alb.target_group_arn   # <== TU WSKAZUJESZ BACKEND
    container_name   = "nginx"              # musi się zgadzać z task definition
    container_port   = 90
  }


  depends_on = [
    aws_ecs_task_definition.terraform_mdp
  ]
}

