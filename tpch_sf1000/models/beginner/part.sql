with source as (
    select * from {{ source('staging', 'part') }}
),
part_beginner as (
    select
        p_partkey as part_id,
        p_mfgr as part_manufacturer,
        p_type as part_type,
        p_size as part_size,
        p_retailprice as part_price,
        (p_size*p_retailprice) as total_price
    from source
)
select * from part_beginner