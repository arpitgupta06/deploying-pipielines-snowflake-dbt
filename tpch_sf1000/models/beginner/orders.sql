with source as (
    select * from {{ source('staging', 'orders') }}
),
order_beginner as (
    select
        o_orderkey as order_id,
        o_custkey as customer_id,
        o_orderdate as order_date,
        year(o_orderdate) as order_year,
        o_orderstatus as order_status,
        o_orderpriority as order_priority,
        o_shippriority as shipping_priority,
        o_totalprice as order_price,
        count(o_orderkey) over (partition by o_custkey) as count_of_orders
    from source s
)
select * from order_beginner