
locals {
  dataserver_primary = {
    ami = var.ami
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id  # <-- zmień na swoje VPC jeśli trzeba

  ingress {
    description      = "Allow HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   ingress {
    description      = "Allow SSH from anywhere"
    from_port        = 22
    to_port          = 22
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
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg-http"
  }
}

# EC2 OAUTH-PROXY
resource "aws_instance" "my_ec2" {
  ami                         = local.dataserver_primary.ami
  instance_type               = var.instance_type
  availability_zone           = "us-east-1a"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.allow_http.id]

  tags = merge(
    {
      "Type"       = "oauth2-proxy"
    }
  )

user_data = <<-EOT
#!/bin/bash
sudo apt-get update -y
sudo wget https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v7.6.0/oauth2-proxy-v7.6.0.linux-amd64.tar.gz
sudo tar -xvzf oauth2-proxy-v7.6.0.linux-amd64.tar.gz
echo kubakuba
sudo mv oauth2-proxy-v7.6.0.linux-amd64/oauth2-proxy /usr/local/bin/
sudo mkdir -p /etc/oauth2_proxy
cat <<CONFIG_EOF > /etc/oauth2_proxy/oauth2_proxy.cfg
http_address = "0.0.0.0:80"
reverse_proxy = true
upstreams = ["http://10.0.3.64:80"]
skip_auth_routes = ["/ping"]
real_client_ip_header = "X-Forwarded-For"
cookie_secret = "4528e5f1a6354dc2c75855b92b872b04"
provider = "google"
client_id = "840488832414-ldjnrpigaoggb883p3ra33k0ph8f2vhs.apps.googleusercontent.com"
client_secret = "GOCSPX-_Phh_cSM1sg7OWrsATBszbBaR5q"
redirect_url = "https://projectdevops.eu/oauth2/callback"
email_domains = ["gmail.com"]
CONFIG_EOF
sudo /usr/local/bin/oauth2-proxy --config=/etc/oauth2_proxy/oauth2_proxy.cfg
EOT
}


# EC2 APACHE
resource "aws_instance" "apache" {
  ami                         = local.dataserver_primary.ami
  instance_type               = var.instance_type
  availability_zone           = "us-east-1a"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.allow_http.id]

  tags = merge(
    {
      "Type"       = "apache"
    }
  )

user_data = <<-EOT
#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y
EOT
}

