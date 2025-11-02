-- Скільки унікальних платників у замовленнях
SELECT COUNT(DISTINCT user_id) AS paying_customers
FROM `bigquery-public-data.thelook_ecommerce.orders`;
