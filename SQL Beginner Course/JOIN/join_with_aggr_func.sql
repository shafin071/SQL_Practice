USE employees;

SELECT 
    e.gender, AVG(s.salary) AS average_salary, COUNT(e.gender) as gender_count
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;