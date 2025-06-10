with source as (
    select * from {{ source('staging', 'lineitem') }}
),
lineitem_beginner as (
    select
        l_orderkey as order_id,
        l_partkey as part_id,
        l_suppkey as supplier_id,
        l_linenumber as linenumber,
        l_quantity as quantity,
        l_extendedprice as price,
        l_discount as discount,
        l_tax as tax,
        (l_extendedprice + (l_extendedprice*l_tax)) as price_with_tax,
        (l_extendedprice - (l_extendedprice*l_discount)) as discounted_price,
        l_returnflag as return_status,
        l_linestatus as line_status,
        l_shipdate as ship_date,
        l_shipmode as ship_mode
    from source
)
select * from lineitem_beginner