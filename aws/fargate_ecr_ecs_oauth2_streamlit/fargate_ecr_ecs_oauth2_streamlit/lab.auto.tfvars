


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
cluster_name           = "fargate-mdp-navigator-cluster"
log_group_name         = "mdp-navigator-logs"
logs_retention_in_days = 7
#------------------------APPS LIST SERVICES+TASK-----------------------
apps = [
  {
    task_definition = {
      container = {
        name             = "apps"                                 # ITS PATH NAME >>> DOMAIN/PATH   AND CONTAINER NAME 
        image_tag        = "nginx"
        container_port   = 80
        healthcheck_path = "http://localhost:80" # NGINX 80
        stream_prefix    = "proxy"
      }
      config = {
        family = "nginx-landing-page-task"
        cpu    = "256"
        memory = "512"
      }
    }
    service_name  = "nginx-service" #DONT CHANGE AFTER FIRST DEPLOY
    replica_count = 1
  },
  {
    task_definition = {
      container = {
        name             = "mdp-navigator-app"                      # ITS PATH NAME >>> DOMAIN/PATH   AND CONTAINER NAME 
        image_tag        = "mdp-navigator-app_latest1"
        container_port   = 8501
        healthcheck_path = "http://localhost:8501" # STREAMLIT 8501
        stream_prefix    = "streamlit"
      }
      config = {
        family = "mdp-navigator-app-task"
        cpu    = "512"
        memory = "1024"
      }
    }
    service_name  = "mdp-navigator-app-service" #DONT CHANGE AFTER FIRST DEPLOY
    replica_count = 1
  },
  {
    task_definition = {
      container = {
        name             = "new-app"                                # ITS PAHT NAME >>> DOMAIN/PATH   AND CONTAINER NAME 
        image_tag        = "mdp-navigator-app_latest1"
        container_port   = 8501
        healthcheck_path = "http://localhost:8501"
        stream_prefix    = "streamlit"
      }
      config = {
        family = "new-app-task"
        cpu    = "512"
        memory = "1024"
      }
    }
    service_name  = "new-app-service" #DONT CHANGE AFTER FIRST DEPLOY
    replica_count = 1
  }
]
#---------------------------------------------------------------------
######################################################################