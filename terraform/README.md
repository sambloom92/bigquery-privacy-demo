# BigQuery Privacy Demo
This terraform project provisions a BigQuery dataset, data policy tags and IAM bindings, for demonstrating various BigQuery features for preserving privacy and securing PII.

## Instructions

1. [Install terraform](https://developer.hashicorp.com/terraform/install)  (version specified in .terraform-version file). I recommend [tfenv](https://github.com/tfutils/tfenv?tab=readme-ov-file) for managing multiple terraform versions.

2. Run the following command in this directory:

    ```terraform init```

3. Create a file in this directory called `terraform.tfvars`.
Fill in the following fields with values:
    ```
    project = "{{ your GCP project ID }}"
    admin_email = "{{ your GCP organization admin account email }}"
    demo_user_email = "{{ your demo user account email }}"
    region = "{{ your default GCP region }}"
    ```
4. Run the following command to review the planned changes:
    ```
    terraform plan
    ```
5. Run the following command to apply changes:
    ```
    terraform apply
    ```

### Outputs
This configuration outputs several data policy tag IDs, which the dbt project requires for its configuration. Each time an apply is run, these policy tag IDs will be output in the terminal. If any have changed or this is the first time it is run, they must be copied to the vars section in `dbt/bigquery_privacy_demo/dbt_project.yml`