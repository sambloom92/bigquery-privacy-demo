{{
    config(
        materialized='view',
        post_hook="{{ set_aggregation_threshold(threshold_amount=5, privacy_unit_columns='id')}}"
    )
}}
SELECT *
FROM {{ ref('fake_employee') }}
