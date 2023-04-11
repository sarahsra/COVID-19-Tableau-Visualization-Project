/* 
Covid 19 Data Visualized
Queries used for Tableau
*/

-- Table 1: Global numbers to see total cases and deaths

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM covidproject.deaths
WHERE continent is not NULL
ORDER by 1,2;


-- Table 2: European Union is part of Europe, so removing this as well as 'World' and 'International' as they are not included in the first query (want to stay consistent)

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From covidproject.deaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
Order by TotalDeathCount DESC;


-- Table 3: Percent of population infected

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM covidproject.deaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;


-- Table 4: Countries with the highest infection rate compared to the population for each country

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covidproject.deaths
Group by Location, Population, date
order by PercentPopulationInfected desc


-- Table 5: United States and Canada, comparing likelihood of dying if infected with COVID

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM covidproject.deaths
WHERE location LIKE '%States%' 
  OR location = 'Canada'
  AND continent is not NULL
ORDER BY 2 DESC;