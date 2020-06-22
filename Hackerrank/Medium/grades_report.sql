# https://www.hackerrank.com/challenges/the-report/problem

USE SQLpractice;


drop tables if exists Grades;
Create table If Not Exists Grades (Grade int, Min_Mark int, Max_Mark int);
Truncate table Grades;
insert into Grades (Grade, Min_Mark, Max_Mark) values ('1', '0', '9');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('2', '10', '19');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('3', '20', '29');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('4', '30', '39');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('5', '40', '49');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('6', '50', '59');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('7', '60', '69');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('8', '70', '79');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('9', '80', '89');
insert into Grades (Grade, Min_Mark, Max_Mark) values ('10', '90', '100');


drop tables if exists Students;
Create table If Not Exists Students (id int, Name varchar(255), Marks int);
Truncate table Students;
insert into Students (id, Name, Marks) values ('1', 'Julia', '88');
insert into Students (id, Name, Marks) values ('2', 'Samantha', '68');
insert into Students (id, Name, Marks) values ('3', 'Maria', '99');
insert into Students (id, Name, Marks) values ('4', 'Scarlet', '78');
insert into Students (id, Name, Marks) values ('5', 'Ashley', '63');
insert into Students (id, Name, Marks) values ('6', 'Jane', '81');


select * from Grades;
select * from Students;

select  
       CASE WHEN g.Grade >= 8 THEN s.Name ELSE NULL END as 'Name', 
       g.Grade, s.Marks
from Students s,
     Grades g
     WHERE s.Marks between g.Min_Mark AND g.Max_Mark
ORDER BY g.Grade desc, s.Name
;

