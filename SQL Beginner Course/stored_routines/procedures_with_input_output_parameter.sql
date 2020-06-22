
DROP PROCEDURE IF EXISTS f_emp_avg_salary;

SET @employee_avg_salary = 0;

DELIMITER $$

CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN
	SELECT
		AVG(s.salary) INTO p_avg_salary
	FROM employees e
		 JOIN
		 salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END$$

DELIMITER ;

CALL emp_avg_salary_out(11300, @employee_avg_salary);