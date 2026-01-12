-- models/staging/stg_sales_customers.sql

select
    "Loan Id"            as loan_id,
    coalesce(sale_id, 'unknown') as SALE_ID,
    SALE_DATE,
    RETURNED,
    
    RETURN_DATE,
    SALE_TYPE,
    SELLER,
    SELLER_TYPE,
    RETURN_POLICY_COMPLIANCE,
    CASH_PRICE,
    LOAN_PRICE,
    CLIENT_MODEL,
    BUSINESS_MODEL,
    LOAN_TERM,
    PRODUCT_NAME,
    MODEL
from {{ ref('sales_customers') }}
