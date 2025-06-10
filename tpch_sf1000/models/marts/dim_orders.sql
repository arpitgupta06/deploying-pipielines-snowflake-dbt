select
    order_id,
    customer_id,
    order_date,
    order_year,
    order_status,
    order_priority,
    shipping_priority,
    count_of_orders
from {{ ref('orders') }}