with base_orders as (

    select * from {{ ref('base_orders') }}

)

, base_item_types as (

    select * from {{ ref('base_item_types') }}

)

, joined as (

    select
          order_id
        , order_ref_id
        , units_sold
        , total_revenue
        , total_cost
        , total_profit
        , '|' as "|"
        , cast(units_sold * unit_price as numeric(32,2)) as calc_revenue
        , cast(units_sold * unit_cost as numeric(32,2)) as calc_cost
        , cast(units_sold * (unit_price - unit_cost) as numeric(32,2)) as calc_profit

    from
        base_orders as o
        left join
            base_item_types as i
            on o.item_type_id = i.item_type_id

)

, verify as (

    select
          *
        , '||' as "||"
        , (total_revenue = calc_revenue) as same_reveue
        , (total_cost = calc_cost) as same_cost
        , (total_profit = calc_profit) as same_profit

    from
        joined
)

select * from verify
