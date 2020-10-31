with base_regions as (

    select * from {{ ref('base_regions') }}

)

, base_countries as (

    select * from {{ ref('base_countries') }}

)

, base_orders as (

    select * from {{ ref('base_orders') }}

)

, base_item_types as (

    select * from {{ ref('base_item_types') }}

)

, final as (

    select 
        o.order_id
      , o.order_ref_id
      , o.order_priority
      , o.order_date
      , o.ship_date
      , r.region
      , c.country
      , o.sales_channel
      , it.item_type
      , o.units_sold
      , o.total_revenue
      , o.total_cost
      , o.total_profit
      , o.created_at        as order_created_at
      , o.updated_at        as order_updated_at
      , current_timestamp   as dbt_created_at

    from
        base_orders as o
    left join
        base_countries as c
        on o.country_id = c.country_id
    left join
        base_regions as r
        on c.region_id = r.region_id
    left join
        base_item_types as it
        on o.item_type_id = it.item_type_id

)

select * from final

