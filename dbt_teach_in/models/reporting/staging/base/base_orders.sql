{{
    config(
        materialized='ephemeral',
    )
}}


with orders as (

    select * from {{ ref('raw_orders') }}

)

, col_renamed as (

    select
        id as order_id
      , order_ref_id
      , order_priority
      , order_date
      , ship_date
      , country_id
      , sales_channel
      , item_type_id
      , units_sold
      , total_revenue
      , total_cost
      , total_profit
      , created_at
      , updated_at
    from
        orders

)

select * from col_renamed

