
{{ config(
    materialized='view'
) }}

select
    quarter,
    account_status_l1,
    count(*) as loans_count
from {{ ref('int_loans') }}
group by quarter, account_status_l1
order by quarter, account_status_l1
