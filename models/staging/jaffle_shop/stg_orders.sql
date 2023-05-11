select 
    id as order_id,
    userid as customer_id,
    order_date,
    status

from {{ source('jaffle_shop', 'orders') }}
