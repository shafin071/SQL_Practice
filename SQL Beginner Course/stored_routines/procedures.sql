USE employees;

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	select * from employees
    LIMIT 1000;
END$$

DELIMITER ;

CALL employees.select_employees();

CALL select_employees();




