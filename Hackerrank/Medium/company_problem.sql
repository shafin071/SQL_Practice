
-- https://www.hackerrank.com/challenges/the-company/problem

USE SQLpractice;

drop table if exists Company;
Create table If Not Exists Company (company_code varchar(255), founder varchar(255));
Truncate table Company;

drop table if exists Lead_Manager;
Create table If Not Exists Lead_Manager (lead_Manager_code varchar(255), company_code varchar(255));
Truncate table Lead_Manager;

drop table if exists Senior_Manager;
Create table If Not Exists Senior_Manager (senior_manager_code varchar(255), lead_Manager_code varchar(255), company_code varchar(255));
Truncate table Senior_Manager;

drop table if exists Manager;
Create table If Not Exists Manager (manager_code varchar(255), senior_manager_code varchar(255), lead_Manager_code varchar(255), company_code varchar(255));
Truncate table Manager;

drop table if exists Employee;
Create table If Not Exists Employee (employee_code varchar(255), manager_code varchar(255), senior_manager_code varchar(255), lead_Manager_code varchar(255), company_code varchar(255));
Truncate table Employee;



insert into Company (company_code, founder) values ('C1', 'Monika');
insert into Company (company_code, founder) values ('C2', 'Samantha');

insert into Lead_Manager (lead_Manager_code, company_code) values ('LM1', 'C1');
insert into Lead_Manager (lead_Manager_code, company_code) values ('LM2', 'C2');

insert into Senior_Manager (senior_manager_code, lead_Manager_code, company_code) values ('SM1', 'LM1', 'C1');
insert into Senior_Manager (senior_manager_code, lead_Manager_code, company_code) values ('SM2', 'LM1', 'C1');
insert into Senior_Manager (senior_manager_code, lead_Manager_code, company_code) values ('SM3', 'LM2', 'C2');

insert into Manager (manager_code, senior_manager_code, lead_Manager_code, company_code) values ('M1', 'SM1', 'LM1', 'C1');
insert into Manager (manager_code, senior_manager_code, lead_Manager_code, company_code) values ('M2', 'SM3', 'LM2', 'C2');
insert into Manager (manager_code, senior_manager_code, lead_Manager_code, company_code) values ('M3', 'SM3', 'LM2', 'C2');

insert into Employee (employee_code, manager_code, senior_manager_code, lead_Manager_code, company_code) values ('E1', 'M1', 'SM1', 'LM1', 'C1');
insert into Employee (employee_code, manager_code, senior_manager_code, lead_Manager_code, company_code) values ('E2', 'M1', 'SM1', 'LM1', 'C1');
insert into Employee (employee_code, manager_code, senior_manager_code, lead_Manager_code, company_code) values ('E3', 'M2', 'SM3', 'LM2', 'C2');
insert into Employee (employee_code, manager_code, senior_manager_code, lead_Manager_code, company_code) values ('E4', 'M3', 'SM3', 'LM2', 'C2');



select c.company_code, c.founder, lm.lead_manager_code, sm.senior_manager_code, m.manager_code, e.employee_code
from Company c
     JOIN
     Lead_Manager lm
     ON c.company_code = lm.company_code
     JOIN
     Senior_Manager sm
     ON lm.company_code = sm.company_code
     JOIN
     Manager m
     ON sm.company_code = m.company_code
     JOIN
     Employee e
     ON m.company_code = e.company_code
;


select c.company_code, c.founder, COUNT( distinct lm.lead_manager_code), COUNT(distinct sm.senior_manager_code), COUNT(distinct m.manager_code), COUNT(distinct e.employee_code)
from Company c
     JOIN
     Lead_Manager lm
     ON c.company_code = lm.company_code
     JOIN
     Senior_Manager sm
     ON lm.company_code = sm.company_code
     JOIN
     Manager m
     ON sm.company_code = m.company_code
     JOIN
     Employee e
     ON m.company_code = e.company_code
group by 1
;





