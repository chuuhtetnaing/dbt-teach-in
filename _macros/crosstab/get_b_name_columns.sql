{%- macro get_b_name_columns(tbl_name, col_name) -%}
    {%- set columns = dbt_utils.get_column_values(ref(tbl_name), col_name) | list | sort -%}
    {%- for column in columns %}
        coalesce( "{{ column }}" , 0) as "{{ column }}"
        {%- if not loop.last -%}
        ,
        {%- endif -%}
    {%- endfor %}
{%- endmacro %}