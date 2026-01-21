select
    s.age_segment,
    count(distinct f.loan_id) as total_loans,
    sum(f.balance) as total_balance,
    avg(f.days_past_due) as avg_dpd
from {{ ref('fact_loans') }} f
join {{ ref('int_customer_segments') }} s
  on f.loan_id = s.loan_id
 and f.snapshot_date = s.snapshot_date
group by s.age_segment
