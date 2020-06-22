
SELECT emp_no, first_name, last_name, 
CASE
	WHEN gender = 'M' THEN 'Male'
    ELSE 'Female'
END AS gender
FROM employees;



-- Same thing with IF statement
SELECT emp_no, first_name, last_name, 
		IF(gender = 'M', 'Male', 'Female') AS gender
FROM
	employees;
    
    
-- Another use case of CASE

SET @salary_diff = 0;

SELECT
	dm.emp_no, e.first_name, e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_diff,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20000'
	END AS salary_increase
FROM
	dept_manager dm
    JOIN
    employees e ON e.emp_no = dm.emp_no
    JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;
    


