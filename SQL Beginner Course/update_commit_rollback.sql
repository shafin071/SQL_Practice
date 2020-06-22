USE employees;

SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC;


UPDATE employees
SET
	first_name = 'Stella',
    last_name = 'Parkinson',
    birth_date = '1990-12-31',
    gender = 'F'
WHERE
	emp_no = 999901;



SELECT
	*
FROM
	department_dup
ORDER BY dept_no;

SET autocommit = 0;

COMMIT;

UPDATE department_dup
SET
	dept_no = 'd011',
    dept_name = 'Quality Control'
    ;

ROLLBACK;



COMMIT;

SELECT * from department_dup;

