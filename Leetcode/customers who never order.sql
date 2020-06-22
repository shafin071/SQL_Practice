-- https://leetcode.com/problems/customers-who-never-order/

USE SQLpractice;

drop table if exists Customers;
drop table if exists Orders;

Create table If Not Exists Customers (Id int, Name varchar(255));
Create table If Not Exists Orders (Id int, CustomerId int);

Truncate table Customers;
insert into Customers (Id, Name) values ('1', 'Joe');
insert into Customers (Id, Name) values ('2', 'Henry');
insert into Customers (Id, Name) values ('3', 'Sam');
insert into Customers (Id, Name) values ('4', 'Max');

Truncate table Orders;
insert into Orders (Id, CustomerId) values ('1', '3');
insert into Orders (Id, CustomerId) values ('2', '1');


select * from Customers;
select * from Orders;


select
	c.Name as Customers, o.CustomerId
from 
	Orders o
    RIGHT JOIN
    Customers c
    ON o.CustomerId = c.Id
WHERE o.CustomerId is null
    ;
    
    
-- Alternative solution (faster)
select customers.name as 'Customers'
from customers
where customers.id not in
(
    select customerid from orders
);
