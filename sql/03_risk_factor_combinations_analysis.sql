-- BigQuery SQL
-- Note: Table names were anonymized for public portfolio use.
-- Raw data is not included in this repository.
WITH cohort_base AS (
  SELECT
    CSHCN_2324,
    fwc_2324,

    CASE
      WHEN ScreenTime_2324 <= 1 THEN 'Low screen'
      WHEN ScreenTime_2324 = 2 THEN 'Moderate screen'
      WHEN ScreenTime_2324 >= 3 THEN 'High screen'
      ELSE NULL
    END AS screen_group,

    CASE
      WHEN HrsSleep_2324 = 1 THEN 'Enough sleep'
      WHEN HrsSleep_2324 = 2 THEN 'Not enough sleep'
      ELSE NULL
    END AS sleep_group,

    CASE
      WHEN PhysAct_2324 = 4 THEN 'High activity'
      WHEN PhysAct_2324 IN (2, 3) THEN 'Medium activity'
      WHEN PhysAct_2324 = 1 THEN 'Low activity'
      ELSE NULL
    END AS activity_group,

    CASE
      WHEN FoodSit_2324 IN (1, 2) THEN 'Food secure'
      WHEN FoodSit_2324 IN (3, 4) THEN 'Food insecure'
      ELSE NULL
    END AS food_group,

    CASE
      WHEN AdultEduc_2324 = 4 THEN 'High degree'
      WHEN AdultEduc_2324 = 3 THEN 'College'
      WHEN AdultEduc_2324 = 2 THEN 'School'
      WHEN AdultEduc_2324 = 1 THEN 'Poor education'
      ELSE NULL
    END AS education_group,

    CASE
      WHEN ACE2more_2324 = 1 THEN 'No ACE'
      WHEN ACE2more_2324 = 2 THEN 'One ACE'
      WHEN ACE2more_2324 = 3 THEN 'Two or more ACEs'
      ELSE NULL
    END AS ace_group

  FROM `project.dataset.nsch_clean`
)

SELECT
  screen_group,
  sleep_group,
  activity_group,
  food_group,
  education_group,
  ace_group,
  ROUND(SUM(fwc_2324),0) AS total_children,
  ROUND(
    SUM(CASE WHEN CSHCN_2324 = 1 THEN fwc_2324 ELSE 0 END)
    / SUM(fwc_2324),
    4
  ) AS cshcn_rate
FROM cohort_base
WHERE screen_group IS NOT NULL
  AND sleep_group IS NOT NULL
  AND activity_group IS NOT NULL
  AND food_group IS NOT NULL
  AND education_group IS NOT NULL
  AND ace_group IS NOT NULL
GROUP BY
  screen_group,
  sleep_group,
  activity_group,
  food_group,
  education_group,
  ace_group
HAVING total_children >= 50000
ORDER BY cshcn_rate DESC, total_children DESC;