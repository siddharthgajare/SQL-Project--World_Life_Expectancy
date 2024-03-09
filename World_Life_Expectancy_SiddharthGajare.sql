# WORLD LIFE EXPECTANCY PROJECT ( SIDDHARTH GAJARE )

SELECT * 
FROM world_life_expectancy;

###################################################
# NOW ILL DO THE DATA CLEANING ON THIS DATASET
###################################################


SELECT *
FROM world_life_expectancy
WHERE Year = '2022';  #FOUND OUT THERE ARE DUPLICATE DATA IN ROWS

SELECT
Country,
Year,
CONCAT(Country, Year)
FROM world_life_expectancy #THIS MERGING WILL HELP TO REMOVE THE DUPLICATE DATA FROM THE TABLE
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1;   #NOW I HAVE DUPLICATE ROWS FROM THE DATA


SELECT *
FROM (
	SELECT
	Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER () OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_num
	FROM world_life_expectancy  #I have now put row number to CONCAT column with partition so duplicate now have number multiple number and those who are single is 1
) AS Row_table
WHERE Row_Num > 1;  #Shows all row no. greater than 1. All Duplicates

# In next step ill delete these multiple rows

DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
	FROM (
		SELECT
		Row_ID,
		CONCAT(Country, Year),
		ROW_NUMBER () OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_num
		FROM world_life_expectancy  
		) AS Row_table
		WHERE Row_Num > 1
		);


SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> '';   #Checking Status Data

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing';

UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT (Country)
	FROM world_life_expectancy
	WHERE Status = 'Developing'); #Tried but gives an error, should will now try different method


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'; # Changed blanks where the country was developing 

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'; # Changed blanks where the country was developed

SELECT * 
FROM world_life_expectancy
WHERE Status IS NULL;   #Cross checked if the table had any NULL values left

SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = '';   #Found 2 blanks in life expectancy column

SELECT t1.Country, t1.Year, t1.`Life Expectancy`, 
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
	AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
	AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = '';    # Made one new table with both the previous and next year and calculate avg on those to get the missing value


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
	AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
	AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = '';    # Updated changes in the table to remove blanks from life expectancy column


SELECT * 
FROM world_life_expectancy; # Checked and now the data is cleaned but would be aware during exploratory if any further data cleaning is required



###################################################
# NOW ILL DO THE DATA EXPLORATORY ON THIS DATASET
###################################################

SELECT *
FROM world_life_expectancy
;

# Finding difference of Life Expectancy in 15 years of a country
SELECT Country, MIN(`Life expectancy`) As Min_LifeExpectancy, 
MAX(`Life expectancy`) As Max_LifeExpectancy,
ROUND (MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15Years ASC
;   

# Finding Avg life expectancy of a country
SELECT Year, ROUND(AVG(`Life expectancy`),2) AS Average_Country_Expectancy
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0   # This will ensure that we dont avg if there is any value zero (Just to be safer)
GROUP BY Year
ORDER BY Year; 

#Comparing Avg LE to AVG GDP
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS AVG_LE, ROUND(AVG(GDP),1) AS AVG_GDP
FROM world_life_expectancy
GROUP BY Country
HAVING AVG_LE > 0
AND AVG_GDP > 0
ORDER BY AVG_GDP DESC;

# Found out AVG life expectancy of all countries with GDP > 1500 VS GDP < 1500
SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) HIGH_GDP_COUNT,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) HIGH_GDP_LIFE_EXPECTANCY,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) LOW_GDP_COUNT,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) LOW_GDP_LIFE_EXPECTANCY
FROM world_life_expectancy;


#Finding AVG of countries by Status
SELECT Status, ROUND(AVG(`Life expectancy`),1) as AVG_Status
FROM world_life_expectancy
GROUP BY Status;

# AVG Life Expectancy VS BMI
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS AVG_LE, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING AVG_LE > 0
AND BMI > 0
ORDER BY BMI DESC;
# FOUND OUT THAT LOWER BMI CAUSES LOWER LIFE EXPECTANCY

# Life Expectancy VS Adult Mortality
SELECT Country, Year, `Life expectancy`, `Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) As Rolling_Total
FROM world_life_expectancy;
