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