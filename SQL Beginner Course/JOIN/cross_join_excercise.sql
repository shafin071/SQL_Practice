
-- Excercise 1
SELECT
	dm.*, d.*
FROM 
	dept_manager dm
    CROSS JOIN
    departments d
WHERE d.dept_no = 'd009'
ORDER BY d.dept_no;


-- Excercise 2
SELECT
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;
