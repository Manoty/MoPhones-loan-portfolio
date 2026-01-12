select
    loan_id,
    count(distinct loan_id) as total_loans,
    sum(balance) as total_balance,
    sum(total_paid) as total_paid,
    avg(days_past_due) as avg_days_past_due
from {{ ref('fact_loans') }}
group by loan_id
