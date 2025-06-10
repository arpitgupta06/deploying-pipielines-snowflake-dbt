select
    c.customer_id,
    c.customer_name,
    c.market_segment,
    c.nation_key,
    c.nation_name
from {{ ref('customer') }} as c
