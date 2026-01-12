SELECT 
    quarter,
    "ACCOUNT_STATUS_L1",
    COUNT(*) AS loans_count
FROM {{ ref('int_loans') }}
GROUP BY quarter, "ACCOUNT_STATUS_L1"
ORDER BY quarter, "ACCOUNT_STATUS_L1"
