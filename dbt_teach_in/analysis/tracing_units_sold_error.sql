{#--

    Apparently there was an error in the "units_sold" where
    the number was doubled in the month of June 2017.

    Use this query with the snapshot table to be able to
    put yourself at the point in time before or after the fix
    was executed (i.e. the fix was on '2017-07-01')

-#}

-- Tracing back to the state before the Error was fixed.
with base as (
    select row_number() over (partition by id order by dbt_valid_from desc) as rn,
           *
    from dbt_snapshots.orders_snapshot_backup

    -- [Comment/uncomment either one]

    -- Before the fix, will be high
    where dbt_valid_from < '2017-07-01'

    -- After the fix, should be lower
    -- where dbt_valid_from <= '2017-07-01'

    order by id asc
)
select item_type_id,
       sum(units_sold)
from base
where true
  and rn = 1
  and ship_date < '2017-07-01'
group by 1
order by 1
;

