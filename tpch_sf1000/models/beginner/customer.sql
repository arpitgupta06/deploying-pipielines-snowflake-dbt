with source as (
    select * from {{ source('staging', 'customer') }}
),
average_balance_cte as (
    select 
        s.c_custkey as customer_id,
        s.c_name as customer_name,
        avg(c_acctbal) over (partition by c_custkey) as average_balance,
        s.c_mktsegment as market_segment,
        s.c_nationkey as nation_key,
        n.n_name as nation_name
    from source as s
    join {{ source('staging', 'nation') }} as n
    on s.c_nationkey = n.n_nationkey
)
select *
from average_balance_cte
where average_balance > 0
order by average_balance desc