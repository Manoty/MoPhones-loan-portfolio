-- models/marts/facts/fact_payments.sql

select
    loan_id,
    quarter,

    -- payment activity
    payment,
    payment_amount,
    expected_payment,
    first_payment,
    first_expected_payment,
    total_paid,
    total_paid_with_adjustments_15d,

    -- adjustments & special cases
    adjustment_amount,
    prepayment_amount,
    discount,
    overpayment_amount,
    deposit,
    advance,

    -- balances
    balance,
    closing_balance,
    balance_due_to_date,
    arrears,
    total_due_today,

    -- delinquency indicators
    days_past_due,
    balance_due_status,

    -- lifecycle dates
    sale_date,
    return_date,
    next_invoice_date,
    max_payment_date

from {{ ref('int_loans') }}
