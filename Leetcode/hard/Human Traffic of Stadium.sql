-- https://leetcode.com/problems/human-traffic-of-stadium/

USE SQLpractice;

Create table If Not Exists stadium (id int, visit_date DATE NULL, people int);
Truncate table stadium;
insert into stadium (id, visit_date, people) values ('1', '2017-01-01', '10');
insert into stadium (id, visit_date, people) values ('2', '2017-01-02', '109');
insert into stadium (id, visit_date, people) values ('3', '2017-01-03', '150');
insert into stadium (id, visit_date, people) values ('4', '2017-01-04', '99');
insert into stadium (id, visit_date, people) values ('5', '2017-01-05', '145');
insert into stadium (id, visit_date, people) values ('6', '2017-01-06', '1455');
insert into stadium (id, visit_date, people) values ('7', '2017-01-07', '199');
insert into stadium (id, visit_date, people) values ('8', '2017-01-08', '188');


select * from stadium;


select *
from stadium s1 JOIN stadium s2
WHERE s2.id = s1.id+1
;

SELECT MAX(id) from stadium;

select 
	 CASE WHEN s2.id = (SELECT MAX(id) from stadium) THEN s2.id
		  WHEN s1.id = s2.id-1 AND s1.people > 100 THEN s1.id
          END AS id,
     s1.visit_date,
     s1.people
from stadium s1
     JOIN
     stadium s2
WHERE s2.id = s1.id+1
;


select 
	 CASE WHEN datediff(s2.visit_date, s1.visit_date) = 1 AND s1.people > 100 THEN s1.id
     END AS id
from stadium s1
     JOIN
     stadium s2
WHERE s2.id = s1.id OR s2.id = s1.id+1
;


-- Leetcode solution

select distinct t1.*
from stadium t1, stadium t2, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
      and 
      (
		(t1.id - t2.id = 1 and t1.id - t3.id = 2 and t2.id - t3.id =1)  -- t1, t2, t3
		or
		(t2.id - t1.id = 1 and t2.id - t3.id = 2 and t1.id - t3.id =1) -- t2, t1, t3
		or
		(t3.id - t2.id = 1 and t2.id - t1.id =1 and t3.id - t1.id = 2) -- t3, t2, t1
		)
order by t1.id
;


select distinct t1.*
from stadium t1, stadium t2, stadium t3
;

select *
from stadium t1, stadium t2, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
;


