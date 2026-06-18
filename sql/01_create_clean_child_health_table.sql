-- BigQuery SQL
-- Note: Table names were anonymized for public portfolio use.
-- Raw data is not included in this repository.
CREATE OR REPLACE TABLE `project.dataset.nsch_clean` AS

SELECT
  age3_2324,
  sex_2324,

  -- Cleaned features
  IF(ScreenTime_2324 IN (90,95,99), NULL, ScreenTime_2324) AS ScreenTime_2324,
  IF(HrsSleep_2324 IN (90,95,99), NULL, HrsSleep_2324) AS HrsSleep_2324,
  IF(PhysAct_2324 IN (90,95,99), NULL, PhysAct_2324) AS PhysAct_2324,
  IF(MealTogether_2324 IN (90,95,99), NULL, MealTogether_2324) AS MealTogether_2324,
  IF(NbhdSafe_2324 IN (90,95,99), NULL, NbhdSafe_2324) AS NbhdSafe_2324,
  IF(FoodSit_2324 IN (90,95,99), NULL, FoodSit_2324) AS FoodSit_2324,
  IF(ACE2more_2324 IN (90,95,99), NULL, ACE2more_2324) AS ACE2more_2324,
  IF(WCRIdomains_2324 IN (90,95,99), NULL, WCRIdomains_2324) AS WCRIdomains_2324,
  IF(flrish6to17_2324 IN (90,95,99), NULL, flrish6to17_2324) AS flrish6to17_2324,
  IF(povlev4_2324 IN (90,95,99), NULL, povlev4_2324) AS povlev4_2324,
  IF(AdultEduc_2324 IN (90,95,99), NULL, AdultEduc_2324) AS AdultEduc_2324,

  fwc_2324,

  -- Target
  CSHCN_2324

FROM `project.dataset`

WHERE age3_2324 IN (2, 3);