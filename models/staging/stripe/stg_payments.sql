select
    id as payment_id,
    order_id,
    payment_method,
    amount / 100 as amount
from
    jaffle_shop.raw_payments
    