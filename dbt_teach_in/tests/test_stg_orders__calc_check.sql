{#
    -- This test basically checks if the given values and the derived values are the same or not
    -- If they are not the same (i.e. `false`), then return the rows and fail the test!
-#}
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
