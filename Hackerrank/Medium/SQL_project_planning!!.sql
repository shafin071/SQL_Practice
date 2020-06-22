# https://www.hackerrank.com/challenges/sql-projects/problem

USE SQLpractice;

drop tables if exists Projects;
Create table If Not Exists Projects (Task_ID int, Start_Date date, End_Date date);
Truncate table Projects;

insert into Projects (Task_ID, Start_Date, End_Date) values ('1', '2015-10-01', '2015-10-02');
insert into Projects (Task_ID, Start_Date, End_Date) values ('2', '2015-10-02', '2015-10-03');
insert into Projects (Task_ID, Start_Date, End_Date) values ('3', '2015-10-03', '2015-10-04');
insert into Projects (Task_ID, Start_Date, End_Date) values ('4', '2015-10-13', '2015-10-14');
insert into Projects (Task_ID, Start_Date, End_Date) values ('5', '2015-10-14', '2015-10-15');
insert into Projects (Task_ID, Start_Date, End_Date) values ('6', '2015-10-28', '2015-10-29');
insert into Projects (Task_ID, Start_Date, End_Date) values ('7', '2015-10-30', '2015-10-31');


select * from Projects;

select *
from Projects p1, Projects p2
where p2.Task_ID = p1.Task_ID + 1
;

SELECT Start_Date, End_Date
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b 
WHERE Start_Date < End_Date
;


SELECT Start_Date, End_Date
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b 
WHERE Start_Date < End_Date
GROUP BY Start_Date 
ORDER BY DATEDIFF(End_Date, Start_Date), Start_Date
;








