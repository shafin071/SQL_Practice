
DELETE FROM dept_manager_dup
WHERE emp_no  = '110228';

DELETE FROM department_dup
WHERE dept_no = 'd009';

SELECT * FROM dept_manager_dup ORDER BY dept_no ASC;

SELECT * FROM department_dup ORDER BY dept_no ASC;

INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO department_dup
VALUES ('d009', 'Customer Service', 'Customer Service Manager');


SELECT
	m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
	LEFT JOIN
department_dup as d
	ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;


# Reversing sides
SELECT
	d.dept_no, m.emp_no, d.dept_name
FROM 
department_dup d
	LEFT JOIN
dept_manager_dup m 
	ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;