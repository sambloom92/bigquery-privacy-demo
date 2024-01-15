{{
    config(
        materialized='view'
    )
}}
SELECT
department
,count(*) as employee_count
,avg(annual_gross_salary_gbp) as mean_gross_annual_income
FROM {{ ref('fake_employee') }}
GROUP BY  1