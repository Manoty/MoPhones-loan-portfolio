-- models/marts/dim_customer.sql

with dob as (
    select
        "Loan Id" as loan_id,
        date_of_birth
    from {{ ref('stg_customer_dob') }}
),

gender as (
    select
        "Loan Id" as loan_id,
        gender
    from {{ ref('stg_customer_gender') }}
),

income as (
    select
        "Loan Id" as loan_id,
        duration,
        received
            + "Persons Received From Total"
            + "Banks Received"
            + "Paybills Received Others" as total_income
    from {{ ref('stg_customer_income') }}
)

select
    d.loan_id,
    d.date_of_birth,

    -- AGE
    date_diff('year', d.date_of_birth, {{ var('reporting_date') }}) as age,

    -- AGE SEGMENT (REQUIRED)
    case
        when age between 18 and 25 then '18–25'
        when age between 26 and 35 then '26–35'
        when age between 36 and 45 then '36–45'
        when age between 46 and 55 then '46–55'
        else 'Above 55'
    end as age_segment,

    g.gender,

    -- AVG INCOME
    total_income / nullif(i.duration, 0) as avg_income,

    -- INCOME SEGMENT (REQUIRED)
    case
        when avg_income < 5000 then 'Below 5,000'
        when avg_income between 5000 and 9999 then '5,000–9,999'
        when avg_income between 10000 and 19999 then '10,000–19,999'
        when avg_income between 20000 and 29999 then '20,000–29,999'
        when avg_income between 30000 and 49999 then '30,000–49,999'
        when avg_income between 50000 and 99999 then '50,000–99,999'
        when avg_income between 100000 and 149999 then '100,000–149,999'
        else '150,000 and above'
    end as income_segment

from dob d
left join gender g on d.loan_id = g.loan_id
left join income i on d.loan_id = i.loan_id
