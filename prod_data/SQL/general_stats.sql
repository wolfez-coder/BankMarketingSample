SELECT COUNT(*)
FROM bank_marketing;
-- 41,118 clients contacts

SELECT *
FROM bank_marketing;
-- All data

SELECT y,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM bank_marketing
GROUP BY y;
-- 89% no, 11% yes

SELECT bank_marketing.campaign,
       y,
       count(y) count_of_total_by_campaign,
       round(count(y) * 100.0 / sum(count(y)) over (partition by campaign),2)  percentage
FROM bank_marketing
GROUP BY campaign, y;
-- percentage by outcome over campaign

SELECT p_contact,
       COUNT(*)                                                         AS count_of_clients,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2)               AS percentage,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*), 2) as succses_rate
FROM (SELECT y,
             CASE
                 WHEN previous = 0 THEN 'New Client'
                 WHEN previous = 1 or previous = 2 THEN '1-2'
                 WHEN previous >= 3 THEN '3+'
                 END AS "p_contact"
      FROM bank_marketing)
GROUP BY p_contact;
-- most clients did not have a previous contact, but for those that did their success_rates were much higher

SELECT p_contact,
       poutcome,
       COUNT(*) AS client_count,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM (
    SELECT y,
           poutcome,
           CASE
               WHEN previous = 0 THEN 'New Client'
               WHEN previous BETWEEN 1 AND 2 THEN '1-2'
               WHEN previous >= 3 THEN '3+'
           END AS p_contact
    FROM bank_marketing
) sub
WHERE p_contact = '3+'
GROUP BY p_contact, poutcome
ORDER BY success_rate DESC;
-- Where previous was 3+ and poutcome success ~75% success_rate

SELECT
    CASE WHEN pdays IS NOT NULL AND pdays != 999 AND pdays <= 10 THEN 'Y' ELSE 'N' END AS RECENT_CONTACT,
    COUNT(CASE WHEN y = 'yes' THEN 1 END) AS TOTAL_YES,
    COUNT(CASE WHEN y = 'no' THEN 1 END) AS TOTAL_NO,
    ROUND(COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS SUCCESS_RATE
FROM bank_marketing
WHERE previous > 0
GROUP BY CASE WHEN pdays IS NOT NULL AND pdays <= 10 THEN 'Y' ELSE 'N' END;
-- ~65% success rate when a contacted within 10 days of the previous call

SELECT bank_marketing.campaign,
       bank_marketing.poutcome,
       count(*)                                                                               as total_client,
       count(case when y = 'yes' then 1 end)                                                  as yes_count,
       count(case when y = 'no' then 1 end)                                                   as no_count,
       ROUND(100.0 * SUM(CASE WHEN bank_marketing.y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_rate
FROM bank_marketing
GROUP BY bank_marketing.campaign, bank_marketing.poutcome;
-- success rate by campaign & poutcome

select bank_marketing.month,
       count(*)                                                                          as total_client,
       count(case when y = 'yes' then 1 end)                                             as yes_count,
       count(case when y = 'no' then 1 end)                                              as no_count,
       round(count(case when bank_marketing.y = 'yes' then 1 end) * 100.0 / count(*), 2) as success_rate
from bank_marketing
group by month
order by success_rate desc;
-- success rate by month

SELECT
    y AS outcome,
    COUNT(*) AS total_clients,
    ROUND(AVG(duration) / 60.0, 1) AS avg_duration_minutes
FROM
    bank_marketing
GROUP BY y;

SELECT duration_bucket,
       COUNT(*)                                                                AS count_of_clients,
       ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM (SELECT y,
             CASE
                 WHEN duration <= 60 THEN '0-1 Min'
                 WHEN duration > 60 AND duration <= 180 THEN '1-3 Min'
                 WHEN duration > 180 AND duration <= 300 THEN '3-5 Min'
                 WHEN duration > 300 AND duration <= 600 THEN '5-10 Min'
                 ELSE '10+ Min'
                 END AS duration_bucket
      FROM bank_marketing) AS t1
GROUP BY duration_bucket
ORDER BY 3 desc