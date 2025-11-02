-- Попередній перегляд таблиці конверсії (з приведенням поля-дат)
SELECT
  DATE(registration_month) AS registration_month,
  total_users,
  paying_users,
  conversion_rate_percent
FROM `my-educational-project-476420.thelook_ecommerce_project.conversion_from_reg_to_paying`
ORDER BY registration_month;
