with trading_books as (
    select * from {{ ref('stg_trading_books') }}
),

-- extract sentiment using snowflake cortex
cst as (
    select
        trade_id,
        trade_date,
        trader_name,
        desk,
        ticker,
        quantity,
        price,
        trade_type,
        notes
    from trading_books
    where notes is not null
)
select * from cst