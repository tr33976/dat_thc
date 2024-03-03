{{ config(materialized='view') }}

with source_data as (
    select * from datastore_thc.sales
)

SELECT 
    EXTRACT(YEAR FROM date_date) as yr,
    EXTRACT(MONTH FROM date_date) as mth,
    ROUND(AVG(cnt),2) as avg_item_qty
FROM (
    SELECT
        date_date,
        transaction_id,
        SUM(qty) as cnt
    FROM 
        source_data
    WHERE EXTRACT(YEAR from date_date) = 2023
    GROUP BY transaction_id, date_date
) sub
GROUP BY mth, yr
ORDER BY yr, mth



