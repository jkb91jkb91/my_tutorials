terraform {
  required_version = ">= 1.8"
  required_providers {
    google = {
      version = ">= 5.35.0"
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "stronki-429707"
  region = "us-central1"
  credentials = file("/home/jkb91/Downloads/gcp_sa.json")
}
