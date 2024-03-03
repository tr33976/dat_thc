{{ config(materialized='view') }}

WITH source_data as (
    select * from 
    datastore_thc.orders
),

segment_cte as (
    SELECT 
        *,
        (SELECT COUNT(B.orders_id) FROM source_data B
        WHERE B.date_date BETWEEN A.date_date - 365 AND A.date_date
        AND A.customers_id = B.customers_id) as yr_cnt
    FROM 
        source_data A
)

SELECT 
    orders_id,
    date_date, 
    CASE
        WHEN yr_cnt = 1 THEN 'new'
        WHEN yr_cnt > 1 AND yr_cnt <= 4 THEN 'returning'
        WHEN yr_cnt >= 5 THEN 'vip'
        ELSE 'no_segment'
    END as trans_segment
FROM segment_cte
WHERE EXTRACT(YEAR FROM date_date) = 2023




