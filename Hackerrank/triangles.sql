-- https://www.hackerrank.com/challenges/what-type-of-triangle/problem

USE SQLpractice;

drop table if exists TRIANGLES;
Create table If Not Exists TRIANGLES (A int, B int, C int);
Truncate table TRIANGLES;

insert into TRIANGLES (A, B, C) values (20, 20, 23);
insert into TRIANGLES (A, B, C) values (20, 20, 20);
insert into TRIANGLES (A, B, C) values (20, 21, 22);
insert into TRIANGLES (A, B, C) values (13, 14, 30);


select *
from triangles
;


select 
	  CASE WHEN A = B AND B = C THEN 'Equilateral'
		   WHEN (A = B AND A+B > C) OR (B = C AND B+C > A) OR (A = C AND A+C > B) THEN 'Isosceles'
           WHEN A+B <= C OR A+C <= B OR B+C <= A THEN 'Not A Triangle'
           WHEN A != B AND B != C AND A != C AND (A+B > C OR A+C > B OR B+C > A) THEN 'Scalene'
	  END 
from triangles
;


-- Expected output:   

-- 1 Equilateral        
-- 2 Equilateral 
-- 3 Isosceles 
-- 4 Equilateral 
-- 5 Isosceles 
-- 6 Equilateral 
-- 7 Scalene 
-- 8 Not A Triangle  
-- 9 Scalene 
-- 10 Scalene 
-- 11 Scalene 
-- 12 Not A Triangle 
-- 13 Not A Triangle 
-- 14 Scalene 
-- 15 Equilateral 
