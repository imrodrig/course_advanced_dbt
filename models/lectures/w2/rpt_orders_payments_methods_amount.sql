/*  -- repetitive logic; clean it up with jinja below:
select
order_id,
sum(case when payment_method = 'bank_transfer' then amount end) as bank_transfer_amount,
sum(case when payment_method = 'credit_card' then amount end) as credit_card_amount,
sum(case when payment_method = 'gift_card' then amount end) as gift_card_amount,
sum(amount) as total_amount
from {{ ref('raw_payments') }}
group by 1
*/

-- call a macro to return the list of defined values for payment methods
{% set payment_methods = w2_get_payment_methods() %}
-- now use whitespace control to tidy up the output code:
select
order_id,
sum(amount) as total_amount,
  {%- for payment_method in payment_methods %}
     sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount
  {%- if not loop.last %},{% endif -%}
  {% endfor %}

from {{ ref('raw_payments') }}
group by 1
