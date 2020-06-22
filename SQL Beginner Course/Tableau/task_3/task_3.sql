SELECT
	e.gender, d.dept_name, ROUND(AVG(s.salary), 2) as avg_salary, YEAR(s.from_date) AS calender_year
FROM
	t_employees e 
    JOIN
    t_dept_emp de
    ON e.emp_no = de.emp_no
    JOIN
    t_salaries s
    ON e.emp_no = s.emp_no
    JOIN
    t_departments d
    ON de.dept_no = d.dept_no
GROUP BY d.dept_name, e.gender, calender_year
HAVING calender_year <= '2002'
ORDER BY e.gender, d.dept_name, calender_year
;



-- testing
SELECT * FROM t_dept_emp;

SELECT * from t_salaries;

SELECT emp_no, COUNT(emp_no) as _count FROM t_dept_emp GROUP BY emp_no HAVING _count > 1;

SELECT * FROM t_dept_emp WHERE emp_no = 10510;

SELECT emp_no, from_date, COUNT(YEAR(from_date)) as _count FROM t_dept_emp GROUP BY from_date;
	
