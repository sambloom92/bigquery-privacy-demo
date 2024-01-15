{% macro set_tablename(schema) %}
    {{ return("`{{ schema }}.row_sequence`") }}
{% endmacro %}

{% macro drop_row_sequence() %}
    {%- set tablename = set_tablename() %}
    DROP TABLE IF EXISTS {{ tablename }};
{% endmacro %}

{% macro generate_row_sequence(schema) %}
-- credit to this blog post for this method of generating an arbitrary number of unique rows
-- https://medium.com/google-cloud/yet-another-way-to-generate-fake-datasets-in-bigquery-93ee87c1008f
-- I have adapted this to work flexibly with dbt
    {%- set tablename = set_tablename(schema) %}
    {%- set max_rows = var('max_rows') %}
    {%- set desired_rows = max_rows * 1.5|int %}
    {%- set initial_rows = [desired_rows, 1_000_000]|min %}
    {%- set query %}
    SELECT
    CAST(CEIL(LOG({{ desired_rows / initial_rows }}, 2)) AS INT) AS result
    {% endset %}
    {%- if execute %}
        {%- set results = run_query(query) %}
        {%- set iterations = [results.columns[0].values()[0]|int, 0]|max %}
    {%- else %}
        {%- set iterations = 0 %}
    {%- endif %}
    {%- set queries %}
        {{ drop_row_sequence() }}
        CREATE OR REPLACE TABLE {{ tablename }}
        CLUSTER BY row_num
        OPTIONS (description="used to seed randomly generated data")
        AS (SELECT row_num FROM UNNEST(GENERATE_ARRAY(1, {{ initial_rows }})) AS row_num)
        ;
        {%- set step_size = initial_rows %}
        {%- for iteration in range(iterations) %}
            INSERT INTO {{ tablename}}
            SELECT row_num + {{ step_size }}
            FROM {{ tablename }}
            WHERE row_num < {{ desired_rows / 2 }};
        {%- endfor %}
        DELETE FROM {{ tablename }}
        WHERE row_num > {{ desired_rows}};
        ASSERT (SELECT MAX(row_num) FROM {{ tablename }}) = {{ desired_rows }}
            AS 'max row value does not match desired rows';
        ASSERT (SELECT COUNT(*) FROM {{ tablename }}) = {{ desired_rows}}
            AS 'row count does not match desired rows';
        ASSERT NOT EXISTS (
            SELECT
            row_num,
            count(*) AS count
            FROM {{ tablename }}
            GROUP BY row_num
            HAVING count > 1
        )
            AS 'row_num must not be reused';
    {%- endset %}
{{ return(queries) }}
{% endmacro %}
