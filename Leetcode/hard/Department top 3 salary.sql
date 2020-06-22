-- https://leetcode.com/problems/department-top-three-salaries/

USE SQLpractice;

drop table if exists Employee;
drop table if exists Department;

Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '85000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Janet', '69000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('6', 'Randy', '85000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('7', 'Will', '70000', '1');

Create table If Not Exists Department (Id int, Name varchar(255));
Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');


select * from Employee;
select * from Department;

-- My solution
-- Step 1: Rank salary per department as done in ranked_tbl
-- Step 2: Join with Department table to get department names
-- Step 3: Add a where clause to pick ranks <= 3
select d.Name AS Department, ranked_tbl.Name as Employee, ranked_tbl.Salary as Salary
from
	(
		select Id, Name, DepartmentId, Salary, 
			   (select count(distinct Salary) + 1 from Employee e2 where e2.Salary > e1.Salary and e1.DepartmentId = e2.DepartmentId ) AS Ranking
		from Employee e1
		order by e1.DepartmentId
    ) ranked_tbl
    JOIN
    Department d
    ON d.Id = ranked_tbl.DepartmentId
where Ranking <= 3
;


-- Leetcode solution
SELECT
    d.Name AS 'Department', e1.Name AS 'Employee', e1.Salary
FROM
    Employee e1
        JOIN
    Department d ON e1.DepartmentId = d.Id
WHERE
    3 > (SELECT
            COUNT(DISTINCT e2.Salary)
        FROM
            Employee e2
        WHERE
            e2.Salary > e1.Salary
                AND e1.DepartmentId = e2.DepartmentId
        )
;



