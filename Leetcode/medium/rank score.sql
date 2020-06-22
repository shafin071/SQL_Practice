-- https://leetcode.com/problems/rank-scores/

USE SQLpractice;

Create table If Not Exists Scores (Id int, Score DECIMAL(3,2));
Truncate table Scores;
insert into Scores (Id, Score) values ('1', '3.5');
insert into Scores (Id, Score) values ('2', '3.65');
insert into Scores (Id, Score) values ('3', '4.0');
insert into Scores (Id, Score) values ('4', '3.85');
insert into Scores (Id, Score) values ('5', '4.0');
insert into Scores (Id, Score) values ('6', '3.65');


SELECT Max(Score) from Scores;

select Id, Score, 
		   COUNT(Id) as Id_count
	from Scores
	group by Score
	order by Score Desc
    ;


select count(distinct Score) from Scores;


-- Solution from Leetcode disucssions
-- The idea is, for each score it checks how many distinct score is higher. 
-- For 4.0 there are 0 scores higher so its 0+1
select Score, (select count(distinct t2.Score)+1 from Scores as t2 where t1.Score < t2.Score) AS Ranking
from Scores as t1
order by Score desc
;


-- Using dense_rank function. Leetcode does not accept this function

SELECT Score,
       dense_rank() over (
			order by Score desc
       ) id
FROM
	Scores
;
