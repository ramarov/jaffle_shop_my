with customers as (
    select * from {{ ref('stg_customers')}}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

order_amount as (
    select * from {{ ref('fct_orders') }}
),

customer_orders as (
    select
        customer_id,
        min(a.order_date) as first_order_date,
        max(a.order_date) as most_recent_order_date,
        count(a.order_id) as number_of_orders,
        sum(b.amount) as lifetime_value
    from
        orders a
    join order_amount b using (customer_id, order_id)
    group by 1
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.lifetime_value, 0) as lifetime_value
    from
        customers
    left join customer_orders using (customer_id)
)

select * from final


