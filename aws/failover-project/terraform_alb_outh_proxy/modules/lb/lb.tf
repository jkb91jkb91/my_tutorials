
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = "arn:aws:acm:us-east-1:311141565994:certificate/a1314ff7-ca7a-4209-8243-8e9d24f73ad1" # NOT MANAGED BY TERRAFORM

  default_action {
    type  = "forward"
    order = 1

    forward {
      stickiness {
        enabled  = false
        duration = 3600
      }

      target_group {
        arn    = aws_lb_target_group.my_tg.arn
        weight = 1
      }
    }

    target_group_arn = aws_lb_target_group.my_tg.arn
  }

  mutual_authentication {
    mode                             = "off"
    ignore_client_certificate_expiry = false
  }

  tags = {}
}


resource "aws_lb_target_group" "my_tg" {
  name     = "target-groupe-ec2-oauth"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  protocol_version                  = "HTTP1"
  load_balancing_algorithm_type     = "round_robin"
  load_balancing_anomaly_mitigation = "off"
  load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
  slow_start                        = 0
  ip_address_type                   = "ipv4"
  deregistration_delay              = 300

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 5
    timeout             = 2
    path                = "/ping"
    port                = "80"
    protocol            = "HTTP"
    matcher             = "200"
  }

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }

  tags = {
    Name = "alb-for-oauth"
  }
}

resource "aws_security_group" "https_access" {
  name        = "allow-https"
  description = "Allow HTTPS traffic from anywhere"
  vpc_id      = var.vpc_id  

  ingress {
    description      = "HTTPS from Internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "https-sg"
  }
}

resource "aws_lb" "my_alb" {
  name               = "ALB-for-oauth"
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.https_access.id]

  subnets = [
    var.subnet1_id,
    var.subnet2_id,
  ]

  enable_deletion_protection     = false
  enable_http2                   = true
  enable_cross_zone_load_balancing = true
  idle_timeout                   = 60
  desync_mitigation_mode         = "defensive"
  xff_header_processing_mode     = "append"


  tags = {
    Name = "lboauth"
  }
}

resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = var.ec2_id
  port             = 80
}