/*
    Data Exploration on Covid 19 Dataset
*/

/*
    Table 'covd' as Covid Deaths
    Table 'covv' as Covid Vaccinations
*/

--Showing everything from table 'covd'
select * from covd

--Showing everything from table 'covv'
select * from covv

--Every column in table 'covd'
describe covd

--Every column in table 'covv'
describe covv

--Excluding following data further on
select distinct location, continent
from covd
where continent is null
order by location asc

--Selecting every location considered in Dataset
select distinct location, continent
from covd
where continent is not null
order by location asc

--Prime Data of table 'covd'
select distinct location, population, max(total_cases) as cases, max(total_deaths) as deaths
from covd
where continent is not null
group by location, population
order by location asc

--Extracting percentages out of given from previous query
select distinct location, population, max(total_cases) as cases, max(total_deaths) as deaths,
round(max(total_cases)/population*100, 2) as infected_rate, 
round(max(total_deaths)/population*100, 2) as death_rate,
round(max(total_deaths)/max(total_cases)*100, 2) as mortality_rate
from covd
where continent is not null
group by location, population
order by location asc

--Statistic per milion cases from table 'covd'
select distinct location, population, 
max(total_cases_per_million) as cases_per_million, 
max(total_deaths_per_million) as deaths_per_million
from covd
where continent is not null
group by location, population
order by location asc

--Prime Data of table 'covv'
select distinct location, max(total_tests), 
max(total_tests_per_thousand) as test_rate, 
max(total_vaccinations), max(people_vaccinated), 
max(people_fully_vaccinated_per_hundred) as fully_vac_rate,
max(stringency_index), max(positive_rate)
from covv
where continent is not null
group by location
order by location asc

--Non Covid, health related Data
select distinct location, cardiovasc_death_rate as heart_deaths,
diabetes_prevalence, male_smokers, female_smokers
from covv
where continent is not null
order by location asc

--Non Covid related Data
select distinct location, population_density, median_age,
gdp_per_capita, life_expectancy, human_development_index as hdi
from covv
where continent is not null
order by location asc

--Record of cases and deaths by date in certain country
select location, date_, total_cases, total_deaths,
round((total_deaths/total_cases)*100, 2) as rate
from covd
where location = 'France'
and continent is not null
order by date_ asc

--Record of cases by day in certain country
select location, date_, population, total_cases,
round(total_cases/population*100, 5) as rate
from covd 
where location like 'Germany'
and continent is not null
order by date_ asc

--Highest infection rate by country
select location, population, max(total_cases) as highest_infection,  
round(max((total_cases/population))*100, 2) as infection_rate
from covd
where continent is not null
group by location, population
order by infection_rate desc

--Continents with highest death rate
select continent, max(total_deaths) as total_deaths
from covd
where continent is not null
group by continent
order by total_deaths desc

--Selecting vaccinations by country using join
select distinct d.location, d.population, 
max(cast(v.total_vaccinations as int)) as vaccinations,
round(max(v.total_vaccinations)/d.population*100, 2) as rate
from covd d
join covv v
	on d.location = v.location
	and d.date_ = v.date_
where d.continent is not null 
group by d.location, d.population
order by rate desc

--Selecting vaccination rate by country using join
select d.location, d.population, 
max(v.people_vaccinated) as vaccinated,
d.population-max(v.people_vaccinated) as non_vaccinated,
max(v.people_fully_vaccinated) as fully_vaccinated,
round(max(v.people_vaccinated)/population*100, 2) as vaccinated_rate,
round(max(v.people_vaccinated)/population*100, 2) as fully_vaccinated_rate
from covd d
join covv v 
    on d.date_ = v.date_
    and d.location = v.location
where d.continent is not null
group by d.location, d.population
order by d.location asc


