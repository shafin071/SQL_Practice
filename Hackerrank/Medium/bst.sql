-- https://leetcode.com/problems/human-traffic-of-stadium/

USE SQLpractice;

drop table if exists BST;

Create table If Not Exists BST (N int, P int);
Truncate table BST;

insert into BST (N, P) values ('1', '2');
insert into BST (N, P) values ('3', '2');
insert into BST (N, P) values ('6', '8');
insert into BST (N, P) values ('9', '8');
insert into BST (N, P) values ('2', '5');
insert into BST (N, P) values ('8', '5');
insert into BST (N, P) values ('5', null);


select * from BST order by N;

select b1.N,
       case when b1.P is null then 'Root'
            when (SELECT COUNT(b2.P) from BST b2 where b2.P=b1.N) = 0 then 'Leaf'
            else 'Inner'
       end as node_type
from BST b1
order by b1.N;


SELECT COUNT(P) from BST where P=8;