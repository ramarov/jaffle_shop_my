select
    id as payment_id,
    order_id,
    payment_method,
    amount / 100 as amount,
    _etl_loaded_at
from
    {{ source('stripe', 'payments') }}
    