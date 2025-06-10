select 
    l.order_id,
    l.part_id,
    l.supplier_id,
    l.linenumber,
    o.customer_id,
    l.quantity,
    l.price,
    l.discount,
    l.tax,
    l.price_with_tax,
    l.discounted_price,
    l.return_status,
    l.line_status,
    l.ship_date,
    l.ship_mode
from {{ ref('lineitem') }} as l
join {{ ref('orders') }} as o
on l.order_id = o.order_id