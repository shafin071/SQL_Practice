
SELECT
	e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM 
	employees e
    LEFT JOIN
    dept_manager d
    ON e.emp_no = d.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY d.dept_no DESC, e.emp_no;