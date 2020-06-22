
SET autocommit = 0; 
COMMIT;

DROP TRIGGER before_hire_date_insert;

DELIMITER $$

-- BEFORE is for insert
CREATE TRIGGER before_hire_date_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d')
    THEN SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');
    END IF;
END $$

DELIMITER ;

INSERT INTO employees VALUES ('10000', '1988-12-14', 'Shafin', 'Mohammed', 'M', '2022-06-22');

DELETE FROM employees WHERE emp_no = 10000;

SELECT * FROM employees;

