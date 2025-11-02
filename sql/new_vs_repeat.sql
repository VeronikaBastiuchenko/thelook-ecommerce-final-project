-- File: new_vs_repeat.sql
-- Purpose: Розподіл New vs Repeat (замовлення та виручка).
-- Source: orders + order_items
-- Output: thelook_ecommerce_project.new_vs_repeat

CREATE OR REPLACE TABLE
  `my-educational-project-476420.thelook_ecommerce_project.new_vs_repeat` AS
WITH first_purchase AS (
  SELECT user_id, MIN(created_at) AS first_purchase_date
  FROM `bigquery-public-data.thelook_ecommerce.orders`
  GROUP BY user_id
)
SELECT
  CASE
    WHEN DATE(o.created_at) = DATE(fp.first_purchase_date) THEN 'New'
    ELSE 'Repeat'
  END AS buyer_type,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.sale_price), 2) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
JOIN `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  ON o.order_id = oi.order_id
JOIN first_purchase AS fp
  ON o.user_id = fp.user_id
WHERE oi.returned_at IS NULL
  AND o.status = 'Complete'
GROUP BY buyer_type
ORDER BY total_revenue DESC;
