-- Скільки подій за типом (для sanity-check)
SELECT
  event_type,
  COUNT(*) AS events
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE user_id IS NOT NULL
GROUP BY 1
ORDER BY events DESC;
