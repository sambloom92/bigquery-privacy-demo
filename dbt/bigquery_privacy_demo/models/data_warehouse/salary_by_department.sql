{{
    config(
        materialized='view'
    )
}}
SELECT
    department
    ,count(*) AS employee_count
    ,avg(annual_gross_salary_gbp) AS mean_gross_annual_income
FROM {{ ref('fake_employee') }}
GROUP BY 1
ORDER BY 1
