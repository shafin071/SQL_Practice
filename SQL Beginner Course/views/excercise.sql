
SELECT
	dm.emp_no, dm.dept_no, s.salary
FROM
	dept_manager dm
    JOIN
    salaries s
    ON dm.emp_no = s.emp_no AND dm.to_date = s.to_date
GROUP BY dm.emp_no
ORDER BY dm.emp_no
;


SELECT
	s.emp_no, s.salary
FROM
	dept_manager dm
    JOIN
    salaries s
    ON dm.emp_no = s.emp_no 
;

-- SOLUTION
CREATE OR REPLACE VIEW v_manager_avg_salary AS
SELECT
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;



SELECT
        dm.emp_no, s.salary, s.from_date, s.to_date, t.title
    FROM
        salaries s
            JOIN
        dept_manager dm ON s.emp_no = dm.emp_no
			JOIN
		titles t ON dm.emp_no = t.emp_no
	WHERE dm.emp_no = 110022
        ;





SELECT * FROM salaries where emp_no = 110022;

SELECT * FROM dept_manager where emp_no = 110022;

SELECT *, COUNT(emp_no) AS count FROM dept_manager GROUP BY emp_no;