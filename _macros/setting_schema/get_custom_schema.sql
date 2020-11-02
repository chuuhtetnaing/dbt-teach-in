-- DO NOT USE THIS IN THE PRODUCTION `de-dbt` REPOSITORY!
-- This will handle the materialisation in proper schemas base on the target in `profiles.yml`
-- If target is Redshift, all materialisation will occur only in the user schema, e.g. `usr_blee`
-- Other target means the tables will be materialised in custom schema names.


{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set production_targets = ('redshift', 'prod') -%}


    {%- if target.name in production_targets -%}

        {{ target.schema.lower() | trim }}

    {%- else -%}

        {%- if custom_schema_name is none -%}

            {{ target.schema.lower() | trim }}

        {%- else -%}

            {{ target.schema.lower() }}_{{ custom_schema_name | trim }}

        {%- endif -%}

    {%- endif -%}


{%- endmacro %}