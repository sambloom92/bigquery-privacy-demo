{{
    config(
        materialized='view'
    )
}}
SELECT
with AGGREGATION_THRESHOLD
department
,count(*) as employee_count
,avg(annual_gross_salary_gbp) as mean_gross_annual_income
FROM {{ ref('fake_employee_aggregation_threshold') }}
GROUP BY  1
