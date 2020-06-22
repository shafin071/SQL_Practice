-- https://www.hackerrank.com/challenges/occupations/problem

USE SQLpractice;

drop table if exists Occupations;

Create table If Not Exists Occupations (Name varchar(255), Occupation varchar(255));
Truncate table Occupations;

insert into Occupations (Name, Occupation) values ('Samantha', 'Doctor');
insert into Occupations (Name, Occupation) values ('Julia', 'Actor');
insert into Occupations (Name, Occupation) values ('Maria', 'Actor');
insert into Occupations (Name, Occupation) values ('Meera', 'Singer');
insert into Occupations (Name, Occupation) values ('Ashley', 'Professor');
insert into Occupations (Name, Occupation) values ('Ketty', 'Professor');
insert into Occupations (Name, Occupation) values ('Christeen', 'Professor');
insert into Occupations (Name, Occupation) values ('Jane', 'Actor');
insert into Occupations (Name, Occupation) values ('Jenny', 'Doctor');
insert into Occupations (Name, Occupation) values ('Priya', 'Singer');


select * from Occupations order by Occupation, Name;



-- Correct Solution
set @r1=0, @r2=0, @r3=0, @r4=0;

select min(Doctor), min(Professor), min(Singer), min(Actor)
from (
      select case when Occupation='Doctor' then (@r1:=@r1+1)
            when Occupation='Professor' then (@r2:=@r2+1)
            when Occupation='Singer' then (@r3:=@r3+1)
            when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
			case when Occupation='Doctor' then Name end as Doctor,
			case when Occupation='Professor' then Name end as Professor,
			case when Occupation='Singer' then Name end as Singer,
			case when Occupation='Actor' then Name end as Actor
	  from OCCUPATIONS
	  order by Name
     ) temp_tbl
group by RowNumber
  ;



# -----------------------------------------------------------------------------------------------------------------
-- My attempts

select *
from (
		select CASE WHEN Occupation='Doctor' then Name end as Doctor,
			   CASE WHEN Occupation='Professor' then Name end as Professor,
			   CASE WHEN Occupation='Singer' then Name end as Singer,
			   CASE WHEN Occupation='Actor' then Name end as Actor
		from Occupations
		order by Occupation, Name
	 ) tbl
where 
;



select count(Name) as name_count
from Occupations
group by Occupation;

select MAX(name_count) 
from 
    (
    select count(Name) as name_count
	from Occupations
	group by Occupation
    ) tbl
	;




