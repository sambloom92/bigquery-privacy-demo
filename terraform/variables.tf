variable "project" {
  description = "project ID"
  type = string
  default = "bigquery-privacy-demo"
}

variable "admin_email" {
  description = "admin email address"
  type = string
  default = "admin@sambloom.me"
}

variable "demo_user_email" {
  description = "demo user email address"
  type = string
  default = "demo-user@sambloom.me"
}

variable "region" {
  description = "default GCP region"
  type = string
  default = "europe-west2"
}
