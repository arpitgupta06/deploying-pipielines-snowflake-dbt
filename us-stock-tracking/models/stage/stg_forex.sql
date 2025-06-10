with source as (
    select
        * 
    from {{ source('forex_data', 'FOREX_METRICS') }}
),
renamed as (
    select
        run_date,
        currency_pair_name,
        open as open_rate,
        high as high_rate,
        low as low_rate,
        close as close_rate
    from source
)
select * from renamed
where 1=1
    and run_date >= '2024-01-01'

{#the condition 1=1 is a tautology, meaning it always evaluates to TRUE. It is often used as a placeholder or a way to simplify dynamic query generation.
1=1 allows developers to easily add or remove conditions without worrying about the syntax (e.g., avoiding issues with leading AND or OR).
#}