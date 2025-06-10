with source as (
select * from {{ source('staging', 'supplier') }}
),
supplier_beginner as (
    select
        s_suppkey as supplier_id,
        s_nationkey as nation_id,
        s_name as supplier_name,
        s_acctbal as account_balance
    from source
)
select * from supplier_beginner