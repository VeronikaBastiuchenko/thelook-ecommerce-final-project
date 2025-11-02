-- File: aov_by_category.sql
-- Purpose: AOV (Average Order Value) по категоріях.
-- Source: order_items + products + orders
-- Output: thelook_ecommerce_project.aov_by_category

CREATE OR REPLACE TABLE
  `my-educational-project-476420.thelook_ecommerce_project.aov_by_category` AS
WITH order_values AS (
  SELECT
    oi.order_id,
    ROUND(SUM(oi.sale_price), 2) AS order_total
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  WHERE oi.returned_at IS NULL
    AND oi.status = 'Complete'
  GROUP BY oi.order_id
),
order_categories AS (
  SELECT DISTINCT
    oi.order_id,
    p.category
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
    ON oi.product_id = p.id
)
SELECT
  oc.category,
  ROUND(AVG(ov.order_total), 2) AS avg_order_value
FROM order_values AS ov
JOIN order_categories AS oc
  ON ov.order_id = oc.order_id
GROUP BY oc.category
ORDER BY avg_order_value DESC;
