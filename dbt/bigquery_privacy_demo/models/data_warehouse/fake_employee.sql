{{
    config(
        materialized='table'
    )
}}
WITH source AS (
    SELECT * FROM {{ source('data_warehouse', 'row_sequence') }}
)
, base_info AS (
    SELECT
    data_warehouse.random_numeric_id(16) as id
    ,data_warehouse.random_firstname() as firstname
    ,data_warehouse.random_surname() as surname
    ,data_warehouse.random_postcode() as home_postcode
    ,data_warehouse.random_numeric_id(11) as primary_phone_number
    ,data_warehouse.random_date(
         DATE('1920-01-01')
        ,DATE('2005-01-01')
    ) as date_of_birth
    ,data_warehouse.random_free_text_paragraph() as notes
    ,data_warehouse.random_numeric_id(8) as bank_account_number
    ,data_warehouse.random_gbp_amount(33000, 50000) as annual_gross_salary_gbp
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
    ) as department
    ,data_warehouse.random_choice(['EU', 'UK', 'USA']) as region
    FROM source
)
SELECT
*
,data_warehouse.random_email(firstname, surname) as personal_email_address
FROM base_info
