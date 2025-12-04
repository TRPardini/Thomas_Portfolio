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


SELECT State_Name, COUNT(State_Name)
FROM ushouseholdincome
GROUP BY State_Name
;

UPDATE ushouseholdincome
SET State_Name ='Alabama'
WHERE State_Name = 'alabama'
;


SELECT *
FROM ushouseholdincome
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE ushouseholdincome
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


SELECT Type, COUNT(Type)
FROM ushouseholdincome
GROUP BY Type
-- ORDER BY 1
;

UPDATE ushouseholdincome
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

SELECT ALand, AWater
FROM ushouseholdincome
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
;

-- END CLEANING