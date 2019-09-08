# 1. I want to know how many employees with each title were born after 1965-01-01.
SELECT titles.title as Title,COUNT(*) as count 
    FROM employees
    inner join titles
    on employees.emp_no = titles.emp_no
    where birth_date > "1965-01-01"
    GROUP BY titles.title 
    ORDER BY count DESC;
    
    
show tables;
desc employees;
desc titles;
# 2. I want to know the average salary per title.
# 3. How much money was spent on salary for the marketing department between the years 1990 and 1992?
