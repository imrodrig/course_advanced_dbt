{% macro rolling_average_n_periods(column_name, partition_by, period=7, order_by='created_at') %}
    avg( {{ column_name }} ) OVER (
                PARTITION BY {{ partition_by }}
                ORDER BY {{ order_by }}
                ROWS BETWEEN {{ period-1 }} PRECEDING AND CURRENT ROW
            ) AS avg_{{ period }}_periods_{{ column_name }}
{% endmacro %}
