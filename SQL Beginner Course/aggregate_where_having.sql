SELECT 
    COUNT(emp_no)
FROM
    employees;


SELECT 
    COUNT(first_name)
FROM
    employees;
    
    
SELECT 
    COUNT(DISTINCT first_name)
FROM
    employees;


SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
;


SELECT 
    *
FROM
    employees
ORDER BY first_name, last_name ASC
;


SELECT 
    first_name, 
    COUNT(first_name) AS first_name_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name DESC
;


SELECT 
    first_name, 
    COUNT(first_name) AS first_name_count
FROM
    employees
GROUP BY first_name
HAVING
	COUNT(first_name) > 250
ORDER BY first_name DESC
;


SELECT
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;


SELECT
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;


SELECT
	first_name, 
    COUNT(first_name) AS first_name_count
from
	employees
WHERE
	hire_date > '1999-01-01'
GROUP BY
	first_name
HAVING
	count(first_name) < 100
ORDER BY first_name_count DESC
;


SELECT
	*
FROM
	dept_emp
;



SELECT
	emp_no
from
	dept_emp
WHERE
	from_date > '2000-01-01'
GROUP BY
	emp_no
HAVING
	count(from_date) > 1
ORDER BY emp_no
;


SELECT
	emp_no, from_date
from
	dept_emp
WHERE
	emp_no = '11609'
    ;
    


SELECT
	emp_no, salary
from
	salaries
GROUP BY
	emp_no
ORDER BY
	salary DESC
    ;


SELECT
	emp_no, salary
from
	salaries
WHERE
	emp_no = 43624





    
    
    