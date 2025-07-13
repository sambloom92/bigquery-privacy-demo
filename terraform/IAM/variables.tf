variable "project" {
  description = "project ID"
  type = string
}

variable "admin_email" {
  description = "admin email address"
  type = string
}

variable "demo_user_email" {
  description = "demo user email address"
  type = string
}

variable "allowed_demo_user_tags" {
    description = "List of policy tags IDs which the demo user is granted access to"
    type = list(string)
}
