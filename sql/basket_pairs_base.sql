-- File: basket_pairs_base.sql
-- Purpose: basic table for analysing the buyer's basket (min: order_id, product_id).
-- Source: order_items
-- Output: thelook_ecommerce_project.basket_pairs_base

CREATE OR REPLACE TABLE
  `my-educational-project-476420.thelook_ecommerce_project.basket_pairs_base` AS
SELECT
  order_id,
  product_id
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE returned_at IS NULL
  AND status = 'Complete';
