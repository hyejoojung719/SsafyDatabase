USE world;
select * from city;
select * from country;
select * from countrylanguage;
#1
select code, name from country 
where code = (select CountryCode from city where name='kabul');
#2
select name, language, percentage from country c join countrylanguage l on c.code = l.CountryCode
where l.percentage=100 and l.isofficial='T' order by c.name ;
#3
select ct.name, l.language, n.name from country n join city ct
on n.code = ct.CountryCode join countrylanguage l on n.code = l.CountryCode
where ct.name='amsterdam' and l.isOfficial='T';
#4
select n.name, n.capital, ct.name 수도, ct.population 수도인구
from country n join city ct on n.code = ct.CountryCode
where n.name like 'United%' and ct.id = n.capital;
#5
select n.name, n.capital, ifnull(ct.name , "수도없음") 수도, ifnull(ct.population, "수도없음") 수도인구
from country n  left join city ct on n.code = ct.CountryCode and ct.id = n.capital
where n.name like 'United%';
#6
select count(*) 국가수 from countrylanguage
where percentage > (select max(percentage) from countrylanguage where CountryCode='che' and isofficial='T') and isofficial='T';
#7
select l.language from country n join countrylanguage l on n.code = l.CountryCode where n.name='South Korea' and isofficial='T';
#8
select n.name, n.code, count(ct.name) 도시개수 
from country n left join city ct on n.code = ct.CountryCode where n.name like 'Bo%' and ct.name is not null group by n.name;
#9
select n.name, n.code, if(count(ct.name)=0, '단독', count(ct.name)) 도시개수 
from country n left join city ct on n.code = ct.CountryCode where n.name like 'Bo%' group by n.name;
#10
select countrycode, name, population from city where population = (select max(population) from city);
#11
select n.name, code, ct.name, ct.population from country n join city ct on n.code = ct.CountryCode
where ct.population = (select min(population) from city);
#12
select countrycode, name, population from city 
where population > (select population from city where countrycode='KOR' and name='seoul');
#13
select ct.countrycode, language from city ct join countrylanguage l on ct.CountryCode = l.CountryCode
where isofficial='T' and name='san miguel';
#14
select countrycode, max(population) max_pop from city group by(countrycode) order by 1;
#15
select countrycode, name, population from city group by countrycode having max(population) order by 1;
#16
-- 국가 정보는 존재하지만 도시가 존재하지 않는 정보도 출력
select ct.countrycode, cn.name, ct.name, ct.population from city ct right join country cn on ct.countrycode = cn.code 
group by ct.countrycode ;
select ct.countrycode, cn.name, ct.name, ct.population from city ct right join country cn on ct.countrycode = cn.code 
group by ct.countrycode having max(ct.population) order by 1;
#17
create view summary as (
select ct.countrycode, cn.name as 'co_name', ct.name as 'ci_name', ct.population from city ct join country cn on ct.countrycode = cn.code 
group by ct.countrycode having max(ct.population) order by 1);
#18
select * from summary where countrycode='KOR';