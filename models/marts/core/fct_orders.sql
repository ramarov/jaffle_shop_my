-- select
--     a.order_id,
--     a.customer_id,
--     b.amount
-- from
--     jaffle_shop.stg_orders a
-- join jaffle_shop.stg_payments b using (order_id) 

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        payments.amount
    from
        orders
    join payments using (order_id)

)

select * from final