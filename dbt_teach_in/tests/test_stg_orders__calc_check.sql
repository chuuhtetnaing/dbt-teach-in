{% set this_bool = "false" -%}

with stg_orders__calc_check as (

    select * from {{ ref('stg_orders__calc_check') }}

)

select
    order_id

from
    stg_orders__calc_check

where
    same_reveue is {{ this_bool }}
or
    same_cost is {{ this_bool }}
or
    same_profit is {{ this_bool }}
