# SQL Queries

This folder contains all SQL scripts used to create analytical tables in BigQuery for the project **TheLook eCommerce**.

Each query focuses on a specific analytical task and was used to build the dataset for visualization and further analysis.

---

### 🧱 Analytical Tables Created in BigQuery

| Table Name | Description |
|-------------|-------------|
| `aov_by_category` | Calculates the **Average Order Value (AOV)** for each product category. |
| `basket_pairs_base` | Identifies **frequently bought-together product pairs** to analyze cross-selling opportunities. |
| `category_revenue` | Aggregates **total revenue by product category** for ranking and comparison. |
| `cohorts_base` | Builds **monthly customer cohorts** based on their first purchase date for retention analysis. |
| `cohorts_looker` | Final formatted table for **visualizing cohort retention** in Looker Studio. |
| `conversion_from_reg_to_paying` | Calculates **conversion rate** from registered to paying users. |
| `monthly_revenue` | Tracks **monthly revenue dynamics**, including YoY and MoM growth rates. |
| `new_vs_repeat` | Splits users into **new vs returning** segments and calculates their revenue share. |
| `pareto_products` | Determines which products fall into the **top 20% that generate 80% of total revenue** (Pareto principle). |
| `rfm_base` | Creates the base dataset for **RFM segmentation** using Recency, Frequency, and Monetary metrics. |
| `total_customers` | Counts **unique registered and paying customers** over time for conversion and engagement tracking. |

---

### 📁 Folder Structure

All SQL scripts are stored in this folder:

/sql/
│
├── aov_by_category.sql
├── basket_pairs_base.sql
├── category_revenue.sql
├── cohorts_base.sql
├── cohorts_looker.sql
├── conversion_from_reg_to_paying.sql
├── monthly_revenue.sql
├── new_vs_repeat.sql
├── pareto_products.sql
├── rfm_base.sql
└── total_customers.sql

---

All queries are designed to run directly in **Google BigQuery** under the dataset:
my-educational-project-476420.thelook_ecommerce_project
Each script was saved and versioned for reproducibility of results and can be executed independently.
