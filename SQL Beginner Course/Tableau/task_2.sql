
SELECT DISTINCT YEAR(from_date) AS calender_year FROM t_dept_manager ORDER BY calender_year;

SELECT
	d.dept_name, e.gender, dm.emp_no, dm.from_date, dm.to_date, y.calender_year,
    CASE
		WHEN YEAR(dm.from_date) <= y.calender_year AND YEAR(dm.to_date) >= y.calender_year 
			THEN 1
        ELSE 0
	END AS is_active
FROM
	(SELECT DISTINCT YEAR(from_date) AS calender_year FROM t_dept_manager ORDER BY calender_year) y
	CROSS JOIN
		t_dept_manager dm
		JOIN
		t_employees e
		ON dm.emp_no = e.emp_no
		JOIN
		t_departments d
		ON dm.dept_no = d.dept_no
	-- WHERE calender_year = 1998 AND e.gender = 'F' -- This is just for double-checking with Tableau
	ORDER BY e.emp_no
		;
        
        


SELECT
	d.dept_name, e.gender, dm.emp_no, dm.from_date, dm.to_date
FROM
	t_dept_manager dm
	JOIN
	t_employees e
	ON dm.emp_no = e.emp_no
	JOIN
	t_departments d
	ON dm.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service' 
ORDER BY e.emp_no
	;









-- Testing ---------------------------------------------------------------------------------


SELECT * FROM t_dept_manager;

SELECT e.emp_no, e.gender, YEAR(dm.from_date) AS year_, dm.to_date
FROM 
	t_employees e
    JOIN
    t_dept_manager dm
    ON e.emp_no = dm.emp_no
GROUP BY year_, e.gender
ORDER BY emp_no
;



SELECT dm.*, d.*
FROM
    t_departments d
        CROSS JOIN
    t_dept_manager dm
-- WHERE
--     dm.dept_no = 'd009'
ORDER BY d.dept_name;

SELECT * from  t_departments;

SELECT * from  t_dept_manager;
