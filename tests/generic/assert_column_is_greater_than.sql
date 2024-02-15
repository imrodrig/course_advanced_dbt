{%- test assert_column_is_greater_than(model, column_name, value) %}

SELECT *
FROM {{ model }}
WHERE {{ column_name }} < {{ value }}

{%- endtest %}
