{% macro qa_all_null_base(model, column_name) %}





select * from {{ model }} where {{ column_name }} is not null
{% endmacro %}

 {% macro qa_all_not_null_base(model, column_name) %}


select * from {{ model }} where {{ column_name }} is not null
{% endmacro %}

 