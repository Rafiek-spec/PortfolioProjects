Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--Select *
--From PortfolioProject..CovidVaccinations
--Where continent is not null
--order by 3,4

--Select Location, date, total_cases, new_cases, total_deaths, population
--From PortfolioProject..CovidDeaths
--Where continent is not null
--order by 1,2

--Select Location, date, total_cases, total_deaths, (total_cases/total_deaths)*100 as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE continent is not null
--order by 1,2

--Select Location, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
--FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%' 
--order by 1,2

--Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentpopulationInfected
--FROM PortfolioProject..CovidDeaths
--WHERE continent is not null
--GROUP by Location, Population
--order by PercentpopulationInfected

--SELECT	Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
--FROM PortfolioProject..CovidDeaths
--WHERE continent is not null
--Group by Location 
--order by TotalDeathCount desc

--Select *
--From PortfolioProject..CovidDeaths dea
--Join PortfolioProject..CovidVaccinations vac
--On dea.location = vac.location
--and dea.date = vac.date

--With PopvsVac ( Continent, Location, Date, Population, New_Vaccination, RollingPeopleVaccinated)
--as
--(
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
--FROM PortfolioProject..CovidDeaths dea
--Join PortfolioProject..CovidVaccinations vac
--On dea.location = vac.location
--and dea.date = vac.date
--Where dea.continent is not null
--)
--Select *, (RollingPeopleVaccinated/Population)*100 
--From PopvsVac

--DROP Table if exists #PercentPopulationVaccinated
--CREATE Table #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--RollingPeopleVaccinated numeric
--)

--Insert into #PercentPopulationVaccinated
--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
--FROM PortfolioProject..CovidDeaths dea
--Join PortfolioProject..CovidVaccinations vac
--On dea.location = vac.location
--and dea.date = vac.date
--Where dea.continent is not null
--Select *, (RollingPeopleVaccinated/Population)*100 
--From #PercentPopulationVaccinated


Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location ORDER by dea.location, dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null

Select *
From PercentPopulationVaccinated









