{{
    config(
        materialized='ephemeral',
    )
}}


with item_types as (

    select * from {{ ref('raw_item_types') }}

)

, col_renamed as (

    select
        id as item_type_id
      , item_type
      , unit_price
      , unit_cost
      , created_at
      , updated_at
    from
        item_types

)

select * from col_renamed

