-- https://leetcode.com/problems/duplicate-emails/

USE SQLpractice;

drop table if exists Person;


Create table If Not Exists Person (Id int, Email varchar(255));
Truncate table Person;
insert into Person (Id, Email) values ('1', 'a@b.com');
insert into Person (Id, Email) values ('2', 'c@d.com');
insert into Person (Id, Email) values ('3', 'a@b.com');


select * from Person;

select email, count(email) from Person group by email;

select email from ( select email, count(email) as email_count from Person group by email ) tbl where email_count > 1;

select email from Person group by email having count(email) > 1;
