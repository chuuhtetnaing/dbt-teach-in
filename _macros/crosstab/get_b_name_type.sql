{% macro get_b_name_type(tbl_name, col_name, col_type='float8') %}
    {%- set columns = dbt_utils.get_column_values(ref(tbl_name), col_name) | list | sort -%}
    {%- for column in columns %}
        "{{ column }}" {{ col_type }}
        {%- if not loop.last -%}
        ,
        {%- endif -%}
    {%- endfor %}
{%- endmacro %}