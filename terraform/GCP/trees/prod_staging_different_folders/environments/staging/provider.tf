terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.40.0"
    }
  }
}


provider "google" {
  project = "nowy-437906"
  region = "us-central-1"
  zone = "us-central1-a"
  credentials ="/home/jkb91/.sa_bartek_nowy_project.json"

}
