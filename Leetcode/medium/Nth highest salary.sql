-- https://leetcode.com/problems/nth-highest-salary/

USE SQLpractice;

drop table if exists Employee;

Create table If Not Exists Employee (Id int, Salary int);

Truncate table Employee;
insert into Employee (Id, Salary) values ('1', '100');
insert into Employee (Id, Salary) values ('2', '200');
insert into Employee (Id, Salary) values ('3', '300');

select * from Employee;

select salary as 'getNthHighestSalary' from Employee order by Salary desc;

select salary as 'getNthHighestSalary' from Employee order by Salary desc LIMIT 1,1;

SELECT COUNT(DISTINCT salary) FROM Employee;


-- Leetcode not accepting dense_rank solution
SELECT Salary as getNthHighestSalary
FROM
	(
    SELECT Salary,
		   dense_rank() over (
				order by Salary desc
		   ) id
	FROM
		Employee
    ) tbl
;



-- This is the most appropriate solution
select distinct salary as getNthHighestSalary
from Employee E
where 1= (select count(distinct salary) from Employee E2 where E2.Salary > E.Salary);


-- My version of the same solution
select Salary
from Employee as e1
where (select count(distinct e2.Salary)+1 from Employee as e2 where e1.Salary < e2.Salary) = 1  # or N
order by Salary desc
;










select
	Salary,
    (select count(distinct Salary) + 1 from Employee e2 where e2.Salary > e1.Salary) as Ranking
from 
	Employee e1