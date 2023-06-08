WITH goods_classification_test AS (

  SELECT * 
  
  FROM {{ ref('goods_classification_test')}}

),

service_classification_test AS (

  SELECT * 
  
  FROM {{ ref('service_classification_test')}}

),

Join_1 AS (

  SELECT 
    in0.NZHSC_Level_2_Code_HS4 AS NZHSC_Level_2_Code_HS4,
    in0.NZHSC_Level_1_Code_HS2 AS NZHSC_Level_1_Code_HS2,
    in0.NZHSC_Level_2 AS NZHSC_Level_2,
    in0.NZHSC_Level_1 AS NZHSC_Level_1,
    in0.Status_HS4 AS Status_HS4
  
  FROM goods_classification_test AS in0
  INNER JOIN service_classification_test AS in1
     ON in0.Status_HS4 != in1.service_label

),

Reformat_1 AS (

  SELECT 
    NZHSC_Level_2_Code_HS4 AS NZHSC_Level_2_Code_HS4,
    NZHSC_Level_1_Code_HS2 AS NZHSC_Level_1_Code_HS2,
    NZHSC_Level_2 AS NZHSC_Level_2,
    NZHSC_Level_1 AS NZHSC_Level_1,
    Status_HS4 AS Status_HS4,
    concat('{{ dbt_utils.pretty_time() }}', '{{ dbt_utils.pretty_log_format("my pretty message") }}') AS c_dbt_utils,
    {{ SQL_Parent_All.qa_concat_column('NZHSC_Level_1') }} AS c_concat_column_function
  
  FROM Join_1 AS in0

),

Limit_1 AS (

  SELECT * 
  
  FROM Reformat_1 AS in0
  
  LIMIT 10

),

qa_all_not_null_base_1 AS (

  {{ SQL_Parent_All.qa_all_not_null_base(model = 'Limit_1', column_name = 'Status_HS4') }}

)

SELECT *

FROM qa_all_not_null_base_1
