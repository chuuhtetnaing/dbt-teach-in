{% snapshot raw_orders_snapshot %}

{{
    config(
      target_database='postgres',
      target_schema='dbt_snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ ref('raw_orders') }}
{#--

    -- Alternative referencing via source:
    -- select * from {{ source('dbt_seeds', 'raw_orders') }}

-#}

{% endsnapshot %}
