with source as (
    select * from {{ source('staging', 'nation') }}
),
nation_beginner as(
    select
        n_nationkey as nation_id,
        n_regionkey as region_id,
        n_name as nation_name
    from source
)
select * from nation_beginner