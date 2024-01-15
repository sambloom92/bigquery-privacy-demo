resource "google_bigquery_dataset" "data_warehouse" {
  dataset_id                  = "data_warehouse"
  friendly_name               = "data_warehouse"
  description                 = "A data warehouse"
  location                    = var.region
  project                     = var.project

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = var.admin_email
  }
}
