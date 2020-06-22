USE employees;

INSERT INTO employees
(
	emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date
) VALUES
(
999901,
'1986-04-21',
'John',
'Smith',
'M',
'2011-01-01'
);


SELECT 
    *
FROM
    employees
ORDER BY emp_no DESC
LIMIT 10;


drop table department_dup;

CREATE TABLE department_dup 
(
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
)
SELECT
	*
FROM
	departments;
    

SELECT
	*
FROM
	department_dup
ORDER BY dept_no;


INSERT INTO departments
(
	dept_no, dept_name
) VALUES
(
	'd010', 'Business Analysis'
);

SELECT * from departments;




