{% docs tracing_units_sold_error %}

# Example Snapshots Use Case
---
Using Snapshot table to see the before vs after as fix 

![UsingSnapshots](/assets/Using_Snapshots.png)

## SQL Query used
> _Note: did not bother optimising :P_

```postgresql
-- Tracing back to the state before the Error was fixed.
with base_before as (
    
    select row_number() over (partition by id order by dbt_valid_from desc) as rn,
           *
    from dbt_snapshots.orders_snapshot_backup
    
    -- Before the fix, will be high
    where dbt_valid_from < '2017-07-01'

    order by id asc

)

, "bbefore" as (

    select item_type_id,
           sum(units_sold)
    from base_before
    where true
      and rn = 1
      and ship_date < '2017-07-01'
    group by 1
    order by 1

)

, base_after as (
    select row_number() over (partition by id order by dbt_valid_from desc) as rn,
           *
    from dbt_snapshots.orders_snapshot_backup

    -- After the fix, should be lower
    where dbt_valid_from <= '2017-07-01'

    order by id asc
)

, "aafter" as (
    
    select item_type_id,
           sum(units_sold)
    from base_after
    where true
      and rn = 1
      and ship_date < '2017-07-01'
    group by 1
    order by 1
    
)

select
    b.item_type_id,
    b.sum as sum_before,
    a.sum as sum_after
from 
    "bbefore" as b
left join
    "aafter" as a 
    on b.item_type_id = a.item_type_id
;

```


{% enddocs %}