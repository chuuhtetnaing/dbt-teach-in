{{
    config({
        "materialized" : "table",
        "pre-hook": [
            "create extension if not exists tablefunc ",
        ],
        "tags": [
            "distances",
        ],
    })
}}


{% set stg_ref = 'stg_orders__countries_units_sold__fruits' -%}
{% set stg_item_type = 'Fruits' -%}
{% set a_name = 'a_country' -%}
{% set b_name = 'b_country' -%}

with final as (

    select
        a_name,
        {{ get_b_name_columns(stg_ref, b_name) }}
    from
        crosstab(
            'select
                {{ a_name }} ,
                {{ b_name }} ,
                units_sold_diff
             from "{{ target.database }}"."{{ target.schema }}"."{{ stg_ref }}"
            ',
            $$VALUES {{ get_b_name_value(stg_ref, b_name) }} $$
        ) as ct (
            a_name text, {{ get_b_name_type(stg_ref, b_name, 'int8') }}
        )
    order by 1 asc
)

select * from final
