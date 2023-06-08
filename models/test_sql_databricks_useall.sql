

{% set v_model_int = 10 %}
{% set v_model_string = 'hello' %}


WITH table_with_read_permission_for_user AS (

  SELECT * 
  
  FROM {{ source('spark_catalog.qa_database_acl', 'table_with_read_permission_for_user') }}

),

all_type_non_partitioned AS (

  SELECT * 
  
  FROM {{ source('spark_catalog.qa_database', 'all_type_non_partitioned') }}

),

Join_1 AS (

  SELECT 
    in0.c_tinyint AS c_tinyint,
    in0.c_smallint AS c_smallint,
    in0.c_int AS c_int,
    in0.c_bigint AS c_bigint,
    in0.c_float AS c_float,
    in0.c_double AS c_double,
    in0.c_string AS c_string,
    in0.c_boolean AS c_boolean,
    in0.c_array AS c_array,
    in0.c_struct AS c_struct
  
  FROM all_type_non_partitioned AS in0
  INNER JOIN table_with_read_permission_for_user AS in1
     ON in0.c_int != in1.a

),

Reformat_1 AS (

  SELECT 
    c_tinyint AS c_tinyint,
    c_smallint AS c_smallint,
    c_int AS c_int,
    c_bigint AS c_bigint,
    c_float AS c_float,
    c_double AS c_double,
    c_string AS c_string,
    c_boolean AS c_boolean,
    c_array AS c_array,
    c_struct AS c_struct,
    {% if v_model_int > 10 %}
      concat(c_string, c_int) AS c_if
    {% elif  var('v_project_int') > 10 and v_model_string == "hello" %}
      concat(c_string, c_bigint) AS c_if
    {% else %}
      concat(c_string, c_smallint) AS c_if
    {% endif %}
  
  FROM Join_1 AS in0

)

SELECT *

FROM Reformat_1
