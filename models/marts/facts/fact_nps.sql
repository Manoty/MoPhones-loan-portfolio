-- models/marts/facts/fact_nps.sql

select
    loan_id,
    submission_id,
    submitted_at as survey_date,
    nps_score,
    nps_reason
from {{ ref('stg_nps') }}
