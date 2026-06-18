
# SQL Analysis

This folder contains the main BigQuery SQL queries used in my capstone project.

The queries cover the core stages of the analysis:

- creating and preparing the main child health analysis table
- calculating the number of risk factors for each child
- exploring combinations of multiple risk factors
- identifying top risk-factor combinations across parental education groups
- preparing selected results for visualization

## Files

- `01_create_clean_child_health_table.sql` — creates the main analysis table and prepares selected variables for further analysis
- `02_risk_factor_count_analysis.sql` — calculates the total number of risk factors and analyzes how outcomes change as risk accumulates
- `03_risk_factor_combinations_analysis.sql` — explores how multiple risk factors appear together
- `04_top_risk_combinations_by_parental_education.sql` — compares common risk-factor combinations across parental education groups

## Notes

The original BigQuery project and dataset names were replaced with generic placeholders for the public version of this portfolio.

Raw data is not included in this repository.
