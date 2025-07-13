resource "google_project_iam_binding" "demo_user" {
  project = var.project
  for_each = toset([
    "roles/bigquery.jobUser",
    "roles/bigquery.dataViewer",
    "roles/bigquerydatapolicy.maskedReader",
    "roles/datacatalog.viewer"
    ])
  role    = each.key

  members = [
    "user:${var.demo_user_email}",
  ]
}

resource "google_project_iam_binding" "admin_user" {
  project = var.project
  for_each = toset([
    "roles/admin",
    "roles/datacatalog.categoryFineGrainedReader"
    ])
  role    = each.key

  members = [
    "user:${var.admin_email}",
  ]
}

resource "google_data_catalog_policy_tag_iam_binding" "demo_user_allowed_tags" {
  for_each = toset(var.allowed_demo_user_tags)
  policy_tag = each.key
  role = "roles/datacatalog.categoryFineGrainedReader"
  members = [
    "user:${var.demo_user_email}",
  ]
}