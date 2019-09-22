# 1. I want to know how many employees with each title were born after 1965-01-01.
SELECT titles.title as Title,COUNT(*) as count 
    FROM employees
    inner join titles
    on employees.emp_no = titles.emp_no
    where birth_date > "1965-01-01"
    GROUP BY titles.title 
    ORDER BY count DESC;
    
# 2. I want to know the average salary per title.
SELECT title AS Title, avg(salary) AS "Average Salary"
	FROM salaries
	INNER JOIN titles
	ON salaries.emp_no = titles.emp_no
	GROUP BY title;

# 3. How much money was spent on salary for the marketing department between the years 1990 and 1992?
SELECT dept_name, sum(salary) AS Total
	FROM salaries 
	INNER JOIN dept_emp
	ON salaries.emp_no = dept_emp.emp_no
		INNER JOIN departments 
		ON dept_emp.dept_no = departments.dept_no 
	WHERE departments.dept_name = "Marketing"
		AND (YEAR(salaries.from_date) BETWEEN "1990" AND "1992"
		OR YEAR(salaries.to_date) BETWEEN "1990" AND "1992")
	GROUP BY dept_emp.dept_no;
