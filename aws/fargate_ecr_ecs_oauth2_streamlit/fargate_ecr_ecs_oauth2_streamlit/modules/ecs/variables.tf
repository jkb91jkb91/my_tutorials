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

# variable "alb_nginx_target_group_arn" {
#   type        = string
#   description = "alb_nginx_target_group_arn"
# }

# variable "alb_navigator_target_group_arn" {
#   type        = string
#   description = "alb_navigator_target_group_arn"
# }

#variable "ecr_repo_url" {
#  type = string
#}

#variable "execution_role_arn" {
#  type = string
#}

#variable "task_role_arn" {
#  type = string
#}

variable "log_group_name" {
  type = string
}

variable "region" {
  type = string
}


################# MDP NAVIGATOR DEPENDENCIES ################

# variable "nginx_service_name" {
#   type = string
# }

# variable "apps_tasks_definition" {
#   type = list(object({
#     name             = string
#     image_tag        = string
#     container_port   = number
#     healthcheck_path = string
#     stream_prefix    = string
#   }))
# }

# variable "task_definition_config" {
#   type = list(object({
#     family = string
#     cpu    = string
#     memory = string
#   }))
# }

variable "cluster_name" {
  type = string
}

variable "logs_retention_in_days" {
  type = number
}

# variable "nginx_task_definition" {
#   type = object({
#     name             = string
#     image_tag        = string
#     container_port   = number
#     healthcheck_path = string
#     stream_prefix    = string
#   })
# }

# variable "nginx_replica_count" {
#   type = number
# }

# variable "nginx_task_definition_config" {
#   type = object({
#     family = string
#     cpu    = string
#     memory = string
#   })
# }

variable "apps" {
  type = list(object({
    task_definition = object({
      container = object({
        name             = string
        image_tag        = string
        container_port   = number
        healthcheck_path = string
        stream_prefix    = string
      })
      config = object({
        family = string
        cpu    = string
        memory = string
      })
    })
    service_name  = string
    replica_count = number
  }))
}

variable "target_group_arns" {
  type = map(string)
}