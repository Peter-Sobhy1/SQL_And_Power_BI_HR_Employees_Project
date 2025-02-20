CREATE DATABASE Projects;
USE Projects;

SELECT * FROM [Human Resources]

--to ensure all the values has the same date format
UPDATE [Human Resources]
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN convert(date,birthdate,111)
    WHEN birthdate LIKE '%-%' THEN convert(date,birthdate,111)
    ELSE NULL
    END;

--changing the data type to date
ALTER TABLE [Human Resources]
ALTER COLUMN birthdate date;

--to ensure all the values has the same date format
UPDATE [Human Resources]
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN convert(date,hire_date,111)
    WHEN hire_date LIKE '%-%' THEN convert(date,hire_date,111)
    ELSE NULL
    END;

--changing the data type to date
ALTER TABLE [Human Resources]
ALTER COLUMN hire_date date;

UPDATE [Human Resources]
SET termdate = LEFT(termdate, 10)
FROM [Human Resources]
WHERE termdate IS NOT NULL;

--to ensure all the values has the same date format
UPDATE [Human Resources]
SET termdate = CASE
    WHEN termdate LIKE '%/%' THEN convert(date,termdate,111)
    WHEN termdate LIKE '%-%' THEN convert(date,termdate,111)
    ELSE NULL
    END;

--changing the data type to date
ALTER TABLE [Human Resources]
ALTER COLUMN termdate date;

--to determine the maximum length of the first name and change the data type to varchar(20)
SELECT MAX(LEN(convert(varchar(50),first_name)))
FROM [Human Resources]

--change the data type to varchar(20)
ALTER TABLE [Human Resources]
ALTER COLUMN FIRST_NAME VARCHAR(20);

--to determine the maximum length of the last name and change the data type to varchar(20)
SELECT MAX(LEN(convert(varchar(50),last_name)))
FROM [Human Resources]

--change the data type to varchar(30)
ALTER TABLE [Human Resources]
ALTER COLUMN last_name VARCHAR(30);

EXEC sp_rename '[Human Resources].id', 'emp_id', 'COLUMN';

ALTER TABLE [Human Resources]
ALTER COLUMN gender varCHAR(15);

ALTER TABLE [Human Resources]
ALTER COLUMN race varCHAR(50);

ALTER TABLE [Human Resources]
ALTER COLUMN department varCHAR(50);

ALTER TABLE [Human Resources]
ALTER COLUMN jobtitle varCHAR(50);

ALTER TABLE [Human Resources]
ALTER COLUMN location varCHAR(50);

ALTER TABLE [Human Resources]
ALTER COLUMN location_city varCHAR(50);

ALTER TABLE [Human Resources]
ALTER COLUMN location_state varCHAR(50);

ALTER TABLE [Human Resources]
ALTER COLUMN emp_id varCHAR(20);

UPDATE [Human Resources]
SET emp_id = STUFF(emp_id, 3, 1, '')

ALTER TABLE [Human Resources]
ALTER COLUMN emp_id int;

exec sp_rename 'dbo.human resources','hr'
