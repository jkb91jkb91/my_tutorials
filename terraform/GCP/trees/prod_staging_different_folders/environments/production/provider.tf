terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.40.0"
    }
  }
}


provider "google" {
  project = "gowno-439010"
  region = "us-central-1"
  zone = "us-central1-a"
  credentials ="~/.sa_bartek_gowno_project"
}
