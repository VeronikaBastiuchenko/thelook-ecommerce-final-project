-- File: pareto_products.sql
-- Purpose: Pareto 80/20 по продуктах (частка, кумулятивна частка, bucket A/B/C).
-- Source: order_items + products
-- Output: thelook_ecommerce_project.pareto_products

CREATE OR REPLACE TABLE `my-educational-project-476420.thelook_ecommerce_project.pareto_products` AS
WITH base AS (
  SELECT
    p.id   AS product_id,
    p.name AS product_name,
    p.category,
    ROUND(SUM(oi.sale_price), 2) AS revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  JOIN `bigquery-public-data.thelook_ecommerce.products`     AS p
    ON oi.product_id = p.id
  WHERE oi.status = 'Complete'
    AND oi.returned_at IS NULL
  GROUP BY 1,2,3
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (ORDER BY revenue DESC)                          AS revenue_rank,
    SUM(revenue) OVER (ORDER BY revenue DESC)                          AS running_revenue,
    SUM(revenue) OVER ()                                               AS total_revenue
  FROM base
)
SELECT
  product_id,
  product_name,
  category,
  revenue,
  ROUND(revenue / total_revenue, 4)        AS revenue_share,
  running_revenue,
  total_revenue,
  ROUND(running_revenue / total_revenue,4) AS cumulative_share,
  CASE
    WHEN running_revenue / total_revenue <= 0.80 THEN 'A – Top 20%'
    WHEN running_revenue / total_revenue <= 0.95 THEN 'B – Mid 15%'
    ELSE 'C – Bottom 5%'
  END AS pareto_bucket
FROM ranked
ORDER BY revenue DESC;
