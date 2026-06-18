-- BigQuery SQL
-- Note: Table names were anonymized for public portfolio use.
-- Raw data is not included in this repository.
WITH scored AS (
  SELECT
    CSHCN_2324,
    age3_2324,
    fwc_2324,

    (CASE WHEN ScreenTime_2324 >= 3 THEN 1 ELSE 0 END) +
    (CASE WHEN HrsSleep_2324 = 2 THEN 1 ELSE 0 END) +
    (CASE WHEN PhysAct_2324 = 1 THEN 1 ELSE 0 END) +
    (CASE WHEN FoodSit_2324 IN (3, 4) THEN 1 ELSE 0 END) +
    (CASE WHEN NbhdSafe_2324 = 3 THEN 1 ELSE 0 END) +
    (CASE WHEN ACE2more_2324 >= 2 THEN 1 ELSE 0 END)
    AS risk_factor_count

  FROM `project.dataset.nsch_clean`
  WHERE
    CSHCN_2324 IN (1, 2)
    AND fwc_2324 IS NOT NULL
    AND ScreenTime_2324 IS NOT NULL AND
    HrsSleep_2324 IS NOT NULL AND
    PhysAct_2324 IS NOT NULL AND
    FoodSit_2324 IS NOT NULL AND
    NbhdSafe_2324 IS NOT NULL AND
    ACE2more_2324 IS NOT NULL
)

SELECT
  CASE WHEN age3_2324 = 2 THEN '6-11' ELSE '12-17' END AS age3_2324,

  CASE
    WHEN risk_factor_count >= 4 THEN '4+'
    ELSE CAST(risk_factor_count AS STRING)
  END AS risk_factor_group,

  ROUND(SUM(fwc_2324), 0) AS total_children,

  ROUND(
    SUM(CASE WHEN CSHCN_2324 = 1 THEN fwc_2324 ELSE 0 END)
    / SUM(fwc_2324),
    4
  ) AS cshcn_rate

FROM scored
GROUP BY age3_2324, risk_factor_group
ORDER BY age3_2324, risk_factor_group;