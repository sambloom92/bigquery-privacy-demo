module "bigquery" {
  source = "./bigquery"

  project     = var.project
  admin_email = var.admin_email
  region      = var.region
}

module "data_policies" {
  source = "./data_policies"

  project = var.project
  region  = var.region
}

module "iam" {
  source = "./IAM"

  admin_email     = var.admin_email
  demo_user_email = var.demo_user_email
  project         = var.project
  allowed_demo_user_tags = [
    #       module.data_policies.free_text_policy_tag.id
  ]
}
