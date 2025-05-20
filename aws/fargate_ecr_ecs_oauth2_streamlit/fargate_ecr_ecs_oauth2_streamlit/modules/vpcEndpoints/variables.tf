variable "vpc_id" {
  type        = string
  description = "vpc_id"
}

variable "endpoint_sg_id" {
  type        = string
  description = "endpoint_sg_id"
}

variable "task_sg_id" {
  type        = string
  description = "task_sg_id"
}


variable "priv_subnet1_id" {
  type        = string
  description = "priv_subnet1_id"
}

variable "priv_subnet2_id" {
  type        = string
  description = "priv_subnet2_id"
}

variable "s3_route_table_ids" {
  type        = list(string)
  description = "s3_route_table_ids"
}

