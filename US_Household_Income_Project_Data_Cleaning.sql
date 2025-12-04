SELECT *
FROM us_project.USHouseholdIncome;

SELECT *
FROM us_project.ushouseholdincome_statistics;


SELECT COUNT(id)
FROM us_project.USHouseholdIncome;

SELECT COUNT(id)
FROM us_project.ushouseholdincome_statistics;


SELECT id, COUNT(id)
FROM us_project.USHouseholdIncome
GROUP BY id
HAVING COUNT(id) >1;

#6 duplicate ids identified

DELETE FROM us_project.USHouseholdIncome
WHERE row_id IN(
	SELECT row_id
	FROM(
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.USHouseholdIncome
		) duplicates
	WHERE row_num > 1)
;
#duplicates now deleted

SELECT State_Name, COUNT(State_Name)
FROM ushouseholdincome
GROUP BY State_Name
;
#identified errors with Georgia and Alabama


UPDATE USHouseholdIncome
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;
#Georgia error fixed

UPDATE ushouseholdincome
SET State_Name ='Alabama'
WHERE State_Name = 'alabama'
;
#Alabama error fixed

SELECT *
FROM ushouseholdincome
WHERE County = 'Autauga County'
ORDER BY 1
;
#spotted an error with Autauga County earlier and isolated it here

UPDATE ushouseholdincome
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;
#fixed error


SELECT Type, COUNT(Type)
FROM ushouseholdincome
GROUP BY Type
-- ORDER BY 1
;
#identified two borough types

UPDATE ushouseholdincome
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;
#fixed error

SELECT ALand, AWater
FROM ushouseholdincome
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
OR AWater = 0 OR AWater = '' OR AWater IS NULL
;
#check land/water area anomalies (zeros are common placeholders)

#data appears largely clean with only minimal normalization needed

-- END CLEANING