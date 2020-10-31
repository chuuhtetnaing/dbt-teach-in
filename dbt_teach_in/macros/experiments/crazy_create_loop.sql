{#--
This macro re-creates separate tables for each `item_type` from the table `table`

Arguments:
    schema: The schema containing the table `table`, which will also be the same
            schema the seprarate tables will be created in
    table:  The table which the separate tables created will be based on;
            This table should have the `item_type` column
Returns:
    none

-#}



{% macro create_table_loop(schema , table ) -%}

    {#-- Extra indentation so it appears inline when script is compiled. -#}
    {%
        set item_types_list = dbt_utils.get_column_values(
            table=ref('item_types'), column='item_type'
        )
    -%}
    
    
    {% for item_type in item_types_list -%}
        {#-- Extra indentation so it appears inline when script is compiled. -#}
        drop table if exists {{ this.schema }}.{{ this.name }}__{{ item_type.replace(" ", "_") }}_only
        {{ var("colon") }}

        create table {{ schema }}.{{ table }}__{{ item_type.replace(" ", "_") }}_only as (
            select * from {{ schema }}.{{ table }} where item_type = '{{ item_type }}'
        )
        {{ var("colon") }}

    {%- endfor %}

    
{%- endmacro %}

