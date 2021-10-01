-- Employee Challenge part 1
-- #1 Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name 
FROM employees

-- #2 Retrieve the title, from_date, and to_date columns from the Titles table
SELECT title, from_date, to_date 
FROM titles

--#5 Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
SELECT emp_no, first_name, last_name 
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no

-- #4 Join the two tables, #3 create new table
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirment_titles
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no

-- #9 Retrieve the employee number, first and last name, and title columns from the Retirement Titles table
SELECT emp_no, first_name, last_name, title
FROM retirment_titles

SELECT * FROM retirment_titles
ORDER BY emp_no, to_date DESC

-- #10 Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (emp_no)emp_no, first_name, last_name, title
INTO unique_titles
FROM retirment_titles 
ORDER BY emp_no, to_date DESC

-- #15-20 Retrieve the # of employees per title that are about to retire 
SELECT title, count(emp_no)
INTO retiring_titles_count
FROM unique_titles 
GROUP BY title 
ORDER BY count(emp_no) DESC;

-- Challenge Del Part 2 
-- #1 Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
SELECT emp_no, first_name, last_name, birth_date 
FROM employees 
-- #2 Retrieve the from_date and to_date columns from the Department Employee table.
SELECT emp_no, from_date, to_date 
FROM dept_emp
-- #3 Retrieve the title column from the Titles table.
SELECT emp_no, title
FROM titles
-- #4 Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
SELECT DISTINCT ON (emp_no) emp_no, from_date, to_date 
FROM dept_emp
ORDER BY emp_no, to_date DESC; 

SELECT DISTINCT ON (emp_no) emp_no, title
FROM titles
ORDER BY emp_no, to_date DESC;

-- #6 Join the Employees and the Department Employee tables on the primary key.
SELECT DISTINCT ON (de.emp_no) de.emp_no, de.from_date, de.to_date, e.first_name, e.last_name, e.birth_date 
FROM dept_emp as de
JOIN employees as e 
ON de.emp_no = e.emp_no
ORDER BY de.emp_no, de.to_date DESC; 

-- #7 Join the Employees and the Titles tables on the primary key
SELECT DISTINCT ON (t.emp_no) t.emp_no, t.title, e.first_name, e.last_name, e.birth_date
FROM titles as t
JOIN employees as e 
ON t.emp_no = e.emp_no
ORDER BY t.emp_no, t.to_date DESC;

-- # 8-11 steps JOIN all three, order by and distinct 
SELECT DISTINCT ON (de.emp_no) de.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentor_eligibility
FROM employees as e
JOIN dept_emp as de
ON de.emp_no = e.emp_no
JOIN titles as t 
ON t.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = '9999-01-01'
ORDER BY de.emp_no, de.to_date DESC, t.to_date DESC;



