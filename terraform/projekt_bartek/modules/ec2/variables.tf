variable "ec2_count" {
  description = "Liczba instancji EC2 do utworzenia"
  type        = number
  default     = 1
}

variable "ami_us_east_2" {
    description = "ami version"
    type        = string
    default     = "ami-09040d770ffe2224f"
}

variable "instance_type" {
    description = "instance type "
    type        = string
    default     = "t2.micro"
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "security_group" {
    description = "Configuration for security group"
    type  = object({
        sg_name     = string
        ssh_port    = number
        protocol    = string
        cidr_blocks = list(string)
    })
    default = {
        sg_name     = "ssh"
        ssh_port    = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
