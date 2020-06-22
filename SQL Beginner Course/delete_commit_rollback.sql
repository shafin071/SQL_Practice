
SELECT * FROM employees ORDER BY emp_no DESC;

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
999903,
'1977-09-14',
'Johnathan',
'Creek',
'M',
'1999-01-01'
);

SELECT * FROM employees WHERE emp_no = 999903;

INSERT into titles
(
	emp_no,
    title,
    from_date
)VALUES
(
	999903,
    'Senior Engineer',
    '1997-10-01'
);

SELECT * FROM titles WHERE emp_no = 999903;

SET autocommit = 0;
COMMIT;

DELETE FROM employees WHERE emp_no = 999903;

ROLLBACK;

SELECT * from departments;

DELETE FROM departments WHERE dept_no LIKE ('%10');