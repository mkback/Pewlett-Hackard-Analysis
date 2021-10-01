-- Creating tables for PH-EmployeesDB
CREATE TABLE departments (dept_no VARCHAR(4) NOT NULL, 
						 dept_name VARCHAR(40) NOT NULL, 
						 PRIMARY KEY (dept_no), 
						 UNIQUE (dept_name));
CREATE TABLE employees (emp_no INT NOT NULL, 
					   birth_date DATE NOT NULL, 
					   first_name VARCHAR NOT NULL, 
					   last_name VARCHAR NOT NULL, 
					   gender VARCHAR NOT NULL, 
					   hire_date DATE NOT NULL, 
						PRIMARY KEY (emp_no)); 
CREATE TABLE dept_manager (dept_no VARCHAR NOT NULL, 
						  emp_no INT NOT NULL, 
						  from_date DATE NOT NULL, 
						  to_date DATE NOT NULL, 
						  FOREIGN KEY (emp_no) REFERENCES employees (emp_no), 
						  FOREIGN KEY (dept_no) REFERENCES departments (dept_no), 
						  PRIMARY KEY (emp_no, dept_no));
CREATE TABLE salaries (emp_no INT NOT NULL,
					   salary INT NOT NULL,
					   from_date DATE NOT NULL,
					   to_date DATE NOT NULL,
					   FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
					   PRIMARY KEY (emp_no));  
CREATE TABLE titles (emp_no INT NOT NULL, 
					title VARCHAR NOT NULL, 
					from_date DATE NOT NULL, 
					to_date DATE NOT NULL, 
					CONSTRAINT "pk_Titles" PRIMARY KEY (emp_no, title, from_date),
					CONSTRAINT fk_emp_no FOREIGN KEY(emp_no) REFERENCES employees(emp_no));
CREATE TABLE dept_emp (emp_no INT NOT NULL, 
					  dept_no VARCHAR NOT NULL, 
					  from_date DATE NOT NULL, 
					  to_date DATE NOT NULL, 
					  FOREIGN KEY (emp_no) REFERENCES employees (emp_no), 
					   FOREIGN KEY (dept_no) REFERENCES departments (dept_no), 
					  PRIMARY KEY (emp_no, dept_no));
-- Select statement to pull from data
SELECT * FROM dept_emp ; 
-- pull infoto detemine retimenent eligabel (section 7.3.1)
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
-- Retirment elilgible part 2 - notice the different syntax because multuple statementds 
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Count ^^
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- now create a new table with these guys 
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- select new infor 
SELECT * FROM retirement_info
DROP TABLE retirement_info;
-- Creating a new retirment table with ID so we can join (Section 7.3.2)
SELECT emp_no, first_name, last_name 
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;
DROP TABLE retirement_info; 
-- Create a new table 
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;
-- Join dept & dept_managers 
SELECT d.dept_name, dm.emp_no, dm.from_date, dm.to_date
FROM departments as d 
INNER JOIN dept_manager as dm 
ON d.dept_no = dm.dept_no
-- Join retirment info & dept_emp tables 
SELECT ri.emp_no, ri.first_name, ri.last_name, de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
on ri.emp_no = de.emp_no
WHERE de.to_date= ('9999-01-01');
-- Employee count by dept number 
SELECT COUNT(ce.emp_no), de.dept_no
INTO retirement_count_bydept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
-- #1 Employee info 
SELECT emp_no, first_name, last_name, gender 
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE emp_info
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de 
ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');
-- #2 Management list that are retiring 
SELECT dm.dept_no, d.dept_name, dm.emp_no, ce.first_name, ce.last_name, dm.from_date, dm.to_date
INTO manager_info
FROM dept_manager as dm 
INNER JOIN departments as d
on dm.dept_no = d.dept_no
INNER JOIN current_emp as ce
ON dm.emp_no = ce.emp_no
-- #3 Dept retirees 
SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON ce.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no; 

SELECT * from dept_info
WHERE dept_name = 'Sales' OR dept_name = 'Development'
	   