
SELECT
	e.first_name, e.last_name, e.hire_date, t.title, d.from_date, dep.dept_name
FROM
	dept_manager d
    JOIN
    employees e ON d.emp_no = e.emp_no
    JOIN
    departments dep ON d.dept_no = dep.dept_no
    JOIN
    titles t ON d.emp_no = t.emp_no
    WHERE t.title = 'Manager'
ORDER BY e.first_name
;


-- Testing
SELECT
	e.first_name, e.last_name, e.hire_date, d.from_date
FROM
	employees e
    JOIN
    dept_manager d
     ON d.emp_no = e.emp_no
    ;

-- Testing
SELECT
	e.first_name, e.last_name, e.hire_date, d.from_date
FROM
	dept_manager d 
    JOIN
    employees e
     ON d.emp_no = e.emp_no
    ;
    
#---------------------------------------------------------------------------------------------------------------

-- Excercise 2: Tips and tricks for joins

SELECT
	e.gender, COUNT(e.gender) as gender_count
FROM
	dept_manager d
    JOIN
    employees e ON d.emp_no = e.emp_no
GROUP BY e.gender
;
