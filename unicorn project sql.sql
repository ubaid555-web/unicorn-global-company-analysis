create database unic;
select * from unicorn;
select count(distinct company) as count_of_company from unicorn;
select distinct company from unicorn;
select distinct industry from unicorn;
select distinct country from unicorn;
select distinct continent from unicorn;
select count(distinct industry) as count_of_industry,
count(distinct country) as count_of_country,
count(distinct continent) as count_of_continent,
count(distinct  city) as count_of_city from unicorn;

select company,count(*) as tot_count from unicorn
group by company having count(*)>1;

select * from unicorn where company='fabric';

select * from unicorn where joined_year<year_founded;
delete from unicorn where joined_year<year_founded;

select * from unicorn where years_taken<0;

select * from unicorn where valuation>10000000000;--$10billion

select * from unicorn where city='Bangalore';

select * from unicorn where years_taken>20;

select * from unicorn where Year_founded<2000;

select * from unicorn where funding=0;

select * from unicorn where years_taken=5;


select industry,max(valuation) as maximun_valuation,
min(valuation) as minimum_valuation,
sum(valuation) as total_valuation,
avg(valuation) as average_valuation from unicorn
group by industry order by total_valuation desc;

select continent,country,count(company) as total_companies
from unicorn group by Continent,Country order by total_companies desc;

select top 10 company,sum(valuation) as total_valuation from unicorn 
group by company order by total_valuation desc;

select industry,count(*) as tot_comp from unicorn group by industry
having count(*)>20 order by tot_comp desc;

select country, count(*) as total_company from unicorn group by country
having count(*)>5 order by total_company;

select company,industry,valuation,dense_rank() 
over(partition by industry order by valuation desc) from unicorn;

select industry,sum(valuation) as total_val,avg(valuation) as avg_val,count(*) as total_comapny, 
dense_rank() over(order by avg(valuation) desc) as rank_no 
from unicorn group by industry order by avg_val desc;

select joined_year,count(*) as total_companies from unicorn
group by joined_year order by joined_year ;

select industry,avg(years_taken) avg_years_taken from unicorn
group by industry order by avg_years_taken desc;

select continent,avg(valuation) as average_valuation,avg(funding) as average_funding
from unicorn group by continent order by average_valuation desc;

select industry,avg(valuation) as avg_val from unicorn 
group by industry having avg(valuation)>(select avg(valuation) from unicorn) order by avg_val;

select company,valuation from unicorn 
where valuation>(select avg(valuation) from unicorn) order by valuation desc;


select continent,company,valuation from(
select continent,company,valuation, rank()
over(partition by continent order by valuation desc) as rank_n from unicorn) 
as rn where rank_n=1;

select continent,company,valuation, rank()
over(partition by continent order by valuation desc) as rank_n from unicorn;

--the countries that have the highest number of unicorn companies within each continent
select continent,country,total_company from(select continent,country,count(*) as total_company,rank() 
over(partition by continent order by count(*) desc) as rank_n from unicorn
group by continent,country)as rn where rank_n=1  order by total_company desc;

--companies whose valuation is greater than the average valuation of their respective industries
select company,industry,valuation from(select company,industry,valuation,avg(valuation) 
over(partition by industry) as avg_val from unicorn) as rn where valuation>avg_val;

