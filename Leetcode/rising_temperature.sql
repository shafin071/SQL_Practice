-- https://leetcode.com/problems/rising-temperature/

USE SQLpractice;

drop table if exists Weather;


Create table If Not Exists Weather (Id int, RecordDate date, Temperature int);
Truncate table Weather;
insert into Weather (Id, RecordDate, Temperature) values ('1', '2015-01-01', '10');
insert into Weather (Id, RecordDate, Temperature) values ('2', '2015-01-02', '25');
insert into Weather (Id, RecordDate, Temperature) values ('3', '2015-01-03', '20');
insert into Weather (Id, RecordDate, Temperature) values ('4', '2015-01-04', '30');
insert into Weather (Id, RecordDate, Temperature) values ('5', '2015-01-07', '33');
insert into Weather (Id, RecordDate, Temperature) values ('6', '2015-01-12', '39');

SELECT * from Weather;

SELECT *
FROM Weather w1 INNER JOIN Weather w2 where w1.Temperature > w2.Temperature AND w1.RecordDate > w2.RecordDate;


select a.id as Id, a.recorddate as date
from weather a
join weather b
on DATEDIFF (a.recorddate,b.recorddate)=1
where a.temperature>b.temperature;