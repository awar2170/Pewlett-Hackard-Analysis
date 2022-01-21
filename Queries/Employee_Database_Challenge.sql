-- Employee Database Challenge 
SELECT e.emp_no, e.first_name, e.last_name, 
ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e 
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no)
r.emp_no, r.first_name, r.last_name, r.title
INTO unique_titles
FROM retirement_titles as r
WHERE (r.to_date = '9999-01-01')
ORDER BY r.emp_no, r.to_date DESC;

SELECT * FROM unique_titles; 

-- Why is the to_date the last date we filter by? 
-- It's because the to_date is the date to which they kept working 
-- If it is greater than the current date, then the person is still 
-- working at the company.

-- Retrieve the number of employees by their most ecent job titles who are about to retire 
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;

-- **DELIVERABLE 2** 
-- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program 
SELECT DISTINCT ON (e.emp_no) 
e.emp_no, e.first_name, e.last_name, e.birth_date, 
de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees AS e 
INNER JOIN titles AS ti 
ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp AS de 
ON (e.emp_no = de.emp_no)
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31' 
ORDER BY e.emp_no; 

SELECT * FROM mentorship_eligibility;

