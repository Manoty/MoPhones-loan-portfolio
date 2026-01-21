with income as (

    select
        loan_id,
        duration,
        coalesce(received, 0)
        + coalesce(persons_received_total, 0)
        + coalesce(banks_received, 0)
        + coalesce(paybills_received_others, 0) as total_income
    from {{ ref('stg_customer_income') }}

),

income_avg as (

    select
        loan_id,
        case
            when duration > 0 then total_income / duration
            else null
        end as avg_income
    from income

),

income_segment as (

    select
        loan_id,
        avg_income,
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
    from income_avg

)

select
    l.loan_id,
    l.date as snapshot_date,

    -- age calculation using SNAPSHOT DATE
    date_diff('year', d.date_of_birth, l.date) as customer_age,

    case
        when date_diff('year', d.date_of_birth, l.date) between 18 and 25 then '18–25'
        when date_diff('year', d.date_of_birth, l.date) between 26 and 35 then '26–35'
        when date_diff('year', d.date_of_birth, l.date) between 36 and 45 then '36–45'
        when date_diff('year', d.date_of_birth, l.date) between 46 and 55 then '46–55'
        else 'Above 55'
    end as age_segment,

    g.gender,
    g.citizenship,

    i.avg_income,
    i.income_segment

from {{ ref('fact_loans') }} l
left join {{ ref('stg_customer_dob') }} d
    on l.loan_id = d.loan_id
left join {{ ref('stg_customer_gender') }} g
    on l.loan_id = g.loan_id
left join income_segment i
    on l.loan_id = i.loan_id
