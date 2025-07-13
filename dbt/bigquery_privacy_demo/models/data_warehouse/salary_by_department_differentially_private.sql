{{
    config(
        materialized='view'
    )
}}
SELECT
 WITH DIFFERENTIAL_PRIVACY -- noqa
  OPTIONS (epsilon=1e2, delta=1e-3, privacy_unit_column=id) -- noqa
department
,count(*) as employee_count
,avg(annual_gross_salary_gbp) as mean_gross_annual_income
FROM {{ ref('fake_employee') }}
GROUP BY 1
ORDER BY 1
