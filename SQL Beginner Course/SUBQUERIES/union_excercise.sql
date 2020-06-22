
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager
(
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);


SELECT emp_no from dept_manager WHERE emp_no = 110022;
SELECT emp_no from dept_manager WHERE emp_no = 110039;

-- Subset A
SELECT 
	e.emp_no, 
    de.dept_no,
    (SELECT emp_no from dept_manager WHERE emp_no = 110022) AS manager_ID
FROM
	employees e
    JOIN
    dept_emp de
    ON e.emp_no = de.emp_no
WHERE e.emp_no <= 10020
GROUP BY e.emp_no
ORDER BY e.emp_no
;



-- Subset B
SELECT 
	e.emp_no, 
    de.dept_no,
    (SELECT emp_no from dept_manager WHERE emp_no = 110039) AS manager_ID
FROM
	employees e
    JOIN
    dept_emp de
    ON e.emp_no = de.emp_no
WHERE e.emp_no BETWEEN 10021 AND 10040
GROUP BY e.emp_no
ORDER BY e.emp_no
;

-- Subset C
SELECT 
	e.emp_no,
    dm.dept_no,
    (SELECT emp_no from dept_manager WHERE emp_no = 110039) AS manager_ID
FROM
	employees e
    JOIN
    dept_manager dm
    ON e.emp_no = dm.emp_no
WHERE
	e.emp_no = 110022
;


-- Subset D
SELECT 
	e.emp_no,
    dm.dept_no,
    (SELECT emp_no from dept_manager WHERE emp_no = 110022) AS manager_ID
FROM
	employees e
    JOIN
    dept_manager dm
    ON e.emp_no = dm.emp_no
WHERE
	e.emp_no = 110039
;


-- TIME FOR UNION!!!!

INSERT INTO emp_manager SELECT
U.*
    FROM
    (
		SELECT A.*
		FROM
		(
			SELECT 
			e.emp_no, 
			de.dept_no,
			(SELECT emp_no from dept_manager WHERE emp_no = 110022) AS manager_ID
			FROM
				employees e
				JOIN
				dept_emp de
				ON e.emp_no = de.emp_no
			WHERE e.emp_no <= 10020
			GROUP BY e.emp_no
			ORDER BY e.emp_no
		) as A
        
		UNION 
        
        SELECT B.* 
		FROM
		(
		SELECT 
		e.emp_no, 
		de.dept_no,
		(SELECT emp_no from dept_manager WHERE emp_no = 110039) AS manager_ID
		FROM
			employees e
			JOIN
			dept_emp de
			ON e.emp_no = de.emp_no
		WHERE e.emp_no BETWEEN 10021 AND 10040
		GROUP BY e.emp_no
		ORDER BY e.emp_no
		) as B
        
        UNION
        
        SELECT C.*
        FROM
        (
			SELECT 
				e.emp_no,
				dm.dept_no,
				(SELECT emp_no from dept_manager WHERE emp_no = 110039) AS manager_ID
			FROM
				employees e
				JOIN
				dept_manager dm
				ON e.emp_no = dm.emp_no
			WHERE
				e.emp_no = 110022
        ) AS C
        
        UNION
        
		SELECT D.*
        FROM
        (
			SELECT 
				e.emp_no,
				dm.dept_no,
				(SELECT emp_no from dept_manager WHERE emp_no = 110022) AS manager_ID
			FROM
				employees e
				JOIN
				dept_manager dm
				ON e.emp_no = dm.emp_no
			WHERE
				e.emp_no = 110039
        ) as D
        
	) as U
    ;
    
    
SELECT * FROM emp_manager;




-- Test
SELECT emp_no, dept_no from dept_manager WHERE emp_no = 110022;
SELECT emp_no, dept_no from dept_manager WHERE emp_no = 110039;
    









