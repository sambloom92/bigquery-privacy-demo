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
        {{ random_numeric_id(16) }} AS id
        ,{{ random_firstname() }} AS firstname
        ,{{ random_surname() }} AS surname
        ,{{ random_postcode() }} AS home_postcode
        ,{{ random_numeric_id(11) }} AS primary_phone_number
        ,{{ random_date(
            '1920-01-01'
            ,'2005-01-01'
        ) }} AS date_of_birth
        ,{{ random_free_text_paragraph() }} AS notes
        ,{{ random_numeric_id(8) }} AS bank_account_number
        ,{{ random_gbp_amount(33000,50000) }}
            AS annual_gross_salary_gbp
        ,{{ random_choice(
            [
                'accounting'
                ,'finance'
                ,'commercial'
                ,'operations'
                ,'HR'
                ,'legal'
                ,'IT'
            ]
        ) }} AS department
        ,{{ random_choice(['EU','UK','USA']) }} AS region
    FROM source
)

SELECT
    *
    ,format(
        '%s.%s.%s@%s'
        ,firstname
        ,surname
        ,left(
            cast({{ random_numeric_id(4) }} AS STRING)
            ,cast(ceil(rand() * 4) AS INT)
        )
        ,
    {{ random_choice(
        [
            'gmail.com',
            'yahoo.com',
            'hotmail.com'
        ]
    ) }}
    ) AS personal_email_address
FROM base_info
ORDER BY 1
