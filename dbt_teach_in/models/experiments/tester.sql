{% set now = modules.datetime.datetime.now() %}
{% set now_str = now.strftime('%Y%m%d_%H%M') %}

{{
    config(
        materialized='table',
        post_hook=[
            "{{ crazy_create_table_loop( this.schema , this.name ) }}",
        ],
    )
}}
--             "drop table if exists {{ this.schema }}.{{ this.name }}_fruit_only",
--             "create table {{ this.schema }}.{{ this.name}}_fruit_only as (select * from {{ this }} where item_type = 'Fruits')",

with dim_orders__dashboard as (

    select * from {{ ref('dim_orders__dashboard') }}

)

, experiement_minute_x_profit as (

    select
          order_id
        , item_type
        , total_profit                      as ori_total_profit
        , {{ now.minute }}                  as multiply_amount
        , total_profit * {{ now.minute }}   as exp_total_profit

    from
        dim_orders__dashboard

)

select * from experiement_minute_x_profit
