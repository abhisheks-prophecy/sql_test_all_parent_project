WITH test_sql_databricks_useall AS (

  SELECT * 
  
  FROM {{ ref('test_sql_databricks_useall')}}

),

test_sql_databricks_model_2 AS (

  SELECT * 
  
  FROM {{ ref('test_sql_databricks_model_2')}}

),

Join_1 AS (

  SELECT 
    in1.c_tinyint AS c_tinyint,
    in1.c_smallint AS c_smallint,
    in1.c_int AS c_int,
    in1.c_bigint AS c_bigint,
    in1.c_float AS c_float,
    in1.c_double AS c_double,
    in1.c_string AS c_string,
    in1.c_boolean AS c_boolean,
    in1.c_array AS c_array,
    in1.c_struct AS c_struct
  
  FROM test_sql_databricks_model_2 AS in0
  INNER JOIN test_sql_databricks_useall AS in1
     ON in0.Status_HS4 != in1.c_string

)

SELECT *

FROM Join_1
