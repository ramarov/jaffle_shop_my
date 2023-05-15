with payments as (
    select * from {{ ref('stg_payments') }}
),

total_amount as ( 
    select 
        order_id,
        sum(amount) as total_amount
    from
        payments
    group by 1
)

select 
    order_id, 
    total_amount
from total_amount
where total_amount < 0



