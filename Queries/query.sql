-- This page is used for more query analysis 

-- Total number of employees on record: 300,024
SELECT COUNT(emp_no)
FROM employees;

-- Total amount of titles: 443,308
SELECT COUNT(emp_no)
FROM titles; 

-- But emplyees may have had multiple titles, count distinct emp_no and we are back to 300,024 
SELECT COUNT(DISTINCT emp_no)
FROM titles; 

-- Show each employees last title & to date employed (2 ways)
SELECT DISTINCT ON (emp_no)emp_no, title, to_date 
FROM titles 
ORDER BY emp_no, to_date DESC;

SELECT emp_no, title, to_date
FROM (SELECT emp_no, title, to_date, ROW_NUMBER() over (PARTITION BY emp_no ORDER BY to_date DESC)
	  FROM titles
	  ORDER BY emp_no ASC, to_date DESC) as X
WHERE row_number = 1; 

-- How many employees are no longer employed? 59,900
SELECT COUNT(emp_no) as "No Longer Employees Count"
FROM (SELECT emp_no, title, to_date 
		FROM (SELECT emp_no, title, to_date, ROW_NUMBER() over (PARTITION BY emp_no ORDER BY to_date DESC)
	  			FROM titles
	  			ORDER BY emp_no ASC, to_date DESC) as X
		WHERE row_number = 1) as Y
WHERE Y.to_date != '9999-01-01'; 

-- How many employees are currently employed? 240,124
SELECT COUNT(emp_no) as "Current Employee Count"
FROM titles 
WHERE to_date = '9999-01-01'; 

