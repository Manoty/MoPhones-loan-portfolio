with dob as (
    select
        loan_id,
        cast(date_of_birth as date) as dob
    from {{ ref('stg_customer_dob') }}
    where date_of_birth is not null
      and date_of_birth != '#N/A'
),

credit_dates as (
    select
        loan_id,
        snapshot_date
    from {{ ref('fact_loans') }}
),

age_calc as (
    select
        d.loan_id,
        c.snapshot_date,
        date_diff('year', d.dob, c.snapshot_date) as age
    from dob d
    join credit_dates c
        on d.loan_id = c.loan_id
)

select
    loan_id,
    snapshot_date,
    age,

    case
        when age between 18 and 25 then '18–25'
        when age between 26 and 35 then '26–35'
        when age between 36 and 45 then '36–45'
        when age between 46 and 55 then '46–55'
        when age > 55 then 'Above 55'
        else 'Unknown'
    end as age_segment

from age_calc
