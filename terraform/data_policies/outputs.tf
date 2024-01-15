output "name_policy_tag" {
    value = google_data_catalog_policy_tag.name
}

output "dob_policy_tag" {
    value = google_data_catalog_policy_tag.date_of_birth
}

output "salary_policy_tag" {
    value = google_data_catalog_policy_tag.salary
}

output "bank_account_number_policy_tag" {
    value = google_data_catalog_policy_tag.bank_account_number
}

output "phone_number_policy_tag" {
    value = google_data_catalog_policy_tag.phone_number
}

output "post_code_policy_tag" {
    value = google_data_catalog_policy_tag.post_code
}

output "email_policy_tag" {
    value = google_data_catalog_policy_tag.email_address
}

output "free_text_policy_tag" {
    value = google_data_catalog_policy_tag.free_text
}
