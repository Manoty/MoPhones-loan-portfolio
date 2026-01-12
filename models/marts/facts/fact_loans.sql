-- models/marts/facts/fact_loans.sql

select
    loan_id,
    quarter,

    -- financials
    total_paid,
    total_due_today,
    balance,
    closing_balance,
    arrears,

    -- risk signals
    days_past_due,
    balance_due_status,
    account_status_l1,
    account_status_l2,

    -- payments
    payment,
    expected_payment,
    total_paid_with_adjustments_15d,

    -- lifecycle
    sale_date,
    return_date,
    credit_expiry

from {{ ref('int_loans') }}
