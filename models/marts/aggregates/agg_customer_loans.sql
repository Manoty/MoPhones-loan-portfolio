select
    age_segment,
    income_segment,
    gender,

    count(distinct loan_id) as total_loans,

    avg(balance) as avg_balance,
    avg(days_past_due) as avg_days_past_due,

    sum(case when arrears > 0 then 1 else 0 end) as loans_in_arrears,
    sum(case when account_status_l1 = 'Default' then 1 else 0 end) as defaults

from {{ ref('int_customer_segments') }} c
join {{ ref('fact_loans') }} l
    on c.loan_id = l.loan_id

group by 1,2,3
limit 30
