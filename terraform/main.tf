provider "google" {
  project     = var.project
  region      = "EU"
}

module "bigquery" {
    source = "./bigquery"

    project = var.project
    user_email = var.user_email
    region = var.region
}

module "data_policies" {
    source = "./data_policies"

    project = var.project
    region = var.region
}

module "iam" {
    source = "./IAM"

    project = var.project
}
