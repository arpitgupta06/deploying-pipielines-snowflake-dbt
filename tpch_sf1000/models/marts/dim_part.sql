select
    part_id,
    part_manufacturer,
    part_type,
    part_size
from {{ ref('part') }}