with date_seq as (
    select dateadd(day, seq4(), '1992-01-01') as date_value
    from table(generator(rowcount => 10000))
),
date_table as (
select
    date_value as date_key,
    extract(year from date_value) as year,
    extract(month from date_value) as month,
    extract(day from date_value) as day,
    to_char(date_value, 'DY') as day_name,
    to_char(date_value, 'MON') as month_name,
    weekofyear(date_value) as week,
    quarter(date_value) as quarter
from date_seq
)
select * from date_table 