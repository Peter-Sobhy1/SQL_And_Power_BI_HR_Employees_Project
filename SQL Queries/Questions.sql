-- QUESTIONS
USE Projects

-- 1. What is the gender breakdown of employees in the company?

SELECT gender, COUNT(gender) AS count
FROM hr
WHERE termdate IS NULL
GROUP by gender;


-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race, COUNT(race) AS count
from hr
WHERE termdate IS NULL
GROUP BY race
ORDER BY count DESC;

-- 3. What is the age distribution of employees in the company?

SELECT case WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 20 AND 29 THEN '20-29'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 30 AND 39 THEN '30-39'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 40 AND 49 THEN '40-49'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 50 AND 59 THEN '50-59'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 60 AND 69 THEN '60-69'
ELSE '70+' END AS age_group,gender, COUNT(*) AS count
from hr
WHERE termdate IS NULL
GROUP BY case WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 20 AND 29 THEN '20-29'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 30 AND 39 THEN '30-39'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 40 AND 49 THEN '40-49'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 50 AND 59 THEN '50-59'
WHEN DATEDIFF(YEAR,birthdate,getdate()) BETWEEN 60 AND 69 THEN '60-69'
ELSE '70+'END , gender
ORDER BY age_group;

-- 4. How many employees work at headquarters versus remote locations?

SELECT [location],COUNT([location]) as count
from hr
WHERE termdate IS NULL
group by [location];

-- 5. What is the average length of employment for employees who have been terminated?

SELECT AVG(DATEDIFF(YEAR,hire_date,termdate)) as avg_length_of_employment
from hr
WHERE termdate IS NOT NULL;

-- 6. How does the gender distribution vary across departments?
SELECT department, gender,COUNT(gender) as count FROM hr
WHERE termdate IS NULL
GROUP BY department, gender
ORDER BY department

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, COUNT(jobtitle) as count
from hr
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY count DESC;

-- 8. Which department has the highest turnover rate?

SELECT department, COUNT(termdate) as count
from hr
WHERE termdate IS NOT NULL
GROUP BY department
ORDER BY count DESC;

-- 9. What is the distribution of employees across locations by city and state?

SELECT location_city, location_state, COUNT(location_city) as count
from hr
WHERE termdate IS NULL
GROUP BY location_city, location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?

WITH sub as (SELECT YEAR(hire_date) as year,
COUNT(hire_date) as hires,
SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) as terminations
from hr
GROUP BY YEAR(hire_date))
SELECT 
   year,
   hires,
   terminations,
   hires - terminations as net_change
FROM sub
ORDER BY YEAR

-- 11. What is the tenure distribution for each department?

SELECT department, avg(DATEDIFF(YEAR,hire_date,termdate)) as tenure
from hr
GROUP BY department
ORDER BY department;

-- 12. what is total number of employees?
SELECT COUNT(emp_id) as total_employees
FROM hr
WHERE termdate IS NULL;

-- 13. what is total number of departments?
SELECT COUNT(DISTINCT department) as total_departments
FROM hr;

