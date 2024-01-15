resource "google_project_iam_binding" "demo_user" {
  project = var.project
  for_each = toset([
    "roles/bigquery.jobUser",
    "roles/bigquery.dataViewer",
    "roles/bigquerydatapolicy.maskedReader"
    ])
  role    = each.key

  members = [
    "user:demo-user@sambloom.me",
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
    "user:admin@sambloom.me",
  ]
}
