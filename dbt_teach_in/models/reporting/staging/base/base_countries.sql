{{
    config(
        materialized='ephemeral',
    )
}}


with countries as (

    select * from {{ ref('countries') }}

)

, col_renamed as (

    select
        id as country_id
      , country
      , has_online_sale_channel
      , has_offline_sale_channel
      , region_id
      , created_at
      , updated_at
    from
        countries

)

select * from col_renamed

