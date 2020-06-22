-- https://leetcode.com/problems/department-highest-salary/

USE SQLpractice;

drop table if exists Employee;
drop table if exists Department;

Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
Create table If Not Exists Department (Id int, Name varchar(255));

-- Main case
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '70000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Jim', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Max', '90000', '1');

Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');


-- Test case
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '60000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max', '60000', '2');

Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'HR');


-- Test Case
Truncate table Employee;
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '60000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Sam', '50000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max', '50000', '2');

Truncate table Department;
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'HR');


# --------------------------------------------------------------------------------------------------------------


select * from Employee;
select * from Department;


select DepartmentId, MAX(salary) as max_salary from Employee group by DepartmentId;


select e.Name, max_salary as Salary, e.DepartmentId
from Employee e
     JOIN
     (select DepartmentId, MAX(salary) as max_salary from Employee group by DepartmentId) m
     ON e.Salary = m.max_salary AND e.DepartmentId = m.DepartmentId
	;
    
    

select d.Name as Department,
	   e1.Name as Employee,
       e1.Salary as Salary
from (
		select e.Name, max_salary as Salary, e.DepartmentId
		from Employee e
			 JOIN
			 (select DepartmentId, MAX(salary) as max_salary from Employee group by DepartmentId) m
			 ON e.Salary = m.max_salary AND e.DepartmentId = m.DepartmentId
	  ) e1
     JOIN
     Department d
     ON e1.DepartmentId = d.Id 
	;




