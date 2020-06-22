SELECT emp_no FROM dept_manager WHERE emp_no = 110022;

SELECT * FROM dept_emp ORDER BY dept_no;

SELECT * FROM dept_emp WHERE emp_no = 10016;

SELECT * FROM dept_emp WHERE emp_no BETWEEN 10021 AND 10040;

SELECT MIN(dept_no) FROM dept_emp;




SELECT A.*
FROM
	(SELECT 
	e.emp_no AS employee_ID,
	de.dept_no AS department_code,
	(SELECT emp_no FROM dept_manager WHERE emp_no = 110022) AS manager_ID
	FROM
		employees e
		JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
	WHERE
		e.emp_no <= 10020
	GROUP BY e.emp_no
	ORDER BY e.emp_no) as A
    UNION SELECT B.*
    FROM
		(SELECT 
		e.emp_no AS employee_ID,
		de.dept_no AS department_code,
		(SELECT emp_no FROM dept_manager WHERE emp_no = 110039) AS manager_ID
		FROM
			employees e
			JOIN
			dept_emp de
			ON e.emp_no = de.emp_no
		WHERE
			e.emp_no BETWEEN 10021 AND 10040
		GROUP BY e.emp_no
		ORDER BY e.emp_no) AS B
    ;
    
    
    -- Test
    
    SELECT 
	e.emp_no AS employee_ID,
	de.dept_no AS department_code,
	(SELECT emp_no FROM dept_manager WHERE emp_no = 110022) AS manager_ID
	FROM
		employees e
		JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
	WHERE
		e.emp_no <= 10020
	GROUP BY e.emp_no
	ORDER BY e.emp_no
    ;
    
    
    




