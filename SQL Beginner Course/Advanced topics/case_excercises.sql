-- NOTE for excercise 1: The employee ID will show up twice in the result table because he/she has been managers for multiple departments

-- Excercise 1: Solution 1
SELECT 
	e.emp_no, e.first_name, e.last_name,
    CASE
		WHEN e.emp_no = dm.emp_no THEN 'Manager'
        ELSE 'Regular employee'
	END AS designation
FROM employees e
	 LEFT JOIN
     dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990
;



-- Excercise 1: Solution 2
SELECT e.emp_no, e.first_name, e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
    


-- Excercise 2

SELECT
	e.emp_no, e.first_name, e.last_name, e.hire_date, MAX(s.to_date),
    CASE
		WHEN MAX(s.to_date) > date_format(sysdate(), '%Y-%m-%d') THEN 'is still employed'
        ELSE 'Not an employee anymore'
	END AS current_employee
FROM 
	employees e
    JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no
ORDER BY e.emp_no
LIMIT 100;



-- Excercise solution
SELECT
    e.emp_no, e.first_name, e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
ORDER BY de.emp_no
LIMIT 100;

