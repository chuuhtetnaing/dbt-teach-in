with fct_orders__dashboard as (

    select * from {{ ref('fct_orders__dashboard') }}

)

, renamed_summed as (

    select
        replace(replace(country, '''', ''), ' ', '_') as country
      , sum(units_sold)                               as units_sold

    from
        fct_orders__dashboard

    where
         item_type = 'Fruits'

    group by
        country

)

, final as (

    select
         a.country                     as a_country
       , b.country                     as b_country
       , (b.units_sold - a.units_sold) as units_sold_diff
       , current_timestamp   as dbt_created_at

    from
        renamed_summed     as a
        cross join
            renamed_summed as b

)

select * from final
