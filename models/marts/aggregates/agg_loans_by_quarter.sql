select
    quarter,
    count(distinct loan_id) as total_loans,
    sum(total_paid) as total_paid,
    sum(balance) as total_balance,
    avg(days_past_due) as avg_days_past_due
from {{ ref('fact_loans') }}
group by quarter

