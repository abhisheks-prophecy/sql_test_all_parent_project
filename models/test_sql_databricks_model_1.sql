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
    in0.NZHSC_Level_2_Code_HS4 AS NZHSC_Level_2_Code_HS4,
    in0.NZHSC_Level_1_Code_HS2 AS NZHSC_Level_1_Code_HS2,
    in0.NZHSC_Level_2 AS NZHSC_Level_2,
    in0.NZHSC_Level_1 AS NZHSC_Level_1,
    in0.Status_HS4 AS Status_HS4,
    in0.c_dbt_utils AS c_dbt_utils,
    in0.c_concat_column_function AS c_concat_column_function
  
  FROM test_sql_databricks_model_2 AS in0
  INNER JOIN test_sql_databricks_useall AS in1
     ON in0.Status_HS4 != in1.service_label

)

SELECT *

FROM Join_1
