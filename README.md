# Instruction
📊 Dive into the HR analytics world! This project explores employee data to uncover insights into workforce demographics, turnover rates, and departmental trends. By analyzing key metrics, we aim to provide actionable insights for HR decision-making.

# Background
 Driven by the need to understand workforce dynamics, this project was born from a desire to analyze employee data, including gender breakdowns, age distributions, turnover rates, and departmental trends. The goal is to provide HR teams with data-driven insights to improve employee retention and optimize workforce planning.

## The questions I wanted to answer through my SQL queries were:
1. What is the gender breakdown of employees in the company?

2. What is the race/ethnicity breakdown of employees?

3. What is the age distribution of employees?

4. How many employees work at headquarters versus remote locations?

5. What is the average length of employment for terminated employees?

6. How does the gender distribution vary across departments?

7. What is the distribution of job titles across the company?

8. Which department has the highest turnover rate?

9. What is the distribution of employees across locations by city and state?

10. How has the company's employee count changed over time based on hire and term dates?

11. What is the tenure distribution for each department?

12. What is the total number of employees and departments?

# Tools I Used

For this HR analytics project, I leveraged the following tools:

**SQL:** The backbone of my analysis, allowing me to query the database and extract critical insights.

**SQL Server:** The chosen database management system for storing and managing employee data.

**Visual Studio Code:** My go-to tool for writing and executing SQL queries.

**Power BI:** Used to create visualizations and reports by connecting directly to the SQL Server database using import mode.

**Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis.

# The Analysis

Each query for this project aimed at investigating specific aspects of the HR data. Here’s how I approached each question:

### 1. Gender Breakdown of Employees
This query provides the gender distribution of employees in the company.
```sql 
SELECT gender, COUNT(gender) AS count
FROM hr
WHERE termdate IS NULL
GROUP BY gender;
```


Insights:

The company has a balanced gender distribution, with slightly more male employees than female employees.

### 2. Race/Ethnicity Breakdown of Employees
This query shows the racial and ethnic diversity within the company.
```sql
SELECT race, COUNT(race) AS count
FROM hr
WHERE termdate IS NULL
GROUP BY race
ORDER BY count DESC; 
```
Insights:

The majority of employees identify as White, followed by Black or African American and Asian.

### 3. Age Distribution of Employees
This query categorizes employees into age groups and provides a breakdown by gender.

```sql
SELECT
    CASE
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 20 AND 29 THEN '20-29'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 30 AND 39 THEN '30-39'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 40 AND 49 THEN '40-49'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 50 AND 59 THEN '50-59'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 60 AND 69 THEN '60-69'
        ELSE '70+' END AS age_group, gender, COUNT(*) AS count
FROM hr
WHERE termdate IS NULL
GROUP BY
    CASE
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 20 AND 29 THEN '20-29'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 30 AND 39 THEN '30-39'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 40 AND 49 THEN '40-49'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 50 AND 59 THEN '50-59'
        WHEN DATEDIFF(YEAR, birthdate, GETDATE()) BETWEEN 60 AND 69 THEN '60-69'
        ELSE '70+' END, gender
            
ORDER BY age_group;
```
Insights:

The largest age group is 30-39, followed by 40-49. The workforce is relatively young, with fewer employees aged 60 and above.

### 4. Headquarters vs Remote Employees
This query shows the distribution of employees working at headquarters versus remote locations.
```sql
SELECT [location], COUNT([location]) AS count
FROM hr
WHERE termdate IS NULL
GROUP BY [location];
```
Insights:

A significant portion of employees work remotely, indicating a shift towards flexible work arrangements.

### 5. Average Length of Employment for Terminated Employees
This query calculates the average tenure of employees who have left the company.

```sql
SELECT AVG(DATEDIFF(YEAR, hire_date, termdate)) AS avg_length_of_employment
FROM hr
WHERE termdate IS NOT NULL;
```
Insights:

The average length of employment for terminated employees is approximately 7 years.

### 6. Gender Distribution Across Departments
This query provides a breakdown of gender distribution by department.

```sql
SELECT department, gender, COUNT(gender) AS count
FROM hr
WHERE termdate IS NULL
GROUP BY department, gender
ORDER BY department;
```
Insights:

Engineering and Accounting have the highest number of employees, with a balanced gender distribution across most departments.

### 7. Distribution of Job Titles
This query shows the distribution of job titles across the company.

```sql
SELECT jobtitle, COUNT(jobtitle) AS count
FROM hr
WHERE termdate IS NULL GROUP BY jobtitle
ORDER BY count DESC;
```
Insights:

The most common job titles are Data Analyst, Software Engineer, and Accountant.

### 8. Department with the Highest Turnover Rate

This query identifies the department with the highest number of terminations.
```sql
SELECT department, COUNT(termdate) AS count
FROM hr
WHERE termdate IS NOT NULL
GROUP BY department
ORDER BY count DESC;
```
Insights:

Engineering has the highest turnover rate, followed by Accounting and Sales.

### 9. Employee Distribution by Location
This query shows the distribution of employees across cities and states.
```sql
SELECT location_city, location_state, COUNT(location_city) AS count
FROM hr
WHERE termdate IS NULL
GROUP BY location_city, location_state
ORDER BY count DESC;
```
Insights:

The majority of employees are located in major cities like New York, Chicago, and Los Angeles.

### 10. Change in Employee Count Over Time
This query tracks the net change in employee count over time based on hire and termination dates.

```sql
WITH sub 
AS 
( SELECT
 YEAR(hire_date) AS year, COUNT(hire_date) AS hires, SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminations
FROM hr
GROUP BY YEAR(hire_date) )
SELECT year, hires, terminations, hires - terminations AS net_change 
FROM sub 
ORDER BY year;
```
Insights:

The company has experienced steady growth, with a positive net change in employee count each year.

### 11. Tenure Distribution by Department

This query calculates the average tenure of employees by department.
```sql
SELECT
department, AVG(DATEDIFF(YEAR, hire_date, termdate)) AS tenure
FROM hr
GROUP BY department
ORDER BY department;
```

Insights:

Employees in the Legal and Auditing departments have the longest average tenure.

### 12. Total Number of Employees
This query provides the total number of active employees
```sql
SELECT COUNT(emp_id) AS 'Total Employees'
FROM hr
WHERE termdate IS NULL;
```
| Total Employees |
|---|
| 18285 |


### 13. Total number of departments
```sql
SELECT COUNT(DISTINCT department) AS 'Total Departments'
FROM hr;
```
| Total Departments  |
|---|
| 13 |


# What I Learned

 Throughout this project, I enhanced my SQL and data analysis and Power BI skills :

- 🧩 Complex Query Crafting: Mastered advanced SQL techniques, including CASE statements, WITH clauses, and aggregate functions.

- 📊 Data Cleaning: Learned how to standardize date formats, handle null values, and modify column data types.

- 💡 Analytical Thinking: Developed the ability to translate business questions into actionable SQL queries.

- 📈 Visualization: Used Power BI to create interactive dashboards and reports, connecting directly to the SQL Server database.

# Conclusions

Insights From the analysis, several key insights emerged:

1. Gender Diversity: The company has a balanced gender distribution, with slightly more male employees.

2. Age Distribution: The workforce is relatively young, with the majority of employees aged 30-49.

3. Remote Work: A significant portion of employees work remotely, reflecting a shift towards flexible work arrangements.

4. Turnover Rates: Engineering has the highest turnover rate, indicating a need for targeted retention strategies.

5. Employee Growth: The company has experienced steady growth, with a positive net change in employee count each year.

## Closing Thoughts

This project provided valuable insights into the company's workforce dynamics. By leveraging SQL and Power BI, I was able to uncover trends and patterns that can inform HR strategies, such as improving retention and optimizing workforce planning. This exploration highlights the importance of data-driven decision-making in HR management.