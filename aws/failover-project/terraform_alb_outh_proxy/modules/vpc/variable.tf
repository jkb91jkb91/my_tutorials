variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public1_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "public2_subnet_cidr" {
  default = "10.0.3.0/24"
}

variable "public_ec2_subnet_cidr" {
  default = "10.0.4.0/24"
}


variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "region" {
  default = "us-east-1"
}