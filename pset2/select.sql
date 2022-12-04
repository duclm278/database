-- 1
SELECT first_name "First Name", last_name "Last Name"
FROM employees;

-- 2
SELECT DISTINCT department_id
FROM employees;

-- 3
SELECT *
FROM employees
WHERE DATE_PART('year', hire_date) > 2022;

-- 4
SELECT CONCAT(first_name, ' ', last_name) name, salary, 0.15 * salary "PF"
FROM employees;

-- 5
SELECT CONCAT(first_name, ' ', last_name) name, salary, 0.15 * salary "PF"
FROM employees
WHERE salary > 1000 / 0.15;

-- 6
EXPLAIN
SELECT * FROM employees
JOIN departments ON departments.department_id = employees.department_id;

EXPLAIN
SELECT * FROM employees, departments
WHERE departments.department_id = employees.department_id;

-- 7
SELECT 171 * 214 + 625;

-- 8
SELECT CONCAT(first_name, ' ', last_name) name
FROM employees;

-- 9
SELECT TRIM (
	BOTH ' ' FROM CONCAT(' ', first_name, ' ', last_name, ' ')
) FROM employees;

-- 10
SELECT * FROM employees
LIMIT 10;

-- 11
SELECT CONCAT(first_name, ' ', last_name) name, ROUND(salary / 12, 2) monthly_salary
FROM employees;

-- 12
SELECT CONCAT(first_name, ' ', last_name) name, ROUND(salary / 12, 2) monthly_salary
FROM employees
WHERE salary < 5000 * 12;
