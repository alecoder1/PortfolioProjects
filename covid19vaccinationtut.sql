select * from coviddeaths;
select count(*) 
from coviddeaths c 
order by continent; 

select location,date,total_cases, total_deaths, population
from coviddeaths
order by 1, 2;

select * 
from coviddeaths
where continent is not null
order by 3, 4;


-- looking for total_cases vs total_deaths
-- shows the likelihood of dying if you contract covid in your country

select location,date,total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths
-- where location like '%kenya%'
where continent is not null
order by 1, 2;


-- looking for total cases vs population

select location,date,total_cases, population , (total_deaths/population)*100 as percentPopulationInfected
from coviddeaths
-- where location like '%kenya%'
where continent is not null
order by 1, 2;


-- Looking at the countries with highest Infection rate compared to population
select location,population, max(total_cases) as HighestInfectionCount, MAX((total_deaths/population))*100 as percentPopulationInfected
from coviddeaths
where continent is not null
group by location,population  
order by percentPopulationInfected desc;


-- Showing the countries with the highest death counts of population
SELECT location, MAX(CAST(total_deaths AS SIGNED)) AS TotalDeathCount
FROM coviddeaths
where continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Let's break things down by continent
SELECT continent  , MAX(CAST(total_deaths AS SIGNED)) AS TotalDeathCount
FROM coviddeaths
where continent is not null
GROUP BY continent 
ORDER BY TotalDeathCount DESC;

-- Showing the contents with the highest death counts per population
SELECT continent  , MAX(CAST(total_deaths AS SIGNED)) AS TotalDeathCount
FROM coviddeaths
where continent is not null
GROUP BY continent 
ORDER BY TotalDeathCount DESC;	


-- GLOBAL NUMBERS

select date,SUM(new_cases)--,total_deaths ,(total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths
-- where location like '%kenya%'
where continent is not null
group by date
order by 1, 2;

SELECT  SUM(new_cases) as total_new_cases, SUM(cast(new_deaths as signed)) as total_new_deaths, sum(cast(new_deaths as signed)) /sum(new_cases)*100
as DeathPercentage
FROM coviddeaths
-- WHERE location LIKE '%kenya%'
WHERE continent IS NOT NULL
-- GROUP BY date
ORDER BY 1, 2;



select * 
from covidvaccinations c ;

select count(*)
from covidvaccinations;

-- Looking at total population vs vaccination

select dea.continent, dea.location , dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as signed)) over (partition by dea.location 
order by dea.location, dea.date) as rollingPeopleVaccinated
from coviddeaths dea
join covidvaccinations vac
on dea.location = vac.location 
and dea.date = vac.`date` 
where dea.continent is not null
order by 2,3;



-- Use CTE

with PopvsVac (continent, location, date, population,new_vaccinations, rollingPeopleVaccinated)

as
(
select dea.continent, dea.location , dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as signed)) over (partition by dea.location 
order by dea.location, dea.date) as rollingPeopleVaccinated
from coviddeaths dea
join covidvaccinations vac
on dea.location = vac.location 
and dea.date = vac.`date` 
where dea.continent is not null
order by 2,3
)
select *, (rollingPeopleVaccinated/population)*100 as rvsP
from PopvsVac;


-- Temp Table

Drop Table if exists #PercentPopulationVaccinated;

Create temporary table #PercentPopulationVaccinated
(
	Continent varchar(255),
	Location varchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
)
insert into #PercentPopulationVaccinated
select dea.continent, dea.location , dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as signed)) over (partition by dea.location 
order by dea.location, dea.date) as rollingPeopleVaccinated
from coviddeaths dea
join covidvaccinations vac
on dea.location = vac.location 
and dea.date = vac.`date` 
where dea.continent is not null
order by 2,3
select *, (rollingPeopleVaccinated/population)*100 
from #PercentPopulationVaccinated;




CREATE TEMPORARY TABLE #PercentPopulationVaccinated (
  Continent varchar(255) not NULL,
  Location varchar(255) not NULL,
  Date datetime  not null,
  Population numeric,
  New_vaccinations numeric,
  RollingPeopleVaccinated numeric
);

INSERT INTO #PercentPopulationVaccinated
SELECT
  dea.continent,
  dea.location,
  dea.date,
  dea.population,
  vac.new_vaccinations,
  SUM(CAST(vac.new_vaccinations AS signed)) OVER (
    PARTITION BY dea.location
    ORDER BY dea.location, dea.date
  ) AS rollingPeopleVaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac
ON dea.location = vac.location
AND dea.date = vac.`date`
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;

SELECT
  *,
  (rollingPeopleVaccinated / population) * 100 AS percent_population_vaccinated
FROM #PercentPopulationVaccinated;


-- Creating view to store data for later visualization

create view PercentPopulationVaccinated as
select 
dea.continent, 
dea.location , 
dea.date, 
dea.population, 
vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as signed)) over (partition by dea.location 
order by dea.location, dea.date) as rollingPeopleVaccinated
from coviddeaths dea
join covidvaccinations vac
on dea.location = vac.location 
and dea.date = vac.`date` 
where dea.continent is not null
-- order by 2,3;


select *
from PercentPopulationVaccinated;