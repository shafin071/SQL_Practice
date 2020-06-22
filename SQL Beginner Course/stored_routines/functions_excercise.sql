USE employees;

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION emp_info;

DELIMITER $$

CREATE FUNCTION emp_info (emp_first_name VARCHAR(10), emp_last_name VARCHAR(10)) RETURNS INTEGER(10)
BEGIN
	DECLARE v_max_from_date DATE;
    DECLARE emp_number INTEGER(10);
    DECLARE emp_salary DECIMAL(10,2);
    
    SELECT emp_no INTO emp_number FROM employees WHERE first_name = emp_first_name AND last_name = emp_last_name;
    SELECT MAX(from_date) INTO v_max_from_date FROM salaries WHERE emp_no = emp_number GROUP BY emp_no;
    SELECT salary INTO emp_salary FROM salaries WHERE from_date = v_max_from_date AND emp_no = emp_number;
    RETURN emp_salary;
END $$

DELIMITER ;

SELECT emp_info('Aruna', 'Journel');


SET @emp_number = 0;
SET @emp_first_name = 'Aruna';
SET @emp_last_name = 'Journel';
SELECT emp_no INTO @emp_number FROM employees WHERE first_name = @emp_first_name AND last_name = @emp_last_name;
SELECT @emp_number;

SET @max_from_date = 0;
SELECT MAX(from_date) INTO @max_from_date FROM salaries WHERE emp_no = @emp_number;
SELECT @max_from_date;


SET @emp_salary = 0;
SELECT salary FROM salaries WHERE from_date = @max_from_date;

