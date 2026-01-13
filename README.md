MoPhones Credit Portfolio Analysis

This project analyzes MoPhones’ credit portfolio performance across multiple quarters (Q1–Q5), focusing on loan performance, repayment behavior, arrears, defaults, and account status distributions.

The analytics pipeline is built using dbt with DuckDB as the underlying analytical database.

📌 Project Overview

The goal of this project is to generate clear, decision-ready insights into MoPhones’ credit portfolio, while maintaining a clean, modular analytics structure that can scale as new data becomes available.

Key areas covered include:

Quarterly loan performance
Total loans issued, collections, outstanding balances, and delinquency trends.

Customer repayment behavior
Payment timing, arrears, missed payments, and recovery patterns.

Account status distribution
Portfolio composition across repayment states (active, late, defaulted, etc.).

Customer experience linkage
High-level relationship between credit outcomes and customer satisfaction (NPS).

The project follows a layered dbt architecture:

stg_ → clean raw inputs

int_ → business logic & transformations

fact_ / agg_ / reports_ → analytics & reporting

🧱 Models
Model	Description
stg_credit-	Staging model that unions credit data from all quarters (creditdata-q1 → creditdata-q5). Cleans data types, dates, and standardizes fields.

stg_sales_customers -	Cleans and standardizes sales and customer attributes, including loan terms and identifiers.

int_loans -	Core intermediate model aggregating loans across quarters. Calculates balances, arrears indicators, and customer-level metrics.

fact_payments -	Fact table capturing payment activity, expected payments, and timing behavior by loan and quarter.

agg_loans_by_quarter -	Aggregated quarterly portfolio metrics: loan count, total paid, outstanding balance, and average days past due.

fact_nps -	Customer satisfaction (NPS) scores linked at a high level to loan and payment behavior.

reports.account_status -	Reporting-ready view summarizing account status distribution across quarters.

reports.quarterly_summary	Executive-style quarterly snapshot of portfolio health metrics.


Note:
stg_ models are strictly for data cleanliness.
int_, fact_, agg_, and reports_ models are used for analysis and storytelling.

▶️ How to Run the Pipeline

1️⃣ Activate the Python environment

conda activate dbt-env

2️⃣ Install dependencies

dbt deps

3️⃣ Run all models

dbt run

4️⃣ Run data quality tests

dbt test

👀 Preview Real Data in the Terminal (Recommended as its easier with few setup)

This project uses DuckDB, so you do not need to install DuckDB separately to view results.
dbt can query DuckDB directly and preview live data.

Preview any model
dbt show --select <model_name>

Examples
dbt show --select int_loans
dbt show --select fact_payments
dbt show --select agg_loans_by_quarter
dbt show --select reports.account_status


This allows reviewers to:

Inspect real transformed data

Validate assumptions

See results without exporting files or opening a database UI

🔄 Data Flow

Raw quarterly credit datasets (creditdata-q1 → creditdata-q5)
→ staged in stg_credit

Sales & customer reference data
→ cleaned in stg_sales_customers

Loan-level aggregation & metrics
→ built in int_loans

Payment behavior modeling
→ captured in fact_payments

Quarterly portfolio summaries
→ produced in agg_loans_by_quarter and reports models

Analytical insights
→ summarized separately in Insights/data_insights.csv

⚠️ Known Limitations

This analysis is constrained by several data quality and structural limitations:

Duplicate LOAN_IDs
Some loans appear multiple times, which may inflate aggregates.

Missing LOAN_TERM
Limits term-based and maturity analysis.

Missing customer identifiers
Reduces accuracy of customer-level segmentation and lifecycle tracking.

Point-in-time snapshots
Quarterly data represents fixed dates; intra-quarter changes are not observable.

Field inconsistencies across quarters
Columns such as balance, discount, or overpayment_amount are not consistently populated.

As a result, findings should be interpreted as directional portfolio insights, not operational truth.

📊 Outputs / Insights

Detailed analytical outputs are stored separately in:

Insights/data_insights.csv


This file contains:

Quarterly loan volumes and collections

Outstanding balances and delinquency trends

Account status distributions

High-level portfolio health indicators

Why separate?
The README remains public and technical, while insights stay focused, controlled, and presentation-ready.

📈 Recommendations

Based on the analysis and data limitations:

Enforce unique customer and loan identifiers

Track LOAN_TERM consistently across all records

Flag duplicate LOAN_IDs at ingestion time

Capture continuous payment events, not just quarter-end snapshots

Integrate credit outcomes with NPS more tightly to balance recovery and customer experience

Add automated alerts for rising delinquency and high-risk segments

ℹ️ What This Project Is 

This project is:

An analytical portfolio assessment

A dbt-modeled credit data pipeline

Designed for insight generation and learning
