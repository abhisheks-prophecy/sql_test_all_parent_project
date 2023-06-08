

{% set v_model_int = 10 %}
{% set v_model_string = 'hello' %}


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
    in0.code AS code,
    in0.service_label AS service_label,
    in1.NZHSC_Level_2_Code_HS4 AS NZHSC_Level_2_Code_HS4,
    in1.NZHSC_Level_1_Code_HS2 AS NZHSC_Level_1_Code_HS2,
    in1.NZHSC_Level_2 AS NZHSC_Level_2,
    in1.NZHSC_Level_1 AS NZHSC_Level_1,
    in1.Status_HS4 AS Status_HS4
  
  FROM service_classification_test AS in0
  INNER JOIN goods_classification_test AS in1
     ON in0.code != in1.NZHSC_Level_1

),

Reformat_1 AS (

  SELECT 
    {% if v_model_int > 10 %}
      concat(code, NZHSC_Level_1) AS c_if,
    {% elif  var('v_project_int') > 10 and v_model_string == "hello" %}
      concat(code, NZHSC_Level_1) AS c_if,
    {% else %}
      concat(code, NZHSC_Level_2) AS c_if,
    {% endif %}
    code AS code,
    service_label AS service_label,
    NZHSC_Level_2_Code_HS4 AS NZHSC_Level_2_Code_HS4,
    NZHSC_Level_1_Code_HS2 AS NZHSC_Level_1_Code_HS2,
    NZHSC_Level_2 AS NZHSC_Level_2,
    NZHSC_Level_1 AS NZHSC_Level_1,
    Status_HS4 AS Status_HS4
  
  FROM Join_1 AS in0

)

SELECT *

FROM Reformat_1
