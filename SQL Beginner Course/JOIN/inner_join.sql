CREATE TABLE dept_manager_dup 
(
  emp_no int,
  dept_no char(4),
  from_date date,
  to_date date
)
SELECT
	*
FROM
	dept_manager;
    
DROP TABLE dept_manager_dup;


SELECT * from dept_manager_dup ORDER BY dept_no;

SELECT * from department_dup ORDER BY dept_no;


SELECT 
    t1.dept_no, t1.emp_no, t2.dept_name
FROM
    dept_manager_dup t1
        INNER JOIN
    department_dup t2 
		ON t1.dept_no = t2.dept_no
ORDER BY t1.dept_no;


SELECT
	t1.emp_no, t2.first_name, t2.last_name, t1.dept_no, t2.hire_date
FROM 
	dept_manager_dup t1
		INNER JOIN
	employees t2
		ON t1.emp_no = t2.emp_no
ORDER BY t1.emp_no;



