
DROP TABLE IF EXISTS employees_dup;
CREATE TABLE employees_dup
(
  emp_no int,
  birth_date date,
  first_name varchar(14),
  last_name varchar(16),
  gender enum('M','F'),
  hire_date date
);

INSERT INTO employees_dup SELECT * from employees;

SELECT * from employees_dup e ORDER BY -e.emp_no DESC;

INSERT INTO employees_dup VALUES
('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');

SELECT * from employees_dup WHERE emp_no = '10001';


-- UNION vs UNION ALL

SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM employees_dup e
WHERE e.emp_no = 10001
UNION ALL SELECT
	NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
	dept_manager m
;


SELECT
	e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM employees_dup e
WHERE e.emp_no = 10001
UNION SELECT
	NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
	dept_manager m
;




