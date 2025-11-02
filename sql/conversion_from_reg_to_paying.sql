-- File: conversion_from_reg_to_paying.sql
-- Purpose: Конверсія з зареєстрованих у платників (хоча б 1 замовлення).
-- Source: users + orders
-- Output: thelook_ecommerce_project.conversion_from_reg_to_paying

CREATE OR REPLACE TABLE
  `my-educational-project-476420.thelook_ecommerce_project.conversion_from_reg_to_paying` AS
WITH user_orders AS (
  SELECT
    u.id AS user_id,
    u.created_at AS registration_date,
    DATE_TRUNC(u.created_at, MONTH) AS registration_month,
    COUNT(DISTINCT o.order_id) AS orders_count
  FROM `bigquery-public-data.thelook_ecommerce.users`  AS u
  LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` AS o
    ON u.id = o.user_id
  GROUP BY 1,2,3
),
conversion_base AS (
  SELECT
    registration_month,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN orders_count > 0 THEN user_id END) AS paying_users
  FROM user_orders
  GROUP BY registration_month
)
SELECT
  registration_month,
  total_users,
  paying_users,
  ROUND(paying_users / total_users * 100, 2) AS conversion_rate_percent
FROM conversion_base
ORDER BY registration_month;
