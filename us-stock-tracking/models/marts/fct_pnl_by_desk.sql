with trade_performance as (
    select * from {{ ref('trade_pnl') }}
),

-- Calculate daily PnL metrics by desk and ticker
daily_task_metrics as (
    select
        t.desk,
        t.ticker,
        t.sell_date as trade_date,
        case
            when t.ticker like '%/%' then 'Europe'
            else 'North America'
        end as region,
        count(distinct t.buy_trade_id) as total_trades,
        sum(t.quantity) as total_quantity,
        sum(t.pnl_usd) as total_pnl_usd,
        avg(t.quantity) as avg_trade_size,
        avg(t.pnl_usd) as avg_pnl_usd,

        -- adding trading performance metrics
        avg(t.vs_open_performance_pct) as avg_vs_open_performance_pct,
        avg(t.vs_close_performance_pct) as avg_vs_close_performance_pct,
        avg(t.market_daily_performance_pct) as avg_market_performance_pct,
        avg(t.relative_performance_pct) as avg_relative_performance_pct,
        count(case when t.price_performance = 'Best Price of day' then 1 end) as best_price_trade,
        count(case when t.price_performance = 'Worst price of day' then 1 end) as worst_price_trade,
        count(case when t.price_performance = 'Middle price of day' then 1 end) as middle_price_trade
    from trade_performance t
    where t.buy_trade_id is not null
    group by 1,2,3,4
),

-- calculate cumulative metrics
cumulative_metrics as (
    select
        desk,
        ticker,
        trade_date,
        region,
        total_trades,
        total_quantity,
        total_pnl_usd,
        avg_pnl_usd,
        avg_trade_size,
        avg_vs_open_performance_pct,
        avg_vs_close_performance_pct,
        avg_market_performance_pct,
        avg_relative_performance_pct,
        best_price_trade,
        worst_price_trade,
        middle_price_trade,
        sum(total_pnl_usd) over (partition by desk, ticker order by trade_date) as cumulative_pnl_usd
    from daily_task_metrics
)

select * from cumulative_metrics
