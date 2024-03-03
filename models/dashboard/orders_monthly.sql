{{ config(materialized='view') }}

with source_data as (
    select * from datastore_thc.orders
)

select 
    EXTRACT(YEAR FROM date_date) as yr, 
    EXTRACT(MONTH from date_date) as mth,
    COUNT(orders_id) as order_cnt,
    SUM(CA_ht) as turn_sum
from source_data
GROUP BY mth,yr
HAVING yr = 2023


