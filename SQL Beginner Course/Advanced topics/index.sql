USE employees;

SELECT * FROM employees WHERE hire_date > '2001-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

SHOW INDEX FROM employees;

SHOW INDEX FROM departments;