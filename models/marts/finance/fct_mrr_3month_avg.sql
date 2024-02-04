-- Suppose you need to generate the 3-month moving average of mrr_amount
WITH
monthly_mrr AS (
  SELECT date_month,
         sum(mrr_amount) AS total_mrr
  FROM {{ ref('fct_mrr') }}
  GROUP BY date_month
)

-- using macro rolling_aggregation_by_n_periods(partition_by, agg_type='avg', column_name='created_at',  n=7, periods='days', order_by='created_at')
SELECT date_month,
       total_mrr,
       {{ rolling_aggregation_by_n_periods(partition_by='', agg_type='AVG', column_name='total_mrr', n=3, periods='weeks', order_by='date_month') }}
FROM monthly_mrr
ORDER BY date_month
