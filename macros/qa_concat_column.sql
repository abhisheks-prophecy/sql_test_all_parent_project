{% macro qa_concat_column(param1_column) %}
concat({{param1_column}}, 'hellomain')
{% endmacro %}

{% macro round_function_base(n1, scale=2) %}
ROUND({{n1}}, {{scale}})
{% endmacro %}
