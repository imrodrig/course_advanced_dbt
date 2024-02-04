{% macro rolling_aggregation_by_n_periods(partition_by, agg_type='avg', column_name='created_at',  n=7, periods='days', order_by='created_at') -%}
    {{agg_type}}( {{ column_name }} ) OVER (
                {%- if partition_by -%}
                  PARTITION BY {{ partition_by }}
                {% endif %}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{ n-1 }} PRECEDING AND CURRENT ROW
            ) AS {{agg_type}}_{{ n }}_{{ periods }}_{{ column_name }}
{% endmacro %}
