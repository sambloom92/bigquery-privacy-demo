resource "google_data_catalog_taxonomy" "employee_data_taxonomy" {
  display_name =  "employee-data-taxonomy"
  description = "A collection of policy tags"
  activated_policy_types = ["FINE_GRAINED_ACCESS_CONTROL"]
  project = var.project
  region = var.region
}

resource "google_data_catalog_policy_tag" "pii_policy_tag" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "PII"
  description = "Personally Identifiable Information"
}

resource "google_data_catalog_policy_tag" "contact_info" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Contact Information"
  description = "Personal contact information including physical address"
  parent_policy_tag = google_data_catalog_policy_tag.pii_policy_tag.id
}

resource "google_data_catalog_policy_tag" "financial_info" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Financial Information"
  description = "Financial imformation"
  parent_policy_tag = google_data_catalog_policy_tag.pii_policy_tag.id
}

resource "google_data_catalog_policy_tag" "personal_attributes" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Personal Attributes"
  description = "Personal attributes"
  parent_policy_tag = google_data_catalog_policy_tag.pii_policy_tag.id
}

resource "google_data_catalog_policy_tag" "free_text" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Free Text"
  description = "Free Text fields which have potential to contain PII data"
  parent_policy_tag = google_data_catalog_policy_tag.pii_policy_tag.id
}

resource "google_data_catalog_policy_tag" "phone_number" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Phone Number"
  description = "Employee phone number"
  parent_policy_tag = google_data_catalog_policy_tag.contact_info.id
}

resource "google_data_catalog_policy_tag" "email_address" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Email Address"
  description = "Employee personal email address"
  parent_policy_tag = google_data_catalog_policy_tag.contact_info.id
}

resource "google_data_catalog_policy_tag" "post_code" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Post Code"
  description = "Employee post code"
  parent_policy_tag = google_data_catalog_policy_tag.contact_info.id
}

resource "google_bigquery_datapolicy_data_policy" "phone_number_last_4_char_mask" {
    location         = var.region
    data_policy_id   = "phone_number_last_4_char_mask"
    policy_tag       = google_data_catalog_policy_tag.phone_number.name
    data_policy_type = "DATA_MASKING_POLICY"
    data_masking_policy {
      predefined_expression = "LAST_FOUR_CHARACTERS"
    }
  }

resource "google_bigquery_datapolicy_data_policy" "email_mask" {
    location         = var.region
    data_policy_id   = "email_mask"
    policy_tag       = google_data_catalog_policy_tag.email_address.name
    data_policy_type = "DATA_MASKING_POLICY"
    data_masking_policy {
      predefined_expression = "EMAIL_MASK"
    }
  }

resource "google_bigquery_datapolicy_data_policy" "post_code_mask" {
    location         = var.region
    data_policy_id   = "post_code_mask"
    policy_tag       = google_data_catalog_policy_tag.post_code.id
    data_policy_type = "DATA_MASKING_POLICY"
    data_masking_policy {
      predefined_expression = "FIRST_FOUR_CHARACTERS"
    }
  }

resource "google_data_catalog_policy_tag" "salary" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Salary"
  description = "Employee salary"
  parent_policy_tag = google_data_catalog_policy_tag.financial_info.id
}

resource "google_data_catalog_policy_tag" "bank_account_number" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Bank Account Number"
  description = "Employee payroll bank account number"
  parent_policy_tag = google_data_catalog_policy_tag.financial_info.id
}

resource "google_data_catalog_policy_tag" "date_of_birth" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Date of Birth"
  description = "Employee date of birth"
  parent_policy_tag = google_data_catalog_policy_tag.personal_attributes.id
}

resource "google_data_catalog_policy_tag" "name" {
  taxonomy = google_data_catalog_taxonomy.employee_data_taxonomy.id
  display_name = "Name"
  description = "Employee name"
  parent_policy_tag = google_data_catalog_policy_tag.personal_attributes.id
}

resource "google_bigquery_datapolicy_data_policy" "account_number_mask" {
    location         = var.region
    data_policy_id   = "account_number_mask"
    policy_tag       = google_data_catalog_policy_tag.bank_account_number.id
    data_policy_type = "DATA_MASKING_POLICY"
    data_masking_policy {
      predefined_expression = "LAST_FOUR_CHARACTERS"
    }
}

resource "google_bigquery_datapolicy_data_policy" "salary_mask" {
    location         = var.region
    data_policy_id   = "salary_mask"
    policy_tag       = google_data_catalog_policy_tag.salary.id
    data_policy_type = "DATA_MASKING_POLICY"
    data_masking_policy {
      predefined_expression = "ALWAYS_NULL"
    }
}

resource "google_bigquery_datapolicy_data_policy" "date_of_birth_mask" {
    location         = var.region
    data_policy_id   = "date_of_birth_mask"
    policy_tag       = google_data_catalog_policy_tag.date_of_birth.id
    data_policy_type = "DATA_MASKING_POLICY"
    data_masking_policy {
      predefined_expression = "DATE_YEAR_MASK"
    }
}

resource "google_bigquery_datapolicy_data_policy" "name_mask" {
    location         = var.region
    data_policy_id   = "name_mask"
    policy_tag       = google_data_catalog_policy_tag.name.id
    data_policy_type = "DATA_MASKING_POLICY"
    data_masking_policy {
      predefined_expression = "ALWAYS_NULL"
    }
}

locals {
    policies = {
        "name_mask": google_bigquery_datapolicy_data_policy.name_mask,
        "date_of_birth_mask": google_bigquery_datapolicy_data_policy.date_of_birth_mask,
        "post_code_mask": google_bigquery_datapolicy_data_policy.post_code_mask,
        "email_mask": google_bigquery_datapolicy_data_policy.email_mask,
        "phone_number_last_4_char_mask": google_bigquery_datapolicy_data_policy.phone_number_last_4_char_mask,
        "salary_mask": google_bigquery_datapolicy_data_policy.salary_mask,
        "account_number_mask": google_bigquery_datapolicy_data_policy.account_number_mask
}
}

resource "google_bigquery_datapolicy_data_policy_iam_member" "member" {
  for_each = local.policies
  project = var.project
  location = var.region
  data_policy_id =  each.value.id
  role = "roles/bigquerydatapolicy.maskedReader"
  member = "user:demo-user@sambloom.me"
}