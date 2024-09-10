SHOW DATABASES;
SELECT DATABASE();
create database myproject;

SELECT * FROM HR;

use myproject;

-- Have imported the csv table into SQL

SHOW TABLES;

DESC HR;

-- CLEANING OF THE DATA --

-- A Changing the name and properties of the column --

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(25) ;

SELECT * FROM HR;

-- CHANGING THE DATA TYPE OF VARIOUS OTHER COLUMNS --

ALTER TABLE hr
MODIFY first_name VARCHAR(50),
MODIFY last_name VARCHAR(50),
MODIFY gender VARCHAR(25),
MODIFY race VARCHAR(150),
MODIFY department VARCHAR(150),
MODIFY jobtitle VARCHAR(150),
MODIFY location VARCHAR(100),
MODIFY location_city VARCHAR(100),
MODIFY location_state VARCHAR(100)
;  

-- CORRECTING THE ALL DATE RELATED COLUMNS --

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE 
		WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
		WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
        ELSE NULL
        END;
        
UPDATE hr
SET hire_date = CASE 
		WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
		WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        ELSE NULL
        END;
        
ALTER TABLE hr
MODIFY birthdate DATE,
MODIFY hire_date DATE;

UPDATE hr
SET termdate = date_format(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'), '%Y-%m-%d')
WHERE termdate IS NOT NULL AND termdate != '';

UPDATE hr
SET termdate = NULL
WHERE termdate = '';

ALTER TABLE hr
MODIFY termdate DATE;

-- Done with cleaning and correcting all date related columns --

-- CREATE A NEW COLUMN FOR AGE OF EMPLOYEES --

ALTER TABLE hr
ADD COLUMN age INT ;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, curdate());

SELECT min(age), max(age) FROM hr;

-- ****** Encountered a problem where birthdate exceeded the current date, so to solve it did the following ***** ------
SELECT count(*) FROM HR
where year(birthdate) > year(curdate());


UPDATE hr
SET birthdate = DATE_ADD(birthdate, INTERVAL -100 YEAR)
WHERE YEAR(birthdate) > YEAR(CURDATE());

-- ******* Solved the problem ********* --

-- Ques1).  What is the gender breakdown of the PRESENT employees in the company --

SELECT gender, count(*) as total_count
FROM hr
WHERE termdate is NULL OR termdate > curdate()
GROUP BY gender;

-- Ques2). What is the race breakdown of PRESENT employees in the company --

SELECT race, count(*) as race_count
FROM hr
WHERE termdate IS NULL or termdate > curdate()
GROUP BY race;

-- Ques3). What is the age distribution of the PRESENT employees --

SELECT
	CASE
		WHEN age < 25 THEN '0-25'
        WHEN age BETWEEN 26 AND 40 THEN '26-40'
        WHEN age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
	END AS age_group,
    count(*) as age_count
FROM hr
WHERE termdate IS NULL OR termdate > curdate()
GROUP BY age_group
ORDER BY age_group;

-- Ques4).  How many employees work at HQ vs REMOTE? --

SELECT location, count(*) as count
FROM hr
WHERE termdate IS NULL OR termdate > curdate()
GROUP BY location;

-- Ques5). What is the average length of employment who have been terminated? --

SELECT ROUND(AVG(year(termdate) - year(hire_date))) AS avg_emp_len
FROM hr
WHERE termdate IS NOT NULL AND termdate <= curdate()
-- GROUP BY department --
-- ORDER BY department --
;

-- Ques6). How does the gender distribution vary across dept. and job titles --

SELECT department, jobtitle, gender, count(gender) as dept_gender_count
FROM hr
WHERE termdate IS NULL OR termdate > curdate()
GROUP BY gender, department, jobtitle
ORDER BY department, jobtitle, gender;

-- Ques7). What is the distribution of job titles across the company? --

SELECT department, jobtitle, count(jobtitle) as count_titles
FROM hr
WHERE termdate IS NULL OR termdate > curdate()
GROUP BY department, jobtitle
ORDER BY department, jobtitle;

-- Ques8). which dept. has the higher turnover/termination rate? --

SELECT department, 
	count(*) AS total_count,
    count(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 END) AS terminated_count,
    round((count(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 END)/count(*))*100,2) AS termination_rate
			
FROM hr
GROUP BY department
ORDER BY termination_rate DESC;

-- Ques9). What is the distribution of employees acrooss location_state --

SELECT location_state, count(*) AS location_count
FROM hr
WHERE termdate IS NULL OR termdate >curdate()
GROUP BY location_state
ORDER BY location_count DESC;

-- Ques10). How has company's employee count changed over each year based on hirings and terminations.

SELECT year(hire_date) AS YEAR, 
count(*) AS hires,
count(CASE WHEN termdate IS NOT NULL and termdate <= curdate() THEN 1 END) AS terminations,
count((CASE WHEN termdate IS NULL OR termdate IS NOT NULL THEN 1 END)- 
		(CASE WHEN termdate IS NOT NULL and termdate <= curdate() THEN 1 END)) AS netchange,
		round((count(CASE 
	WHEN termdate IS NOT NULL and termdate <= curdate() THEN 1 END)/
		count(CASE WHEN termdate IS NULL OR termdate IS NOT NULL THEN 1 END))*100,2) AS netchange_percentage
FROM hr
GROUP BY YEAR
ORDER BY YEAR
;

-- Another way to solve the same problem is as follows using subquery --

SELECT year, hires, terminations, hires-terminations AS netchnage, (terminations/hires)*100 AS netchangepercentage
-- all the above columns are new columns that will be extracted from a sub query --
FROM (
		SELECT YEAR(hire_date) AS year,
        count(*) AS hires,
        count(CASE WHEN termdate IS NOT NULL AND termdate<= curdate() THEN 1 END) AS terminations
        FROM hr
        GROUP BY year) AS subquery
GROUP BY year
ORDER BY year;

-- 11). What is the tenure distribution for each department.

Select department, round(Avg(datediff(termdate,hire_date)/365),0) As Avg_Tenure
From hr
WHERE termdate IS NOT NULL OR termdate <=curdate()
Group by department;
