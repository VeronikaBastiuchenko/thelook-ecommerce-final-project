-- File: cohorts_base.sql
-- Purpose: База для когорт — user_id, cohort_month, order_month.
-- Source: orders
-- Output: thelook_ecommerce_project.cohorts_base

CREATE OR REPLACE TABLE
  `my-educational-project-476420.thelook_ecommerce_project.cohorts_base` AS
WITH user_orders AS (
  SELECT
    user_id,
    DATE_TRUNC(created_at, MONTH) AS order_month
  FROM `bigquery-public-data.thelook_ecommerce.orders`
),
firsts AS (
  SELECT user_id, MIN(order_month) AS cohort_month
  FROM user_orders
  GROUP BY user_id
)
SELECT
  uo.user_id,
  f.cohort_month,
  uo.order_month
FROM user_orders AS uo
JOIN firsts AS f
  ON uo.user_id = f.user_id;
