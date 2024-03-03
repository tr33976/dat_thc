{{ config(materialized='materialized_view') }}

WITH source_data as (
    select * from 
    datastore_thc.orders
),

segment_cte as (
    SELECT 
        orders_id,
        COUNT(*) OVER (PARTITION BY customers_id ORDER BY date_date ROWS BETWEEN 365 PRECEDING AND CURRENT ROW) AS yr_cnt
    FROM 
        source_data
    ORDER BY customers_id, date_date DESC
    WHERE EXTRACT(YEAR FROM date_date) = 2023
)

SELECT 
    orders_id, 
    CASE
        WHEN yr_cnt = 1 THEN 'new'
        WHEN yr_cnt > 1 AND yr_cnt <= 4 THEN 'returning'
        WHEN yr_cnt >= 5 THEN 'vip'
        ELSE 'no_segment'
    END as trans_segment
FROM segment_cte





