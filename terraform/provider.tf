terraform {
  required_providers {
    google = {
      source  = "registry.terraform.io/hashicorp/google"
      version = "5.11.0"
    }
  }

  required_version = "1.6.6"
}

provider "google" {
  project = var.project
  region  = var.region
}
