-- models/intermediate/int_loans.sql

with credit as (

    select
        loan_id,
        date,
        customer_age,
        total_paid,
        total_due_today,
        balance,
        days_past_due,
        closing_balance,
        advance,
        balance_due_to_date,
        arrears,
        balance_due_status,
        payment,
        expected_payment,
        first_payment,
        first_expected_payment,
        account_status_l1,
        account_status_l2,
        return_date,
        sale_date,
        credit_check_done,
        payment_amount,
        adjustment_amount,
        prepayment_amount,
        deposit,
        weekly_rate,
        credit_expiry,
        next_invoice_date,
        discount,
        overpayment_amount,
        max_payment_date,
        initial_pay,
        total_paid_with_adjustments_15d,
        quarter
    from {{ ref('stg_credit') }}

),

sales as (

    select
        loan_id,
        sale_date,
        product_name,
        model,
        business_model,
        loan_term,
        seller,
        seller_type
    from {{ ref('stg_sales_customers') }}

)

select
    c.loan_id,
    c.date,
    c.customer_age,
    c.total_paid,
    c.total_due_today,
    c.balance,
    c.days_past_due,
    c.closing_balance,
    c.advance,
    c.balance_due_to_date,
    c.arrears,
    c.balance_due_status,
    c.payment,
    c.expected_payment,
    c.first_payment,
    c.first_expected_payment,
    c.account_status_l1,
    c.account_status_l2,
    c.return_date,
    c.sale_date,
    c.credit_check_done,
    c.payment_amount,
    c.adjustment_amount,
    c.prepayment_amount,
    c.deposit,
    c.weekly_rate,
    c.credit_expiry,
    c.next_invoice_date,
    c.discount,
    c.overpayment_amount,
    c.max_payment_date,
    c.initial_pay,
    c.total_paid_with_adjustments_15d,
    c.quarter,

    -- sales attributes (correct source)
    s.product_name,
    s.model,
    s.business_model,
    s.loan_term,
    s.seller,
    s.seller_type

from credit c
left join sales s
    on c.loan_id = s.loan_id
