USE employees_mod;

DROP PROCEDURE IF EXISTS emp_avg_salary;

DELIMITER $$

CREATE PROCEDURE filter_salary (IN begin_salary FLOAT, IN end_salary FLOAT)
BEGIN
	SELECT
		e.gender, d.dept_name, ROUND(AVG(s.salary), 2) as avg_salary
	FROM
		t_employees e 
		JOIN
		t_dept_emp de
		ON e.emp_no = de.emp_no
		JOIN
		t_salaries s
		ON e.emp_no = s.emp_no
		JOIN
		t_departments d
		ON de.dept_no = d.dept_no
	WHERE s.salary BETWEEN begin_salary AND end_salary
	GROUP BY d.dept_name, e.gender
	;
END $$

DELIMITER ;


CALL filter_salary(50000, 90000);

