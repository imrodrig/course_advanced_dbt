{% macro limit_data_in_nonprd(ref_date, lookback_window_days = 3) -%}
    {% if target.name not in ['prd'] -%}
        {{ref_date}} >= CURRENT_DATE - INTERVAL '{{lookback_window_days}} days'
    {% else %}
        TRUE
    {%- endif %}
{%- endmacro %}
