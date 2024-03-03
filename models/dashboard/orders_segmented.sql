{{ config(materialized='view') }}

WITH source_data as (
    select * from 
    datastore_thc.orders
    WHERE EXTRACT(YEAR from date_date) = 2023
)

SELECT 
    src.*,
    seg.trans_segment
FROM 
    source_data AS src
LEFT JOIN {{ref('order_num_segments')}} AS seg 
    ON src.orders_id = seg.orders_id


