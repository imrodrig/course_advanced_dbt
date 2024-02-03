--- break up your logic into two separate macros
-- one to generically return a column from a relation,
-- and the other that calls this macro with the correct arguments to get back the list of payment methods.

{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
select distinct
{{ column_name }}
from {{ relation }}
order by 1
{% endset %}

{% set results = run_query(relation_query) %}

{% if execute %}
  {# Return the first column #}
  {% set results_list = results.columns[0].values() %}
{% else %}
  {% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}


{% macro w2_get_payment_methods() %}

{{ return(get_column_values('payment_method', ref('raw_payments'))) }}

{% endmacro %}
