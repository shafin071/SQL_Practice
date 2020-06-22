-- https://leetcode.com/problems/classes-more-than-5-students/

USE SQLpractice;

Create table If Not Exists seat(id int, student varchar(255));
Truncate table seat;
insert into seat (id, student) values ('1', 'Abbot');
insert into seat (id, student) values ('2', 'Doris');
insert into seat (id, student) values ('3', 'Emerson');
insert into seat (id, student) values ('4', 'Green');
insert into seat (id, student) values ('5', 'Jeames');


select * from seat where id%2=0;

select * from seat s1 join seat s2 where s2.id = s1.id-1;


-- My failed attempts

select * from seat s1 join (select * from seat where id%2!=0) s2 JOIN (select * from seat where id%2=0) s3  ;

select s1.id, 
	   CASE
			WHEN s3.id = s2.id+1 THEN s3.student
            WHEN s2.id
	   END AS student
from ((select * from seat where id%2!=0) s2 JOIN (select * from seat where id%2=0) s3) join seat s1;


select * 
from
	seat seat_main
    LEFT JOIN
    (select s1.id, 
	   CASE
			WHEN s3.id = s2.id+1 THEN s3.student
            ELSE s2.student
	   END AS student
	 from seat s1 join (select * from seat where id%2!=0) s2 JOIN (select * from seat where id%2=0) s3) seat_dup
     ON seat_main.student = seat_dup.student
	;
    
    
# ----------------------------------------------------------------------------------------------------------------

-- Solution from Leetcode
SELECT
    COUNT(*) AS counts
FROM
    seat
    ;


SELECT
    (CASE
        WHEN MOD(id, 2) != 0 AND counts != id THEN id + 1
        WHEN MOD(id, 2) != 0 AND counts = id THEN id
        ELSE id - 1
    END) AS id,
    student
FROM
    seat,
    (SELECT
        COUNT(*) AS counts
    FROM
        seat) AS seat_counts
ORDER BY id ASC;


select *
from seat s
right join seat s2 on floor((s.id +1) / 2) = floor((s2.id + 1) / 2) and s.id != s2.id
;


select floor(1/2);



-- Using Left join and case
SELECT A.id, 
       (CASE 
	        WHEN B.student IS  NULL THEN A.student 
			ELSE B.student 
	    END) AS student
FROM seat A LEFT JOIN seat B ON (A.id = B.id-1 and A.id%2 = 1) or (A.id = B.id+1 and A.id%2 = 0)
ORDER BY 1;




