SELECT COUNT(*)
FROM bank_marketing;

SELECT *
FROM bank_marketing;

SELECT y,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS PERC_RESULT
FROM bank_marketing
GROUP BY y;
-- 89% no, 11% yes

SELECT COUNT(*),
       bank_marketing.campaign
FROM bank_marketing
GROUP BY campaign;
-- Big discrepancies in the calls per campaign; not sure its worth
-- analyzing at the campaign level

SELECT CONTACTED,
       COUNT(*)                                           AS COUNT_OF_CONTACTED,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS PERCENTAGE
FROM (SELECT CASE
                 WHEN previous > 0 THEN 'PREVIOUSLY CALLED'
                 ELSE 'FIRST CONTACT' END AS "CONTACTED"
      FROM bank_marketing
      WHERE y = 'yes')
GROUP BY CONTACTED;
-- 32% 0f the individuals that said yes were contacted previously

-- Does it matter how recently they were contacted for a 2nd time? 'pdays'
SELECT
    CASE WHEN pdays IS NOT NULL AND pdays <= 10 THEN 'Y' ELSE 'N' END AS RECENT_CONTACT,
    COUNT(CASE WHEN y = 'yes' THEN 1 END) AS TOTAL_YES,
    COUNT(CASE WHEN y = 'no' THEN 1 END) AS TOTAL_NO,
    ROUND(COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS SUCCESS_RATE
FROM bank_marketing
WHERE previous > 0
GROUP BY CASE WHEN pdays IS NOT NULL AND pdays <= 10 THEN 'Y' ELSE 'N' END
-- ~65% success rate when a contacted within 10 days of the previous call
-- At this point, it seems that a few statements can be made about the campaigns:
        -- Early campaigns saw much more action (number of calls)
        -- Less than half (~32%) of contacts were called for a 2nd time
        -- Success rate increases to ~65% if contacted again under 10 days

-- Stakeholder feedback; build consistency in campaign efforts to draw additional analysis
-- & if no, contact again within 10 days to see better results
