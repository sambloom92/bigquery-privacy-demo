resource "google_project_iam_binding" "demo_user" {
  project = var.project
  for_each = toset([
    "roles/bigquery.jobUser",
    "roles/bigquery.dataViewer",
    "roles/bigquerydatapolicy.maskedReader"
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
