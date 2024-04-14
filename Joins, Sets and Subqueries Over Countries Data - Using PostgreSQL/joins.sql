---- ### JOINS ### ----

---- ## INNER JOIN ## ----

-- Begin by selecting all columns from the cities table, 
-- using the SQL shortcut that selects all.
SELECT *
FROM countries.public.cities ;

-- Perform an inner join with the cities table on the left 
	-- and the countries table on the right; 
	-- do not alias tables here or in the next step.
-- Identify the relevant column names to join ON by inspecting
	-- the cities and countries.
SELECT * 
FROM countries.public.cities
INNER JOIN countries.public.countries
ON cities.country_code = countries.code ;

-- Select the name of the city, the name of the country, and the region 
	-- is located in (in the order specified).
-- Alias the name of the city AS city and the name of the country AS country.
SELECT 
    cities.name AS city, 
    countries.name AS country, 
    countries.region
FROM countries.public.cities 
INNER JOIN countries.public.countries
ON cities.country_code = countries.code;

-- Join the tables countries AS c (left) with economies (right), aliasing economies AS e.
-- Next, use code as your joining field ; do not use the USING command here.
-- Lastly, select the following columns in order : 
	-- code from the countries table (aliased as country_code), 
	-- name, year, and inflation_rate.
SELECT
    c.code AS country_code,
    c.name,
    e.year,
    e.inflation_rate
FROM countries.public.countries AS c
INNER JOIN countries.public.economies as e
ON c.code = e.code ;

-- Use the country code field to complete the INNER JOIN
	-- for above mentioned tables with USING;
SELECT c.name AS country, l.name AS language, official
FROM countries.public.countries AS c
INNER JOIN countries.public.languages AS l
USING(code) ;

-- Perform an inner join with the countries table as c
	-- on the left with the languages table as l on the right.
-- Make use of the USING keyword to join.
-- Lastly, select the country name, aliased as country, 
	-- and the language name, aliased as language.
-- Select country and language names, aliased
SELECT
    c.name AS country,
    l.name AS language
FROM countries.public.countries as c
INNER JOIN countries.public.languages AS l
USING(code);

-- Rearrange the above statement so that the language column appears
	-- on the left and the country column on the right.
-- Sort the results by language.
SELECT 
    l.name AS language,
    c.name AS country
FROM countries.public.countries AS c
INNER JOIN countries.public.languages AS l
USING(code)
ORDER BY language ;

-- How many languages are spoken in Armenia.
SELECT 
	c.name AS country, 
	COUNT(l.name) AS count_language
FROM countries.public.countries AS c
INNER JOIN countries.public.languages AS l
USING(code)
WHERE c.name = 'Armenia'
GROUP BY country
ORDER BY country;

-- Is Alsatian is spoken in more than one country?
SELECT 
	COUNT(c.name) AS count_country, 
	l.name AS language
FROM countries.public.countries AS c
INNER JOIN countries.public.languages AS l
USING(code)
WHERE l.name = 'Alsatian'
GROUP BY language;

-- Is Bhojpuri is spoken in two countries?
SELECT 
	COUNT(c.name) AS count_country, 
	l.name AS language
FROM countries.public.countries AS c
INNER JOIN countries.public.languages AS l
USING(code)
WHERE l.name = 'Bhojpuri'
GROUP BY language;

-- Perform an inner join of countries AS c (left) 
	-- with populations AS p (right), on code.
-- Select name, year and fertility_rate.
SELECT
    c.name, 
    p.year,
    p.fertility_rate
FROM countries.public.countries AS c
INNER JOIN countries.public.populations AS p
ON c.code = p.country_code;

-- Chain another inner join to the above query with the economies table AS e.
-- Select name, and using table aliases, select year and unemployment_rate 
	-- from the economies table.
SELECT 
	c.name, 
	e.year, 
	p.fertility_rate, 
	e.unemployment_rate
FROM countries.public.countries AS c
INNER JOIN countries.public.populations AS p
ON c.code = p.country_code
INNER JOIN countries.public.economies AS e
ON c.code = e.code;

-- Have a look at the results for from the previous query. We can see that the 
	-- multiple years' values of fertility_rate have been paired with 
	-- multiple years' unemployment_rate, and vice versa.
-- Instead of multiple records, the query should return one for each year.
-- Modify previously written query so that we are joining to economies on year as well as code.
SELECT 
	c.name, 
	e.year, 
	p.fertility_rate, 
	e.unemployment_rate
FROM countries.public.countries AS c
INNER JOIN countries.public.populations AS p
ON c.code = p.country_code
INNER JOIN countries.public.economies AS e
ON c.code = e.code
	AND p.year = e.year;

---- ## OUTER JOINS ## ----

---- # LEFT/LEFT OUTER JOIN # ----

-- Perform a left join with cities AS c1 on the left
	-- and countries as c2 on the right.
-- Use code as the field to merge your tables on.
	-- and select columns name from city AS city, code,
	-- country name AS country, region, city_proper_pop
-- Finally order the results by country code in descending order.
SELECT 
	c1.name AS city, 
    code, 
    c2.name AS country,
    region, 
    city_proper_pop
FROM countries.public.cities AS c1
LEFT JOIN countries.public.countries c2
ON c1.country_code = c2.code
ORDER BY code DESC;

-- Create the LEFT JOIN with the countries table on the left
	--  and the economies table on the right on the code field.
-- Filter the records from the year 2010.
SELECT name, region, gdp_percapita
FROM countries.public.countries AS c
LEFT JOIN countries.public.economies AS e
USING(code)
WHERE e.year = 2010;

-- To calculate per capita GDP per region, begin by grouping by region.
-- After your GROUP BY, choose region in your SELECT statement, 
	-- followed by average GDP per capita using the AVG() function, 
	-- with AS avg_gdp as your alias.
-- Select region, and average gdp_percapita as avg_gdp
SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries.public.countries AS c
LEFT JOIN countries.public.economies AS e
USING(code)
WHERE year = 2010
GROUP BY region;

-- Finally, order the result set by the average GDP per capita from highest to lowest.
-- Return only the first 10 records in your result.
SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries.public.countries AS c
LEFT JOIN countries.public.economies AS e
USING(code)
WHERE year = 2010
GROUP BY region
ORDER BY avg_gdp DESC
LIMIT 10 ;

---- # RIGHT/RIGHT OUTER JOIN # ----

-- Use RIGHT JOIN to join languages with countries
-- Select name from countries as country, name as language and percent from languages.
-- Order the final result by language from lowest to highest.
SELECT 
	countries.name AS country, 
	languages.name AS language, 
	languages.percent
FROM countries.public.languages
RIGHT JOIN countries.public.countries
USING(code)
ORDER BY language;

---- # FULL/FULL OUTER JOIN # ----

-- Perform a full join with countries (left) and currencies (right).
-- Filter for the North America region or NULL country names.
SELECT 
	countries.name AS country, 
	countries.code, 
	countries.region, 
	currencies.basic_unit
FROM countries.public.countries
FULL JOIN countries.public.currencies 
USING (code)
WHERE countries.region = 'North America' 
	OR countries.name IS NULL
ORDER BY region;


-- Repeat the same query as before, turning your full join
	--  into a left join with the currencies table.
-- Have a look at what has changed in the output 
	-- by comparing it to the full join result.
SELECT 
	countries.name AS country, 
	countries.code, 
	countries.region, 
	currencies.basic_unit
FROM countries.public.countries
LEFT JOIN countries.public.currencies 
USING (code)
WHERE countries.region = 'North America' 
	OR countries.name IS NULL
ORDER BY region;

-- Repeat the same query again, this time performing
	-- an inner join of countries with currencies.
-- Have a look at what has changed in the output by comparing
	-- it to the full join and left join results!
SELECT 
	countries.name AS country, 
	countries.code, 
	countries.region, 
	currencies.basic_unit
FROM countries.public.countries
INNER JOIN countries.public.currencies
USING (code)
WHERE countries.region = 'North America' 
	OR countries.name IS NULL
ORDER BY region;

-- Create the FULL JOIN with countries as c1 on the left 
	-- and languages as l on the right, using code to perform this join.
-- Next, chain this join with another FULL JOIN, 
	-- placing currencies on the right, joining on code again.
-- Keep the results for only those regions
	-- starting with M and having esia at the end
SELECT 
	c1.name AS country, 
    c1.region, 
    l.name AS language,
	c2.basic_unit, 
    c2.frac_unit
FROM countries.public.countries as c1 
FULL JOIN countries.public.languages as l 
USING(code)
FULL JOIN countries.public.currencies as c2
USING(code) 
WHERE region LIKE 'M%esia';

---- # CROSS JOIN # ----

-- Write the code to perform an INNER JOIN of countries AS c 
	-- with languages AS l using the code field to obtain the 
	-- languages currently spoken in the two countries PAK and IND.
SELECT 
	c.name AS country, 
	l.name AS language
FROM countries.public.countries AS c
INNER JOIN countries.public.languages AS l
USING(code)
WHERE c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');
	
-- Change your INNER JOIN to a different kind of join to look at 
	-- possible combinations of languages that could have been spoken
	-- in the two countries given their history.
-- Observe the differences in output for both joins.
SELECT 
	c.name AS country, 
	l.name AS language
FROM countries.public.countries AS c        
CROSS JOIN countries.public.languages AS l
WHERE c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');

---- # Test Case # ----

-- Complete the join of countries AS c with populations as p.
	-- Filter on the year 2010.
	-- Sort your results by life expectancy in ascending order.
	-- Limit the result to five countries.
SELECT 
	c.name AS country,
    c.region,
    p.life_expectancy AS life_exp
FROM countries.public.countries AS c
LEFT JOIN countries.public.populations AS p 
ON c.code = p.country_code
WHERE p.year = 2010
ORDER BY p.life_expectancy
LIMIT 5;

---- # SELF JOIN # ----

-- Perform an inner join of populations with itself 
-- ON country_code, aliased p1 and p2 respectively.
-- Select aliased fields from populations as p1
SELECT
    p1.country_code,
    p1.size AS size2010,
    p2.size AS size2015
FROM countries.public.populations AS p1
INNER JOIN countries.public.populations AS p2
ON p1.country_code = p2.country_code;

-- Since you want to compare records from 2010 and 2015, 
	-- eliminate unwanted records by extending the WHERE 
	-- statement to include only records where the p1.year matches p2.year - 5.
SELECT 
	p1.country_code, 
    p1.size AS size2010, 
    p2.size AS size2015
FROM countries.public.populations AS p1
INNER JOIN countries.public.populations AS p2
ON p1.country_code = p2.country_code
WHERE p1.year = 2010
    AND p2.year = p1.year+5;
