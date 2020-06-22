USE employees;

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        AND (gender = 'M' OR gender = 'F');
        

SELECT
	*
FROM
	employees
WHERE
	first_name = 'Cathie'
    OR first_name = 'Mark'
    OR first_name = 'Nathan';


SELECT
	*
FROM
	employees
WHERE
	first_name IN ('Cathie', 'Mark', 'Nathan');
    
    
	


