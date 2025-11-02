-- File: rfm_base.sql
-- Purpose: База для RFM (Recency/ Frequency/ Monetary).
-- Source: order_items (агрегація до order_id), далі на user_id
-- Output: thelook_ecommerce_project.rfm_base

CREATE OR REPLACE TABLE
  `my-educational-project-476420.thelook_ecommerce_project.rfm_base` AS
WITH order_amounts AS (
  SELECT
    oi.order_id,
    oi.user_id,
    MAX(oi.created_at) AS order_date,
    ROUND(SUM(oi.sale_price), 2) AS amount
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  WHERE oi.returned_at IS NULL
    AND oi.status = 'Complete'
  GROUP BY oi.order_id, oi.user_id
),
last_date AS (
  SELECT MAX(order_date) AS max_date FROM order_amounts
)
SELECT
  oa.user_id,
  DATE_DIFF((SELECT max_date FROM last_date), MAX(oa.order_date), DAY) AS recency_days,
  COUNT(DISTINCT oa.order_id) AS frequency,
  ROUND(SUM(oa.amount), 2) AS monetary
FROM order_amounts AS oa
GROUP BY oa.user_id;
