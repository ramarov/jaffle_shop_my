-- select
-- order_id,
-- count(*) as num_of_transactions,
-- sum(case when payment_method = 'bank_transfer' then amount end) as bank_transfer_amount,
-- sum(case when payment_method = 'credit_card' then amount end) as credit_card_amount,
-- sum(case when payment_method = 'gift_card' then amount end) as gift_card_amount,
-- sum(amount) as total_amount
-- from {{ ref('stg_payments') }}
-- group by 1

--using for loop
-- select
-- order_id,
-- count(*) as num_of_transactions,
-- {% for payment_method in ["bank_transfer", "credit_card", "gift_card", "coupon"] %}
-- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
-- {% endfor %}
-- sum(amount) as total_amount
-- from {{ ref('stg_payments') }}
-- group by 1


--set variables at the top of the model.
-- {% set payment_methods = ["bank_transfer", "credit_card", "gift_card", "coupon"] %}

-- select
-- order_id,
-- count(*) as num_of_transactions,
-- {% for payment_method in payment_methods %}
-- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount,
-- {% endfor %}
-- sum(amount) as total_amount
-- from {{ ref('stg_payments') }}
-- group by 1

--Use loop.last to avoid trailing commas
-- {% set payment_methods = ["bank_transfer", "credit_card", "gift_card"] %}

-- select
-- order_id,
-- {% for payment_method in payment_methods %}
-- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount
-- {% if not loop.last %},{% endif %}
-- {% endfor %}
-- from {{ ref('stg_payments') }}
-- group by 1


-- or you can write as below, check the if statement
-- {% set payment_methods = ["bank_transfer", "credit_card", "gift_card"] %}

-- select
-- order_id,
-- {% for payment_method in payment_methods %}
-- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount
-- {{ "," if not loop.last }}
-- {% endfor %}
-- from {{ ref('stg_payments') }}
-- group by 1

--remove white space in the compiled code.
-- {%- set payment_methods = ["bank_transfer", "credit_card", "gift_card"] %}

-- select
-- order_id,
-- {%- for payment_method in payment_methods %}
-- sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount
-- {%- if not loop.last %},{% endif -%}
-- {% endfor %}
-- from {{ ref('stg_payments') }}
-- group by 1



--using macro to get the list of methods
{%- set payment_methods = get_payment_methods() %}

select
order_id,
{%- for payment_method in payment_methods %}
sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount
{%- if not loop.last %},{% endif -%}
{% endfor %}
from {{ ref('stg_payments') }}
group by 1
