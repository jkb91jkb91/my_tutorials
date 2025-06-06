variable "vpc_id" {
  type        = string
  description = "vpc_id"
}

variable "subnet1_id" {
  type        = string
  description = "subnet_id"
}

variable "subnet2_id" {
  type        = string
  description = "subnet_id"
}

variable "nginx_task_definition" {
  type = object({
    name             = string
    image_tag        = string
    container_port   = number
    healthcheck_path = string
    stream_prefix    = string
  })
}