/*Region section*/
/*looking at the total population of each african region & comparing those with access and those without*/
 SELECT 
    p.Location AS location,
    p.year AS year,
    ROUND(sum(p.Number_with_access_to_electricity),0) AS num_with_access,
    ROUND(sum(p.Number_without_electricity),0) AS num_without_access,
    ROUND(sum(p.Number_with_access_to_electricity + p.Number_without_electricity),0) AS total_population
FROM 
    personal_project.people_with_and_without_electricity AS p
WHERE 
    p.location IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Middle East & North Africa')
GROUP BY 
    p.Location, p.year
ORDER BY 
    p.year ASC;

    /*Calculating the percentage of people with access to electricity to those to do not in each region*/
    SELECT Location,
    round(Number_without_electricity/Total_population,2)*100 AS Percentage_without_electricity,
	round(Number_with_access_to_electricity/Total_population,2)*100 AS percentage_with_access
	FROM
	(SELECT Location,
    Number_with_access_to_electricity, Number_without_electricity,
	(Number_with_access_to_electricity + Number_without_electricity)
	AS Total_population 
    FROM personal_project.people_with_and_without_electricity
	WHERE location IN ( 'Africa Eastern and Southern', 'Africa Western and Central', 'Middle East & North Africa')
    group by Location) as a;
    
/*Focusing on regions that have the highest population without access to electricity*/
SELECT Location,
 max(Number_without_electricity) AS Population_without_Access
	FROM personal_project.number_without_electricity_by_region
	WHERE location IN ('Africa Eastern and Southern', 'Africa Western and Central', 'Middle East & North Africa') 
    AND YEAR BETWEEN 2000 AND 2019
    GROUP BY location
	order by population_without_Access desc;
    
/*Country section*/
/*Identifying the top 10 countries within Eastern & Southern Africa that which have the highest number of people without access to electricity*/
SELECT Location
    MAX(Number_without_electricity) AS Population_without_Access
FROM personal_project.number_without_electricity_by_region
WHERE Location IN ('Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cameroon', 
                    'Central African Republic (CAR)', 'Chad', 'Comoros', 'Democratic Republic of the Congo (DRC)', 
                    'Republic of the Congo', 'Cote d''Ivoire', 'Djibouti', 'Equatorial Guinea', 'Eritrea', 
                    'Eswatini (formerly Swaziland)', 'Ethiopia', 'Gabon', 'The Gambia', 'Ghana', 'Guinea', 
                    'Guinea-Bissau', 'Kenya', 'Lesotho', 'Liberia', 'Madagascar', 'Malawi', 'Mali', 'Mauritania', 
                    'Mauritius', 'Mozambique', 'Namibia', 'Niger', 'Nigeria', 'Rwanda', 'Sao Tome and Principe', 
                    'Senegal', 'Seychelles', 'Sierra Leone', 'Somalia', 'South Africa', 'South Sudan', 'Tanzania', 
                    'Togo', 'Uganda', 'Zambia', 'Zimbabwe')
GROUP BY Location
ORDER BY Population_without_Access DESC
limit 10;

/*Looking at the changes of how many people have had access to electricity for 19 years.*/
SELECT Location, 
Year,
round(Number_with_access_to_electricity,0) AS without_access,
round(Number_without_electricity,0) AS with_access,
round(Number_with_access_to_electricity + Number_without_electricity,0) as Total_population
FROM personal_project.people_with_and_without_electricity
WHERE location = 'Zimbabwe'
AND YEAR BETWEEN 2000 AND 2019
ORDER BY year ASC;

/* Looking at the Index for rural and urban access to electricity for Zimbabwe */
SELECT Location,
 Year,
 Access_to_electricity_rural_Percentage_of_rural_population, Access_to_electricity_urban_Percentage_of_urban_population,
CASE WHEN Access_to_electricity_rural_Percentage_of_rural_population < 50 THEN 'Low'
WHEN Access_to_electricity_rural_Percentage_of_rural_population BETWEEN 59 AND 50 THEN 'Moderate'
WHEN Access_to_electricity_rural_Percentage_of_rural_population BETWEEN 60 AND 75 THEN 'High'
WHEN Access_to_electricity_rural_Percentage_of_rural_population >=70 THEN 'Severe'
END AS Rural_Index,
CASE WHEN Access_to_electricity_urban_Percentage_of_urban_population < 50 THEN 'Low'
WHEN Access_to_electricity_urban_Percentage_of_urban_population BETWEEN 59 AND 50 THEN 'Moderate'
WHEN Access_to_electricity_urban_Percentage_of_urban_population BETWEEN 60 AND 75 THEN 'High'
WHEN Access_to_electricity_urban_Percentage_of_urban_population >=70 THEN 'Very High'
END AS Urban_Index
	FROM personal_project.share_of_rural_population_with_electricity
	WHERE Location = 'Zimbabwe' AND year >= 2000;
    
    /*Comparing the energy consumpation to the energy generation in Southern and East Africa*/
    SELECT e.Location, 
    round(sum(e.Consumption_TWh),2) AS total_consumption,
    round(sum(f.Generation_TWh),2) AS Total_generation
    FROM personal_project.energy_cons AS e
    JOIN personal_project.electricity_generation AS f
    ON e.Location = f.Location
    WHERE e.Location IN ('Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cameroon', 
                    'Central African Republic (CAR)', 'Chad', 'Comoros', 'Democratic Republic of the Congo (DRC)', 
                    'Republic of the Congo', 'Cote d''Ivoire', 'Djibouti', 'Equatorial Guinea', 'Eritrea', 
                    'Eswatini (formerly Swaziland)', 'Ethiopia', 'Gabon', 'The Gambia', 'Ghana', 'Guinea', 
                    'Guinea-Bissau', 'Kenya', 'Lesotho', 'Liberia', 'Madagascar', 'Malawi', 'Mali', 'Mauritania', 
                    'Mauritius', 'Mozambique', 'Namibia', 'Niger', 'Nigeria', 'Rwanda', 'Sao Tome and Principe', 
                    'Senegal', 'Seychelles', 'Sierra Leone', 'Somalia', 'South Africa', 'South Sudan', 'Tanzania', 
                    'Togo', 'Uganda', 'Zambia', 'Zimbabwe') 
    GROUP BY e.Location
    ORDER BY e.Consumption_TWh,
    f.Generation_TWh ASC
    Limit 10;
    
    
    
    


