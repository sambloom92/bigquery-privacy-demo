{{
    config(
        materialized='table',
        post_hook='{{ create_row_level_policies() }}'
    )
}}
SELECT *
FROM {{ ref('fake_employee') }}
