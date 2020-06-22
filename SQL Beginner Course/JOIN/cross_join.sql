SELECT
	dm.*, d.*
FROM
	dept_manager dm
    CROSS JOIN
	departments d
ORDER BY dm.emp_no, d.dept_no;


# Another way of doing the same thing
SELECT
	dm.*, d.*
FROM
	dept_manager dm,
	departments d
ORDER BY dm.emp_no, d.dept_no;


# Another way of doing the same thing
SELECT
	dm.*, d.*
FROM
	dept_manager dm
    JOIN
	departments d
ORDER BY dm.emp_no, d.dept_no;