SELECT * FROM `hr data`.hr_employees;

# 1 Average Attrition Rate for All Departments
SELECT 
    Department,
    CONCAT(ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2), '%') AS attrition_yes,
    CONCAT(ROUND(AVG(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) * 100, 2), '%') AS attrition_no
From `hr data`.hr_employees
group by Department with rollup;

# 2 Average Hourly Rate of Male Research Scientists
select
    AVG(HourlyRate) AS avg_hourly_rate
From `hr data`.hr_employees
Where Gender = 'Male' and JobRole = 'Research Scientist';

# 3 Attrition Rate vs Monthly Income Stats
SELECT 
  income_range,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Yes,
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS No,
  CONCAT(
    ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2),
    '%'
  ) AS attrition_rate_percent
FROM (
  SELECT *,
    CASE
      WHEN MonthlyIncome < 20000 THEN '< ₹20K'
      WHEN MonthlyIncome BETWEEN 20000 AND 50000 THEN '₹20K - ₹50K'
      ELSE '> ₹50K'
    END AS income_range
  FROM hr_employees
) AS income_grouped
GROUP BY  income_range with rollup  
ORDER BY 
  CASE 
    WHEN income_range = '< ₹20K' THEN 1
    WHEN income_range = '₹20K - ₹50K' THEN 2
    ELSE 3
  END;

# 4 Average Working Years for Each Department
SELECT Department,
       AVG(TotalWorkingYears) AS Avg_Working_Years
FROM `hr data`.hr_employees
GROUP BY Department;

# 5 Job Role vs Work Life Balance
SELECT JobRole,
       AVG(WorkLifeBalance) AS Avg_Work_Life_Balance
FROM `hr data`.hr_employees
GROUP BY JobRole;

# 6 Attrition Rat`hr data`e vs Years Since Last Promotion
 SELECT 
    YearsSinceLastPromotion,
    AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_rate
from `hr data`.hr_employees
group by YearsSinceLastPromotion
order by YearsSinceLastPromotion;

# 7 Attrition vs Overtime
SELECT OverTime,
       AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Rate
FROM `hr data`.hr_employees
GROUP BY OverTime;

# 8 Attrition vs Percentage Salary Hike
SELECT 
    Attrition,
    COUNT(*) AS total_employees,
    ROUND(AVG(PercentSalaryHike), 2) AS avg_salary_hike
FROM `hr data`.hr_employees
group by Attrition;
