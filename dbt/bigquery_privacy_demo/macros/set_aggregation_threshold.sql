{% macro set_aggregation_threshold(
  threshold_amount,
  privacy_unit_columns
) %}
ALTER VIEW {{ this }}
SET OPTIONS (
  privacy_policy= """{
    'aggregation_threshold_policy': {
      'threshold' : {{ threshold_amount }},
      'privacy_unit_columns': '{{ privacy_unit_columns }}'
    }
  }"""
)
{% endmacro %}
