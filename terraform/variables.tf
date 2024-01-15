variable "project" {
  description = "project ID"
  type = string
  default = "bigquery-privacy-demo"
}

variable "user_email" {
  description = "main user's email address"
  type = string
  default = "admin@sambloom.me"
}

variable "region" {
  description = "default GCP region"
  type = string
  default = "europe-west2"
}
