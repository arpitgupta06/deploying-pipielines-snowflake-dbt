with source as (
    select * from {{ source('staging', 'partsupp') }}
),
partsupp_beginner as(
    select
        ps_partkey as part_key,
        ps_suppkey as supplier_key,
        ps_availqty as available_quantity,
        ps_supplycost as supply_cost,
        (ps_availqty*ps_supplycost) as total_cost
    from source
)
select * from partsupp_beginner