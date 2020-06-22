USE employees_mod;

SELECT * FROM t_employees;

SELECT gender, COUNT(gender) AS count FROM t_employees GROUP BY gender;

SET @test_date = '2020-01-01';

SELECT *, COUNT(emp_no) from t_dept_emp WHERE YEAR(from_date) = '1992' GROUP BY YEAR(from_date);

SELECT emp_no, from_date, to_date from t_dept_emp;

SELECT DISTINCT emp_no, from_date, to_date from t_dept_emp;

SELECT DISTINCT emp_no from t_dept_emp;

SELECT DISTINCT emp_no, from_date from t_dept_emp;



SELECT
	YEAR(de.from_date) as Calender_year, e.gender , COUNT(e.emp_no) as number_of_employees
FROM 
	t_employees e
    JOIN
    t_dept_emp de
    ON e.emp_no = de.emp_no
GROUP BY 
	Calender_year, e.gender
HAVING Calender_year >= 1990
ORDER BY Calender_year
    ;
    



