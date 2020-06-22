
DROP PROCEDURE IF EXISTS v_emp_no;

-- @ means its a session variable
SET @employee_no = 0;

DELIMITER $$

CREATE PROCEDURE v_emp_no(IN first_name VARCHAR(40), IN last_name VARCHAR(40), OUT employee_no INTEGER)
BEGIN
	SELECT e.emp_no INTO employee_no FROM employees e WHERE e.first_name = first_name AND e.last_name = last_name;
END $$

DELIMITER ;


CALL v_emp_no('Aruna','Journel', @employee_no);
SELECT @employee_no;


SELECT emp_no, first_name, last_name FROM employees WHERE first_name = 'Aruna' AND last_name = 'Journel';