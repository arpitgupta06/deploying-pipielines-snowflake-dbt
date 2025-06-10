with source as (
    select * from {{source('portfolio_data', 'weights_table')}}
),
renamed as (
    select * from source
)
select * from renamed