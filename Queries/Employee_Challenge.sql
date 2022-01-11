-- Retrieve employee info from Employees table & Titles table 
SELECT emp_no, first_name, last_name
FROM employees;

SELECT title, from_date, to_date
FROM titles; 

-- Pull employee info into new table for those retiring 
SELECT e.emp_no, e.first_name, e.last_name, t.title
INTO retirement_titles 
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	 AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no; 

-- Retrieve a list of all the employees retiring 
SELECT * 
FROM retirement_titles 
ORDER BY emp_no; 

-- Show the count employees retiring by title 
SELECT title, COUNT(emp_no) as "Count of Retiring Employees"
FROM retirement_titles  
GROUP BY title
UNION ALL 
SELECT 'Total' emp_no, COUNT(1)
FROM retirement_titles; 

-- Make the above ^ into a table without the total 
SELECT title, COUNT(emp_no) as "Count of Retiring Employees"
INTO retiring_titles_count
FROM retirement_titles  
GROUP BY title
ORDER BY "Count of Retiring Employees" DESC; 

SELECT * FROM retiring_titles_count

-- Now that we have info on retirees, let's look at possible mentees to replace them. 
 
-- Retrieve which dept each employee is currently in 
SELECT emp_no, dept_no
FROM dept_emp
WHERE to_date = '9999-01-01'; 

-- Join this info with Employee info
SELECT de.emp_no, de.dept_no, e.first_name, e.last_name, e.birth_date
FROM dept_emp as de
JOIN employees as e 
ON de.emp_no = e.emp_no 
WHERE de.to_date = '9999-01-01'; 

-- Join Employee and Titles info 
SELECT DISTINCT ON (t.emp_no)t.emp_no, t.title, e.first_name, e.last_name, e.birth_date
FROM titles as t
JOIN employees as e 
ON t.emp_no = e.emp_no
WHERE t.to_date = '9999-01-01'
ORDER BY t.emp_no;

-- Now Join all & only include employees eligible for mentorship (for this example those born in 1965)
SELECT DISTINCT ON (de.emp_no) de.emp_no, e.first_name, e.last_name, e.birth_date, t.title, de.dept_no
INTO mentor_eligibility_1965
FROM employees as e 
JOIN dept_emp as de 
ON de.emp_no = e.emp_no 
JOIN titles as t
ON t.emp_no = e.emp_no
WHERE (t.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY de.emp_no;

SELECT title, COUNT(emp_no)
FROM mentor_eligibility_1965
GROUP BY title
UNION ALL 
SELECT 'Total' emp_no, COUNT(1)
FROM mentor_eligibility_1965;

-- What about others in that age range? expand the range to 1963-1967
SELECT DISTINCT ON (de.emp_no) de.emp_no, e.first_name, e.last_name, e.birth_date, t.title, de.dept_no
INTO mentor_eligibility_1960s
FROM employees as e 
JOIN dept_emp as de 
ON de.emp_no = e.emp_no 
JOIN titles as t
ON t.emp_no = e.emp_no
WHERE (t.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1963-01-01' AND '1967-12-31')
ORDER BY de.emp_no;

SELECT title, COUNT(emp_no)
FROM mentor_eligibility_1960s
GROUP BY title
UNION ALL 
SELECT 'Total' emp_no, COUNT(1)
FROM mentor_eligibility_1960s;