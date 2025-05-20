
# resource "aws_lb_listener" "http_listener" {
#   load_balancer_arn = aws_lb.my_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
#   certificate_arn   = "arn:aws:acm:us-east-1:311141565994:certificate/a1314ff7-ca7a-4209-8243-8e9d24f73ad1" # NOT MANAGED BY TERRAFORM

#   default_action {
#     type  = "forward"
#     order = 1

#     forward {
#       stickiness {
#         enabled  = false
#         duration = 3600
#       }

#       target_group {
#         arn    = aws_lb_target_group.my_tg.arn
#         weight = 1
#       }
#     }

#     target_group_arn = aws_lb_target_group.my_tg.arn
#   }

#   mutual_authentication {
#     mode                             = "off"
#     ignore_client_certificate_expiry = false
#   }

#   tags = {}
# }

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP to ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_lb" "this" {
  name               = "my-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.subnet1_id, var.subnet2_id]
  enable_deletion_protection = false

  tags = {
    Name = "my-alb"
  }
}

resource "aws_lb_target_group" "fargate_tg" {
  name        = "fargate-tg"
  port        = 90
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "fargate-target-group"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fargate_tg.arn
  }
}


