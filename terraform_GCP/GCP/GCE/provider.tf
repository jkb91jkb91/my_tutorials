terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.40.0"
    }
  }
}


provider "google" {
  project = "stronki-429707"
  region = "us-central-1"
  zone = "us-central1-a"
  credentials = "/home/jkb91/Downloads/terraform_gcp.json"
}
