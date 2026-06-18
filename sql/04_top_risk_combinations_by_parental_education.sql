-- BigQuery SQL
-- Note: Table names were anonymized for public portfolio use.
-- Raw data is not included in this repository.
WITH base AS (
  SELECT
    CSHCN_2324,
    fwc_2324,
    AdultEduc_2324,

    CASE WHEN ScreenTime_2324 >= 3 THEN 1 ELSE 0 END AS r_screen,
    CASE WHEN HrsSleep_2324 = 2 THEN 1 ELSE 0 END AS r_sleep,
    CASE WHEN PhysAct_2324 = 1 THEN 1 ELSE 0 END AS r_activity,
    CASE WHEN FoodSit_2324 IN (3,4) THEN 1 ELSE 0 END AS r_food,
    CASE WHEN NbhdSafe_2324 = 3 THEN 1 ELSE 0 END AS r_neighborhood,
    CASE WHEN ACE2more_2324 >= 2 THEN 1 ELSE 0 END AS r_ace
  FROM `project.dataset.nsch_clean` 
),

combos AS (
  SELECT
    CSHCN_2324,
    fwc_2324,
    AdultEduc_2324,

    CONCAT(
      IF(r_screen=1, 'Screen+', ''),
      IF(r_sleep=1, 'Sleep+', ''),
      IF(r_activity=1, 'Activity+', ''),
      IF(r_food=1, 'Food+', ''),
      IF(r_neighborhood=1, 'Neighborhood+', ''),
      IF(r_ace=1, 'ACE+', '')
    ) AS combo
  FROM base
)

SELECT
    AdultEduc_2324 AS educ,
    CASE
      WHEN AdultEduc_2324 = 4 THEN 'High degree'
      WHEN AdultEduc_2324 = 3 THEN 'College'
      WHEN AdultEduc_2324 = 2 THEN 'School'
      WHEN AdultEduc_2324 = 1 THEN 'Low education'
    END AS AdultEduc_2324,
    combo,

  ROUND(SUM(fwc_2324), 0) AS total_children,

  ROUND(
    SUM(CASE WHEN CSHCN_2324 = 1 THEN fwc_2324 ELSE 0 END)
    / SUM(fwc_2324),
    4
  ) AS cshcn_rate

FROM combos
WHERE combo != ''
GROUP BY AdultEduc_2324, combo, educ
HAVING SUM(fwc_2324) > 30000
ORDER BY educ, cshcn_rate DESC;