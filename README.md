MoPhones Credit Portfolio Analysis

This project provides an analysis of MoPhones’ credit portfolio across multiple quarters, focusing on loan performance, repayment behavior, arrears, and account statuses. The pipeline is built using dbt with DuckDB as the underlying database.

Project Overview

The purpose of this project is to generate actionable insights into MoPhones’ credit portfolio. The analysis covers:

Quarterly loan performance: total loans, total paid, balances, and delinquency trends.

Customer repayment behavior: timing, arrears, and payment consistency.

Account status distributions: across different customer segments.

Integration with customer experience: linking credit performance to satisfaction metrics (NPS).

All data is modeled in staging (stg_), intermediate (int_), and fact (fact_) tables to allow scalable analysis over time.

Models
Model	Description
stg_credit	Staging table combining credit data from all quarters. Cleans and normalizes raw quarterly datasets (creditdata-q1 through creditdata-q5).
stg_sales_customers	Staging table for sales and customer information. Cleans and standardizes identifiers and loan terms.
int_loans	Intermediate table aggregating all loans across quarters. Calculates balances, arrears, and customer-level metrics.
fact_payments	Fact table capturing individual payments, expected payments, and adjustments over time.
agg_loans_by_quarter	Aggregated metrics by quarter: total loans, total paid, total balance, and average days past due.
fact_nps	Fact table for customer satisfaction (NPS) scores, linked to loan and payment behavior.

Note: All stg_ tables serve as clean staging layers for raw inputs, while int_ and fact_ tables are used for analysis and reporting.

How to Run the Pipeline

Activate the Python environment

conda activate dbt-env


Install dependencies

dbt deps


Run dbt models

dbt run


Test the data

dbt test


Preview any model (for a snapshot of data)

dbt show --select <model_name>


Data Flow

Raw quarterly credit datasets (creditdata-q1 to creditdata-q5) are ingested into staging tables (stg_credit).

Sales and customer information is cleaned in stg_sales_customers.

Staging data is merged and aggregated in int_loans.

Payment events are captured in fact_payments.

Aggregated quarterly metrics are generated in agg_loans_by_quarter for reporting.

Insights are exported in the insights/data_insights_Q1-Q5.xlsx file for analysis.


Known Limitations


Duplicate LOAN_IDs: Some records share the same LOAN_ID, which may inflate aggregates.

Missing LOAN_TERM: Several loans do not have term information, limiting term-based analysis.

Missing Customer IDs: Some payment or loan records are missing customer identifiers, affecting customer-level segmentation.

Point-in-time snapshots: Data represents specific dates per quarter; changes between snapshots are not tracked continuously.

Staging inconsistencies: Some fields (e.g., balance, discount, overpayment_amount) are missing for certain quarters.

Users should interpret trends with these limitations in mind. Further cleaning or enrichment is recommended for operational decision-making.


Output / Insights


Detailed portfolio analysis is available in the insights/data_insights_Q1-Q5.xlsx file. This includes:

Quarterly loan volumes, total collections, outstanding balances, and average delinquency.

Distribution of account statuses across customer segments.

Payment timing and arrears trends.

High-level insights into portfolio health and risk metrics.


Recommendations


Track customer-level LOAN_TERM and unique customer IDs consistently across all quarters.

Flag duplicate LOAN_IDs early to avoid inflated metrics.

Incorporate continuous payment monitoring between quarter snapshots.

Integrate NPS and other satisfaction metrics directly with payment recovery performance to balance risk and customer experience.

Enhance reporting to highlight delinquency trends, high-risk segments, and overdue balances dynamically.
