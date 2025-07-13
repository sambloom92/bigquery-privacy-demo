{{
    config(
        materialized='view'
    )
}}
SELECT
WITH AGGREGATION_THRESHOLD -- noqa
department
,count(*) as employee_count
,avg(annual_gross_salary_gbp) as mean_gross_annual_income
FROM {{ ref('fake_employee_aggregation_threshold') }}
GROUP BY 1
ORDER BY 1
