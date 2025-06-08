terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.93.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "SSS"
  secret_key = "SSS"
}
