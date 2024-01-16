{{
    config(
        materialized='table'
    )
}}
WITH source AS (
    SELECT * FROM {{ source('data_warehouse', 'row_sequence') }}
)

,base_info AS (
    SELECT
        data_warehouse.random_numeric_id(16) AS id
        ,data_warehouse.random_firstname() AS firstname
        ,data_warehouse.random_surname() AS surname
        ,data_warehouse.random_postcode() AS home_postcode
        ,data_warehouse.random_numeric_id(11) AS primary_phone_number
        ,data_warehouse.random_date(
            date('1920-01-01')
            ,date('2005-01-01')
        ) AS date_of_birth
        ,data_warehouse.random_free_text_paragraph() AS notes
        ,data_warehouse.random_numeric_id(8) AS bank_account_number
        ,data_warehouse.random_gbp_amount(33000,50000)
            AS annual_gross_salary_gbp
        ,data_warehouse.random_choice(
            [
                'accounting'
                ,'finance'
                ,'commercial'
                ,'operations'
                ,'HR'
                ,'legal'
                ,'IT'
            ]
        ) AS department
        ,data_warehouse.random_choice(['EU','UK','USA']) AS region
    FROM source
)

SELECT
    *
    ,data_warehouse.random_email(firstname,surname) AS personal_email_address
FROM base_info
