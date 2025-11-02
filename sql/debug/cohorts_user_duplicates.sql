-- Користувачі з >1 записом у cohorts_base (норма: багатомісячні замовлення)
SELECT
  user_id,
  COUNT(*) AS cnt
FROM `my-educational-project-476420.thelook_ecommerce_project.cohorts_base`
GROUP BY 1
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
