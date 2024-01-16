{% macro create_row_level_policies() %}
CREATE OR REPLACE ROW ACCESS POLICY region_filter_uk
ON {{ this }}
GRANT TO ('user:demo-user@sambloom.me')
FILTER USING (region = 'UK');

CREATE OR REPLACE ROW ACCESS POLICY region_filter_all
ON {{ this }}
GRANT TO ('user:admin@sambloom.me')
FILTER USING (1 = 1)
;
{% endmacro %}
