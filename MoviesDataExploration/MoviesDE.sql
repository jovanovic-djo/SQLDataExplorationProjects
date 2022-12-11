/*
    Data exploration on movies Dataset       ==>   Source: Kaggle
*/

--Selecting everything from table movies
select * from movies

--Showing all rows
describe movies

--Every movie genre from dataset
select distinct genre
from movies

--Every movie director from dataset
select distinct director
from movies

--Every movie rate from dataset
select distinct rating
from movies

--Every distribution company form dataset
select distinct company 
from movies

--Newest movies in dataset
select name||' ====> '||year as name, 
genre, director, company||': '||budget as budget
from movies
where budget is not null
and company is not null
order by year desc

--Selecting certain directors movies and sorting them by score
select name||' --- '||year as name, genre, score
from movies
where director like 'Roman Polanski'
order by score desc

--Selecting TOP 10 movies by budget using subquery
select * from
(select name||' === '||year as movie, budget
from movies
where budget is not null
order by budget desc)
where rownum <= 10

--Selecting family friendly movies using clause IN
select name||' --- '||year as name, genre, rating
from movies
where rating in('G', 'PG', 'PG-13', 'TV-PG')
order by score desc

--Highest ranked movie
select genre, name, score
from movies
where score = (select max(score) from movies)

--Highest rated movies by genre
select genre, name, max(score)
from movies
group by genre
order by max(score) desc

--All highest ranking movies using INNER JOIN
select a.genre, b.name, b.score as rating
from movies a
left join movies b
on a.id = b.id
where b.score is not null
order by b.score desc

--Average movie runtime per production company
select company, round(sum(runtime)/count(name), 2) as average_runtime
from movies
group by company
order by average_runtime desc






