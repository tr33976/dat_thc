{{ config(materialized='view') }}

WITH source_data as (
    select * from 
    datastore_thc.orders
),

qty_per_order as (
    SELECT 
        transaction_id,
        SUM(qty) as item_qty
    FROM datastore_thc.sales
    GROUP BY transaction_id
)

SELECT 
    src.*,
    qty.item_qty
FROM 
    source_data AS src
LEFT JOIN qty_per_order AS qty 
    ON src.orders_id = qty.transaction_id


