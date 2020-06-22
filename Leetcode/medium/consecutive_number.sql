-- https://leetcode.com/problems/consecutive-numbers/

USE SQLpractice;

Create table If Not Exists Logs (Id int, Num int);
Truncate table Logs;
insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');


select * from Logs;

select *
from 
	Logs L1 
    inner join 
    Logs L2 
    inner join 
    Logs L3
	where L2.id = L1.id + 1 AND L3.id = L2.id + 1
;


select 
	CASE WHEN L1.Num = L2.Num AND L2.Num = L3.Num THEN L1.NUM
    END AS ConsecutiveNums 
from 
	Logs L1 
    inner join 
    Logs L2 
    inner join 
    Logs L3
	where L2.id = L1.id + 1 AND L3.id = L2.id + 1
;

select distinct ConsecutiveNums from (select 
				CASE WHEN L1.Num = L2.Num AND L2.Num = L3.Num THEN L1.NUM
				END AS ConsecutiveNums 
			from 
				Logs L1 
				join 
				Logs L2 
				join 
				Logs L3
				where L2.id = L1.id + 1 AND L3.id = L2.id + 1
			 ) tbl
            where ConsecutiveNums is not null
            ;

