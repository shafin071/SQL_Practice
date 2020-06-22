-- https://leetcode.com/problems/reformat-department-table/

use employees;

drop table if exists Department;

Create table If Not Exists Department (id int, revenue int, month varchar(5));
Truncate table Department;
insert into Department (id, revenue, month) values ('1', '8000', 'Jan');
insert into Department (id, revenue, month) values ('2', '9000', 'Jan');
insert into Department (id, revenue, month) values ('3', '10000', 'Feb');
insert into Department (id, revenue, month) values ('1', '7000', 'Feb');
insert into Department (id, revenue, month) values ('1', '6000', 'Mar');
insert into Department (id, revenue, month) values ('4', '8000', 'Apr');


select * from Department;



SELECT d.id as 'id',
      d1.revenue as 'Jan_Revenue',
      d2.revenue as 'feb_Revenue',
      d3.revenue as 'Mar_Revenue',
      d4.revenue as 'Apr_Revenue',
      d5.revenue as 'May_Revenue',
      d6.revenue as 'Jun_Revenue',
      d7.revenue as 'Jul_Revenue',
      d8.revenue as 'Aug_Revenue',
      d9.revenue as 'Sep_Revenue',
      d10.revenue as 'Oct_Revenue',
      d11.revenue as 'Nov_Revenue',
      d12.revenue as 'Dec_Revenue'
FROM Department d
LEFT JOIN (SELECT * FROM Department WHERE month = 'Jan') d1 on d1.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Feb') d2 on d2.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Mar') d3 on d3.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Apr') d4 on d4.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'May') d5 on d5.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Jun') d6 on d6.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Jul') d7 on d7.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Aug') d8 on d8.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Sep') d9 on d9.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Oct') d10 on d10.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Nov') d11 on d11.id = d.id
LEFT JOIN (SELECT * FROM Department WHERE month = 'Dec') d12 on d12.id = d.id
GROUP BY 1
;

SELECT * FROM Department WHERE month = 'Jan';
SELECT * FROM Department WHERE month = 'Feb';
SELECT * FROM Department WHERE month = 'Mar';


SELECT d.id, 
MAX(CASE WHEN d.month='Jan' THEN d.revenue END) AS 'Jan_Revenue',
MAX(CASE WHEN d.month='Feb' THEN d.revenue END) AS 'Feb_Revenue',
MAX(CASE WHEN d.month='Mar' THEN d.revenue END) AS 'Mar_Revenue',
MAX(CASE WHEN d.month='Apr' THEN d.revenue END) AS 'Apr_Revenue',
MAX(CASE WHEN d.month='May' THEN d.revenue END) AS 'May_Revenue',
MAX(CASE WHEN d.month='Jun' THEN d.revenue END) AS 'Jun_Revenue',
MAX(CASE WHEN d.month='Jul' THEN d.revenue END) AS 'Jul_Revenue',
MAX(CASE WHEN d.month='Aug' THEN d.revenue END) AS 'Aug_Revenue',
MAX(CASE WHEN d.month='Sep' THEN d.revenue END) AS 'Sep_Revenue',
MAX(CASE WHEN d.month='Oct' THEN d.revenue END) AS 'Oct_Revenue',
MAX(CASE WHEN d.month='Nov' THEN d.revenue END) AS 'Nov_Revenue',
MAX(CASE WHEN d.month='Dec' THEN d.revenue END) AS 'Dec_Revenue'
FROM Department AS d
GROUP BY id;


SELECT id, Max(CASE WHEN d.month='Jan' THEN d.revenue END) AS 'Jan_Revenue' FROM Department AS d group by id;
SELECT id, CASE WHEN d.month='Feb' THEN d.revenue END AS 'Feb_Revenue' FROM Department AS d;

