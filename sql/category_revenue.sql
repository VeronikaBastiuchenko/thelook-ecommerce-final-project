-- File: category_revenue.sql
-- Purpose: Сума виручки по категоріях товарів.
-- Source: order_items + products
-- Output: thelook_ecommerce_project.category_revenue

CREATE OR REPLACE TABLE
  `my-educational-project-476420.thelook_ecommerce_project.category_revenue` AS
SELECT
  p.category,
  ROUND(SUM(oi.sale_price), 2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
WHERE oi.returned_at IS NULL
  AND oi.status = 'Complete'
GROUP BY p.category
ORDER BY revenue DESC;
