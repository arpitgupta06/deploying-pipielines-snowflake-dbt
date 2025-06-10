select
    part_key as part_id,
    supplier_key as supplier_id,
    available_quantity
from {{ ref('partsupp') }}