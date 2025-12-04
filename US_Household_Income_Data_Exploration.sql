SELECT *
FROM us_project.USHouseholdIncome;

SELECT *
FROM us_project.ushouseholdincome_statistics;


#When we're exploring the data we're trying to find trends, patterns, and insights into the data.
#I'm noticing there are no date fields, so no time series data. THerefore, probably won't be lookinh for trends over time.

#We can look at some information at the state level such as the size of each state, average city size, etc.
#We can also join to the statistics table and look at mean and median incomes.

#Let's start simple and work our way to joining the tables.

#Let's select the columns we want to work with
SELECT State_Name, ALand, AWater
FROM us_project.USHouseholdIncome;

#Let's look at the total size of each state and order it from smallest to largest




-- Exploratory Data Analysis


SELECT *
FROM us_project.USHouseholdIncome;

SELECT *
FROM us_project.ushouseholdincome_statistics;


SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.USHouseholdIncome
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;

SELECT *
FROM us_project.USHouseholdIncome u
RIGHT JOIN us_project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE u.id IS NULL
;


SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.USHouseholdIncome u
INNER JOIN us_project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.USHouseholdIncome u
INNER JOIN us_project.ushouseholdincome_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 4 DESC
LIMIT 20
;


SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.USHouseholdIncome u
JOIN us_project.ushouseholdincome_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1)  DESC
;