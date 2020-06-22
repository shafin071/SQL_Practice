
-- % means any length of chars
SELECT
	*
FROM
	employees
WHERE
	first_name LIKE ('Mar%');
    

-- _ means single char
SELECT
	*
FROM
	employees
WHERE
	first_name LIKE ('Mar_');