select 
    id as order_id,
    userid as customer_id,
    order_date,
    status

from jaffle_shop.raw_orders
