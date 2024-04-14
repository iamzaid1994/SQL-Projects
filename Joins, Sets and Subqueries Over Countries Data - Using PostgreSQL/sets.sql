---------- # SET OPERATIONS # ----------

----- # UNION # -----

-- Begin your query by selecting all fields from economies2015.
-- Create a second query that selects all fields from economies2019.
-- Perform a set operation to combine the two queries you just created, 
	-- ensuring you do not return duplicates and sort the results by code and year.
SELECT * FROM countries.public.economies2015  
UNION
SELECT * FROM countries.public.economies2019
ORDER BY code, year;

-- Perform an appropriate set operation that determines all pairs of
	-- country code and year (in that order) from economies and populations, 
	-- excluding duplicates. Order by country code and year.
SELECT code AS country_code, year 
FROM countries.public.economies
UNION
SELECT country_code, year 
FROM countries.public.populations
ORDER BY country_code, year ;

----- # UNION ALL # -----

-- Amend the above query to return all combinations (including duplicates)
	-- of country code and year in the economies or the populations tables.
SELECT code AS country_code, year 
FROM countries.public.economies
UNION ALL
SELECT country_code, year 
FROM countries.public.populations
ORDER BY country_code, year;

----- # INTERSECT # -----

-- Return all cities that have the same name as a country.
SELECT name 
FROM countries.public.cities
INTERSECT
SELECT name 
FROM countries.public.countries;

----- # EXCEPT # -----

-- Return all cities that do not have the same name as a country.
SELECT name 
FROM countries.public.cities
EXCEPT
SELECT name 
FROM countries.public.countries
ORDER BY name;