-- Write 5 stored procedures for the employees database.
-- Write a description of what each stored procedure does and how to use it.

-- *****
-- #1
-- This procedure counts current employees by title.
-- WARNING: Some employees hold more than one title, thus the sum of these results will be more
-- than the number of total current employees.
-- *****
DROP PROCEDURE IF EXISTS employees.countCurrentEmployeesByTitle;
DELIMITER //
//
CREATE PROCEDURE employees.countCurrentEmployeesByTitle()
BEGIN
	SELECT title AS Title, COUNT(*) AS "Number of Employees"
		FROM employees_with_titles
		WHERE to_date > NOW()
		GROUP BY title;
END //
DELIMITER ;
CALL countCurrentEmployeesByTitle();

-- *****
-- #2
-- This procedure returns all the titles ever held by the given employee name.
-- *****
DROP PROCEDURE IF EXISTS employees.getAllTitlesOfEmployee;
DELIMITER //
//
CREATE PROCEDURE employees.getAllTitlesOfEmployee(
	IN employeeFirstName VARCHAR(60),
	IN employeeLastName VARCHAR(60)
)
BEGIN
	SELECT title
	FROM employees_with_titles
	WHERE first_name = employeefirstname
		AND last_name = employeeLastName;
END //
DELIMITER ;
CALL getAllTitlesOfEmployee("Kyoichi", "Maliniak");

-- *****
-- #3
-- This procedure returns all the CURRENT titles held by the given employee name.
-- *****
DROP PROCEDURE IF EXISTS employees.getCurrentTitlesOfEmployee;
DELIMITER //
//
CREATE PROCEDURE employees.getCurrentTitlesOfEmployee(
	IN employeeFirstName VARCHAR(60),
	IN employeeLastName VARCHAR(60)
)
BEGIN
	SELECT title
	FROM employees_with_titles
	WHERE first_name = employeefirstname
		AND last_name = employeeLastName
		AND to_date > NOW();
END //
DELIMITER ;
CALL getCurrentTitlesOfEmployee("Kyoichi", "Maliniak");

-- *****
-- #4
-- This procedure returns the current salary of the given employee name.
-- *****
DROP PROCEDURE IF EXISTS employees.getEmployeeCurrentSalary;
DELIMITER //
//
CREATE PROCEDURE employees.getEmployeeCurrentSalary(
	IN employeeFirstName VARCHAR(60),
	IN employeeLastName VARCHAR(60)
)
BEGIN
	SELECT salary
	FROM employees_with_salary
	WHERE first_name = employeeFirstName 
		AND last_name = employeeLastName 
		AND to_date > NOW();
END //
DELIMITER ;
CALL getEmployeeCurrentSalary("Georgi", "Facello");

-- *****
-- #5
-- This procedure returns all employees with a salary greater than the given
-- minimum salary.
-- WARNING: This returns all employees, current and past.
-- *****
DROP PROCEDURE IF EXISTS employees.getEmployeesWithSalaryGreaterThan;
DELIMITER //
//
CREATE PROCEDURE employees.getEmployeesWithSalaryGreaterThan(
	IN minimumSalary int(8)
)
BEGIN
	SELECT emp_no, first_name, last_name, salary
	FROM employees_with_salary
	WHERE salary > minimumSalary;
END //
DELIMITER ;
CALL getEmployeesWithSalaryGreaterThan(150000);



-- Procedures should use constructs you learned about from your research assignment and be more than just queries.
DROP VIEW IF EXISTS employees.employees_with_titles;
CREATE VIEW employees_with_titles AS
	SELECT employees.emp_no, first_name, last_name, gender, hire_date, title, titles.from_date, titles.to_date
	FROM employees
	INNER JOIN titles
	ON employees.emp_no = titles.emp_no;
	
DROP VIEW IF EXISTS employees.employees_with_salary;
CREATE VIEW employees_with_salary AS
	SELECT employees.emp_no, employees.first_name, employees.last_name, salaries.salary, salaries.from_date, salaries.to_date
	FROM employees
	INNER JOIN salaries
	ON employees.emp_no = salaries.emp_no;