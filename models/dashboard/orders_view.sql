
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='materialized_view') }}

with source_data as (

    select * from datastore_thc.orders

)

select *
from source_data

