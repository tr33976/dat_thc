{{ config(materialized='materialized_view') }}

with source_data as (
    select * from datastore_thc.orders
)

select 
    EXTRACT(YEAR FROM date_date) as yr, 
    COUNT(orders_id) as order_cnt
from source_data
GROUP BY yr
HAVING yr = 2023



