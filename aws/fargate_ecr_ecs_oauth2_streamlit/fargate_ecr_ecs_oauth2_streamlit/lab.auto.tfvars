


### EC2 Values
ami           = "ami-04b4f1a9cf54c11d0"
instance_type = "t2.micro"
region        = "us-east-1"

### Tags
tags = {
  Environment     = "LAB"
  Service         = "ssssssss"
  Terraform       = "true"
  ManagedBy       = "Terraform"
  migrated        = "ssssssss"
  map-dba         = "ssssssss"
  wamp-modernized = "E"
  Project         = "M"
  ServiceContact  = "dg"
}

instance_tags = {
  AWSLZ_Scheduler = "AWST"
  datadog         = "true"
  Backup          = "automated"
}


####################  MDP NAVIGATOR DEPENDENCIES ######################
cluster_name = "fargate-mdp-navigator-cluster"
log_group_name      = "mdp-navigator-logs"
logs_retention_in_days = 7
#------------------------------NGINX LANDING PAGE--------------------
nginx_replica_count = 1
nginx_service_name = "nginx-service"       #DONT CHANGE AFTER FIRST DEPLOY
nginx_task_definition = {
  name             = "nginx"
  image_tag        = "nginx"
  container_port   = 80                     # NGINX USES 80
  healthcheck_path = "http://localhost:80"  # NGINX USES 80
  stream_prefix    = "proxy"
}
nginx_task_definition_config = {
  family = "nginx-landing-page-task"       #UNIQUE
  cpu    = "256"
  memory = "512"
}
#----------------------------------------------------------------------
#------------------------APPS LIST SERVICES+TASK-----------------------
apps = [
  {
    task_definition = {
      container = {
        name             = "my1-streamlit-app"
        image_tag        = "my-streamlit-app_2"
        container_port   = 8501
        healthcheck_path = "http://localhost:8501"    # STREAMLIT 8501
        stream_prefix    = "streamlit"
      }
      config = {
        family = "streamlit11-task"
        cpu    = "512"
        memory = "1024"
      }
    }
    service_name  = "streamlit-service1" #DONT CHANGE AFTER FIRST DEPLOY
    replica_count = 1
  },
  {
    task_definition = {
      container = {
        name             = "my2-streamlit-app"
        image_tag        = "my-streamlit-app_2"
        container_port   = 8501
        healthcheck_path = "http://localhost:8501"
        stream_prefix    = "streamlit"
      }
      config = {
        family = "streamlit22-task"
        cpu    = "512"
        memory = "1024"
      }
    }
    service_name  = "streamlit-service2" #DONT CHANGE AFTER FIRST DEPLOY
    replica_count = 1
  }
]
#---------------------------------------------------------------------
######################################################################