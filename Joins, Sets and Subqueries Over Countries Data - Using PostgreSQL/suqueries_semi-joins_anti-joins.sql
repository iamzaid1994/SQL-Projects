-- Select code from countries wher countries belong to Middle East region
SELECT code 
FROM countries.public.countries
WHERE region = 'Middle East';

-- Write a second query to SELECT the name of each unique language 
	-- appearing in the languages table; do not use column aliases here.
-- Order the result set by name in ascending order.
-- Select unique language names
SELECT DISTINCT(name)
FROM countries.public.languages
ORDER BY name;

-- Create a semi join out of the two queries you've written, 
	-- which filters unique languages returned in the first query 
	-- for only those languages spoken in the 'Middle East'.
SELECT DISTINCT name 
FROM countries.public.languages
WHERE code IN
    (SELECT code
    FROM countries.public.countries
    WHERE region = 'Middle East')
ORDER BY name;

-- Begin by writing a query to return the code and name 
	-- (in order, not aliased) for all countries in the continent
	-- of Oceania from the countries table.
SELECT code, name 
FROM countries.public.countries
WHERE code IN
    (SELECT code 
    FROM countries.public.countries
    WHERE continent = 'Oceania');

-- Now, build on your query to complete your anti join, by adding an
	--  additional filter to return every country code that is not 
	-- included in the currencies table.
SELECT code, name
FROM countries.public.countries
WHERE continent = 'Oceania'
  AND code NOT IN
    (SELECT code
    FROM countries.public.currencies);

-- Begin by calculating the average life expectancy from the populations table.
-- Filter your answer to use records from 2015 only.
SELECT AVG(life_expectancy) 
FROM countries.public.populations
WHERE year = 2015;

-- Now use the above query as a nested query into another query; 
	-- use this calculation to filter populations for all records where
	--  life_expectancy is 1.15 times higher than average.
SELECT *
FROM countries.public.populations
WHERE life_expectancy > 1.15 * 
  (SELECT AVG(life_expectancy)
   FROM countries.public.populations
   WHERE year = 2015) 
    AND year = 2015;

-- Return the name, country_code and urbanarea_pop for all capital cities (not aliased).
-- Sort the results by urbanarea_pop in descending order.
SELECT name, country_code, urbanarea_pop
FROM countries.public.cities
WHERE name IN
    (SELECT DISTINCT capital 
    FROM countries.public.countries)
ORDER BY urbanarea_pop DESC;

-- Write a LEFT JOIN with countries on the left and 
	-- the cities on the right, joining on country code.
-- In the SELECT statement of your join, include country names as country, 
	-- and count the cities in each country, aliased as cities_num.
-- Sort by cities_num (descending), and country (ascending), 
	-- limiting to the first nine records.
-- Find top nine countries with the most cities
SELECT 
    countries.name AS country, 
    COUNT(cities.name) as cities_num
FROM countries.public.countries
LEFT JOIN countries.public.cities
ON countries.code = cities.country_code
GROUP BY countries.name
ORDER BY COUNT(cities.name) DESC
LIMIT 9;

-- Write the subquery to return a result equivalent to your 
	-- LEFT JOIN, counting all cities in the cities table as cities_num.
-- Use the WHERE clause to enable the correct country codes 
	-- to be matched in the cities and countries columns.
SELECT countries.name AS country,
  (SELECT COUNT(name)
   FROM countries.public.cities
   WHERE country_code = countries.code) AS cities_num
FROM countries.public.countries
ORDER BY cities_num DESC
LIMIT 9;

-- Begin with a query that groups by each country code from languages, 
	-- and counts the languages spoken in each country as lang_num.
-- In your SELECT statement, return code and lang_num (in that order).
SELECT code, COUNT(lang_id) as lang_num
FROM countries.public.languages
GROUP BY code
ORDER BY lang_num DESC;

-- Select local_name from countries, with the aliased lang_num 
	-- from your subquery (which has been nested and aliased for you as sub).
-- Use WHERE to match the code field from countries and sub.
-- Select local_name and lang_num from appropriate tables
SELECT local_name, sub.lang_num
FROM countries.public.countries,
    (SELECT code, COUNT(*) AS lang_num
     FROM countries.public.languages
     GROUP BY code) AS sub
WHERE countries.code = sub.code
ORDER BY lang_num DESC;

-- Select country code, inflation_rate, and unemployment_rate from economies.
	-- For the year 2015.
-- Filter code for the set of countries which do not contain
	--  the words "Republic" or "Monarchy" in their gov_form.
SELECT code, inflation_rate, unemployment_rate
FROM countries.public.economies
WHERE year = 2015 
  AND code NOT IN
    (SELECT code
     FROM countries
     WHERE (gov_form LIKE '%Monarchy%' OR gov_form LIKE '%Republic%'))
ORDER BY inflation_rate;

-- From cities, select the city name, country code, proper population, and
	-- metro area population, as well as the field city_perc, which calculates the
	-- proper population as a percentage of metro area population 
	-- for each city (using the formula provided).
	-- city_proper_pop / metroarea_pop * 100
-- Filter city name with a subquery that selects capital cities from 
	-- countries in 'Europe' or continents with 'America' at the end of their name.
-- Exclude NULL values in metroarea_pop.
-- Order by city_perc (descending) and return only the first 10 rows.
SELECT 
	name, 
    country_code, 
    city_proper_pop, 
    metroarea_pop,
    city_proper_pop / metroarea_pop * 100 AS city_perc
FROM countries.public.cities
WHERE name IN
  (SELECT capital
   FROM countries.public.countries
   WHERE (continent = 'Europe' OR continent LIKE '%America'))
	  AND metroarea_pop IS NOT NULL
ORDER BY city_perc DESC
LIMIT 10;