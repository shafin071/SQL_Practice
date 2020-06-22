SELECT
	e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM 
	employees e
    JOIN
    dept_manager m ON e.emp_no = m.emp_no
    JOIN
    departments d ON m.dept_no = d.dept_no
    ;
    
    
    
-- Avg salary of managers from all departments
SELECT d.dept_name, AVG(s.salary)
FROM departments d
	 JOIN
     dept_manager m ON d.dept_no = m.dept_no
     JOIN
     salaries s ON m.emp_no = s.emp_no
GROUP BY dept_name
ORDER BY d.dept_no
;
    



