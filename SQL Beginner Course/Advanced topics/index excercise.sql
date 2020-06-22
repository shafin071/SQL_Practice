
ALTER TABLE employees 
DROP INDEX i_hire_date;

SELECT emp_no, salary FROM salaries WHERE salary > 89000; 

CREATE INDEX i_salary ON salaries(salary);

