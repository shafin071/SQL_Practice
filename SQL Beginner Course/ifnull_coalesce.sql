
drop table department_dup;

CREATE TABLE department_dup 
(
    dept_no CHAR(4),
    dept_name VARCHAR(40)
);

SELECT * from department_dup;
    

SET autocommit = 0;
COMMIT;

UPDATE department_dup
SET dept_name = NULL WHERE dept_no = 'd010';


INSERT INTO department_dup
(
	dept_no
)VALUES
(
	'd011'
);

ROLLBACK;

SELECT
	dept_no,
    IFNULL(dept_name, 'Department name not doesnt exist') AS 'dept_name'
FROM
	department_dup;


ALTER TABLE department_dup
ADD dept_manager VARCHAR(40);

SELECT
	dept_no,
	dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS 'dept_manager'
FROM
	department_dup
ORDER BY
	dept_no DESC;
    


SELECT
	dept_no,
	dept_name,
    COALESCE('dept manager name') AS fake_col
FROM
	department_dup
ORDER BY
	dept_no DESC;
    


SELECT
	dept_no,
	dept_name,
    COALESCE(dept_name, 'dept_info') AS dept_info
FROM
	department_dup
ORDER BY
	dept_no DESC;


SELECT
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name, 'Department name not provided') AS dept_name,
	COALESCE(dept_no, dept_name) AS dept_info
FROM
	department_dup;
	
    
