select
    "Submission ID" as submission_id,
    "Respondent ID" as respondent_id,
    "Submitted at" as submitted_at,
    "Loan Id" as loan_id,
    cast(
        "Using a scale from 0 (not likely) to 10 (very likely), how likely are you to recommend MoPhones to friends or family?"
        as integer
    ) as nps_score,
    "What is the main reason for your score?" as nps_reason,
    "Are you happy with the quality and performance of your MoPhones device?" as happy_with_device,
    "Are you happy with the service and support provided by MoPhones?" as happy_with_support
from {{ ref('nps') }}
