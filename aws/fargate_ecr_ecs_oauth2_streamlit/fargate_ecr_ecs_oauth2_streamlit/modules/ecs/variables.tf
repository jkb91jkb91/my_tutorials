variable "execution_role_arn" {
  type        = string
  description = "execution_role_arn"
}

variable "task_role_arn" {
  type        = string
  description = "task_role_arn"
}

variable "ecr_repo_url" {
  type        = string
  description = "ecr_repo_url"
}

variable "subnet1_id" {
  type        = string
  description = "subnet1_id"
}

variable "subnet2_id" {
  type        = string
  description = "subnet2_id"
}

variable "sg1_id" {
  type        = string
  description = "sg1_id"
}

variable "alb_target_group_arn" {
  type        = string
  description = "alb_target_group_arn"
}

