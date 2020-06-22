-- https://leetcode.com/problems/delete-duplicate-emails/

USE SQLpractice;

drop table if exists Person;

Create table If Not Exists Person (Id int, Email varchar(255));

insert into Person (Id, Email) values ('1', 'john@example.com');
insert into Person (Id, Email) values ('2', 'bob@example.com');
insert into Person (Id, Email) values ('3', 'john@example.com');
-- insert into Person (Id, Email) values ('4', 'john@example.com');


SELECT * from Person;

SELECT distinct Email from Person;

SELECT * from Person p1 inner join Person p2 where p1.Id > p2.Id and p1.Email = p2.Email;

SELECT * from Person p1 inner join Person p2 where p1.Id > p2.Id;

SELECT * from Person p1 left join Person p2 on p1.Email = p2.Email;

SELECT * from Person p1 left join Person p2 on p1.Id = p2.Id;

DELETE p1 from Person p1 inner join Person p2 where p1.Id > p2.Id and p1.Email = p2.Email;

SELECT * from Person;





