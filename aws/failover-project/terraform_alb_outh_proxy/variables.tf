variable "ami" {
  type        = string
  description = "AMI of the image"
}

variable "instance_type" {
  type        = string
  description = "instance_type"
}

variable "instance_tags" {
  type = map(any)
}

variable "tags" {
  type = map(any)
}
