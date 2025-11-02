-- File: monthly_revenue.sql
-- Purpose: Monthly revenue (сума sale_price). Опційно можна виключити повернення/скасування.
-- Source: bigquery-public-data.thelook_ecommerce.order_items
-- Output: (використовується як SELECT-вигляд або матеріалізується окремо при потребі)

SELECT
  DATE_TRUNC(oi.created_at, MONTH) AS month,
  ROUND(SUM(oi.sale_price), 2) AS revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
-- WHERE oi.returned_at IS NULL AND oi.status = 'Complete'  -- опційно
GROUP BY month
ORDER BY month;
