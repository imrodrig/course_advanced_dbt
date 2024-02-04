{%- macro trunc_to_period(date_column, period='month', alias_name='') -%}
    DATE(DATE_TRUNC('{{ period }}', {{ date_column }} ))
    {%- if alias_name -%}
       AS {{ alias_name }}
    {%- endif -%}
{%- endmacro -%}
