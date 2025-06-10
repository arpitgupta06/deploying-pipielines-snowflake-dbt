with source as (
    select * from {{ source('staging', 'region') }}
),
region_beginner as (
    select
        r_regionkey as region_id,
        r_name as region_name
    from source
)
select * from region_beginner