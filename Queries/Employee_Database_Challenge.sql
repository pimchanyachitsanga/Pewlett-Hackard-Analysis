-- CHALLENGE

-- Deliverable #1 The Number of Retiring Employees by Title 
-- Use Dictinct with Orderby to remove duplicate rows

--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name
FROM employees

--Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date
FROM titles

--Create a new table using the INTO clause. Join both tables on the primary key. Filter data by birth date.
SELECT employees.emp_no,
     employees.first_name,
     employees.last_name,
     titles.title,
	 titles.from_date,
	 titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;

-- Check and export table, after reviewm there are duplicates as EE changed titles over time

SELECT emp_no, first_name, last_name, title
FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;
SELECT * FROM unique_titles;

-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.title),ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- Current employees who were born between January 1, 1965 and December 31, 1965.

SELECT emp_no, first_name, last_name, birth_date
FROM employees

SELECT from_date, to_date
FROM dept_emp

SELECT title
FROM titles

-- Join three tables together on primary key and create mentorship eligibilty table

SELECT DISTINCT ON (emp_no) ee.emp_no,
ee.first_name,
ee.last_name,
ee.birth_date,
de.from_date,
de.to_date,
tt.title
INTO mentorship_eligibility
FROM employees as ee
	INNER JOIN dept_emp as de
		ON (ee.emp_no = de.emp_no)
	INNER JOIN titles as tt
		ON (ee.emp_no = tt.emp_no)
	WHERE (de.to_date = '9999-01-01')
     	AND (ee.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT * FROM mentorship_eligibility
