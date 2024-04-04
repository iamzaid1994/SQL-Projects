--Count the total number of records in the people table, 
--aliasing the result as count_records.
SELECT 
	COUNT(*) AS count_records 
FROM films.public.people;

--Count the number of records with a birthdate in the people table, 
--aliasing the result as count_birthdate.
SELECT 
	COUNT(birthdate) AS count_birthdate 
FROM films.public.people;

--Count the records for languages and countries in the films table, 
--alias as count_languages and count_countries.
SELECT 
	COUNT(language) AS count_languages, 
	COUNT(country) AS count_countries 
FROM films.public.films;

--Return the unique countries represented in the films table using DISTINCT.
SELECT 
	DISTINCT country 
FROM films.public.films;

--Return the number of unique countries represented in the films table, 
--aliased as count_distinct_countries.
SELECT 
	COUNT(DISTINCT country) AS count_distinct_countries 
FROM films.public.films;

--Return title of films released after year 2000
SELECT title 
FROM films.public.films 
WHERE release_year > 2000;

--Select the film_id and imdb_score from the reviews table 
--and filter on scores higher than 7.0.
SELECT film_id, imdb_score 
FROM films.public.reviews 
WHERE imdb_score > 7.0; 

--Select the film_id and facebook_likes of the first ten records
--with less than 1000 likes from the reviews table.
SELECT film_id, facebook_likes 
FROM films.public.reviews 
WHERE facebook_likes < 1000 LIMIT 10;

--Count how many records have a num_votes of at least 100,000;
--use the alias films_over_100K_votes.
SELECT COUNT(*) AS films_over_100K_votes 
FROM films.public.reviews 
WHERE num_votes >= 100000;

--
	-- Select and count the language field using the alias count_spanish.
	-- Apply a filter to select only Spanish from the language field.
SELECT COUNT(language) AS count_spanish 
FROM films.public.films 
WHERE language = 'Spanish';

--Select the title and release_year for all German-language 
--films released before 2000.
SELECT title, release_year 
FROM films.public.films 
WHERE language = 'German' 
	AND release_year < 2000;

--Update the query from the previous step to show 
--German-language films released after 2000 rather than before.
SELECT title, release_year 
FROM films.public.films 
WHERE release_year > 2000 
	AND language = 'German';

--Select all details for German-language films 
--released after 2000 but before 2010 using only WHERE and AND.
SELECT * FROM films.public.films 
WHERE (release_year > 2000 AND release_year < 2010) 
	AND language = 'German' ;

--Select the title and release_year for films released 
--in 1990 or 1999 using only WHERE and OR.
SELECT title, release_year 
FROM films.public.films 
WHERE release_year = 1990 
	OR release_year = 1999 ;

--Filter the above records to only include 
--English or Spanish-language films.
SELECT title, release_year 
FROM films.public.films 
WHERE (release_year = 1990 OR release_year = 1999) 
	AND (language = 'English' OR language = 'Spanish');

--Finally, restrict the query to only return films 
--worth more than $2,000,000 gross.
SELECT title, release_year 
FROM films.public.films 
WHERE (release_year = 1990 OR release_year = 1999) 
	AND (language = 'English' OR language = 'Spanish') 
	AND gross > 2000000;

--Select the title and release_year of all films 
--released between 1990 and 2000 (inclusive) using BETWEEN.
SELECT title, release_year 
FROM films.public.films 
WHERE release_year BETWEEN 1990 AND 2000;

--Build on your previous query to select only films 
--with a budget over $100 million.
SELECT title, release_year 
FROM films.public.films 
WHERE release_year BETWEEN 1990 AND 2000 
	AND budget > 100000000;

--Now, restrict the query to only return Spanish-language films.
SELECT title, release_year 
FROM films.public.films 
WHERE release_year BETWEEN 1990 AND 2000
	AND budget > 100000000 
	AND language = 'Spanish';

--Finally, amend the query to include all Spanish-language
--or French-language films with the same criteria.
SELECT title, release_year 
FROM films.public.films 
WHERE release_year BETWEEN 1990 AND 2000 
	AND budget > 100000000 
	AND (language = 'Spanish' OR language = 'French');

--Select the names of all people whose names begin with 'B'.
SELECT name 
FROM films.public.people 
WHERE name like 'B%' ;

--Select the names of people whose names have 
--'r' as the second letter.
SELECT name 
FROM films.public.people 
WHERE name like '_r%' ;

--Select the names of people whose
--names don't start with 'A'.
SELECT name 
FROM films.public.people 
WHERE name not like 'A%' ;

--Select the title and release_year of all films 
--released in 1990 or 2000 that were longer than two hours.
SELECT title, release_year 
FROM films.public.films 
WHERE release_year IN (1990, 2000) 
	AND duration > 120 ;

--Select the title and language of all films 
--in English, Spanish, or French using IN.
SELECT title, language FROM 
films.public.films 
WHERE language in ('English', 'Spanish', 'French') ;

--Select the title, certification and language of all films 
--certified NC-17 or R that are in English, Italian, or Greek.
SELECT title, certification, language 
FROM films.public.films 
WHERE certification IN ('NC-17', 'R') 
	AND language IN ('English', 'Italian', 'Greek') ;

--
	-- Count the unique titles from the films 
		--database and use the alias provided.
	-- Filter to include only movies with a release_year 
		--from 1990 to 1999, inclusive.
	-- Add another filter narrowing your query down to 
		--English-language films.
	-- Add a final filter to select only films with 
		--'G', 'PG', 'PG-13' certifications.
SELECT COUNT(DISTINCT title) AS nineties_english_films_for_teens
FROM films.public.films
WHERE release_year BETWEEN 1990 AND 1999
	AND language = 'English'
	AND certification IN ('G', 'PG', 'PG-13');
	
--Select the title of every film that doesn't have a 
--budget associated with it and use the alias no_budget_info.
SELECT title AS no_budget_info 
FROM films.public.films 
WHERE budget IS NULL ;

--Count the number of films with a language associated 
--with them and use the alias count_language_known.
SELECT COUNT(language) AS count_language_known 
FROM films.public.films;

--Use the SUM() function to calculate the total duration
--of all films and alias with total_duration.
SELECT SUM(duration) AS total_duration 
FROM films.public.films;

--Calculate the average duration of all films
--and alias with average_duration.
SELECT AVG(duration) AS average_duration 
FROM films.public.films;

--Find the most recent release_year in the films table,
--aliasing as latest_year.
SELECT MAX(release_year) AS latest_year 
FROM films.public.films;

--Find the duration of the shortest film 
--and use the alias shortest_film.
SELECT MIN(duration) AS shortest_film 
FROM films.public.films;

--Use SUM() to calculate the total gross for all films 
--made in the year 2000 or later, and use the alias total_gross.
SELECT SUM(gross) AS total_gross 
FROM films.public.films 
WHERE release_year >= 2000;

--Calculate the average amount grossed by all films 
--whose titles start with the letter 'A' and alias with avg_gross_A.
SELECT AVG(gross) avg_gross_A 
FROM films.public.films 
WHERE title LIKE ('A%');

--Calculate the lowest gross film in 
--1994 and use the alias lowest_gross.
SELECT MIN(gross) AS lowest_gross 
FROM films.public.films 
WHERE release_year = 1994;

--Calculate the highest gross film between 2000 and 2012,
--inclusive, and use the alias highest_gross.
SELECT MAX(gross) AS highest_gross 
FROM films.public.films 
WHERE release_year BETWEEN 2000 AND 2012;

--Calculate the average facebook_likes to one decimal
--place and assign to the alias, avg_facebook_likes.
SELECT 
	ROUND(CAST(AVG(facebook_likes) AS NUMERIC),1) AS avg_facebook_likes 
FROM films.public.reviews;

--Calculate the average budget from the films table, 
--aliased as avg_budget_thousands, and round to the nearest thousand.
SELECT 
	ROUND(CAST(AVG(budget) AS NUMERIC), -3) AS avg_budget_thousands 
FROM films.public.films;

--Select the title and duration in hours for all films 
--and alias as duration_hours; since the current durations are in minutes,
--you'll need to divide duration by 60.0.
SELECT title, (duration/60.0) AS duration_hours 
FROM films.public.films;

--Calculate the percentage of people who are no longer alive
--and alias the result as percentage_dead.
SELECT 
	COUNT(deathdate) * 100.0 / COUNT(*) AS percentage_dead 
FROM films.public.people;

--Find how many decades (period of ten years) the films 
--table covers by using MIN() and MAX(); alias as number_of_decades.
SELECT 
	(MAX(release_year) - MIN(release_year)) / 10.0 AS number_of_decades 
FROM films.public.films;

--Select the name of each person in the people table,
--sorted alphabetically.
SELECT name 
FROM films.public.people 
ORDER BY name;

--Select the title and duration for every film,
--from longest duration to shortest.
SELECT title, duration 
FROM films.public.films 
ORDER BY duration DESC;

--Select the release_year, duration, and title of films
--ordered by their release year and duration, in that order.
SELECT release_year, duration, title 
FROM films.public.films 
ORDER BY release_year, duration;

--Select the certification, release_year, and title from films
--ordered first by certification (alphabetically) 
--and second by release year, starting with the most recent year.
SELECT certification, release_year, title 
FROM films.public.films 
ORDER BY certification ASC, release_year DESC ;

--Select the release_year and count of films released
--in each year aliased as film_count.
SELECT release_year, COUNT(title) AS film_count 
FROM films.public.films 
GROUP BY release_year;

--Select the release_year and average duration aliased as avg_duration
--of all films, grouped by release_year.
SELECT release_year, AVG(duration) AS avg_duration 
FROM films.public.films 
GROUP BY release_year;

--Select the release_year, country, and the maximum budget
--aliased as max_budget for each year and each country;
--sort your results by release_year and country.
SELECT release_year, country, MAX(budget) AS max_budget 
FROM films.public.films 
GROUP BY release_year, country 
ORDER BY release_year, country;

--Which release_year had the most language diversity?
SELECT release_year, COUNT(language) AS count_language 
FROM films.public.films 
GROUP BY release_year 
ORDER BY count_language DESC;

--
	-- Select country from the films table, and get the distinct count
		--of certification aliased as certification_count.
	-- Group the results by country.
	-- Filter the unique count of certifications to only results greater than 10.
SELECT 
	country, 
	COUNT(DISTINCT certification) AS certification_count 
FROM films.public.films 
GROUP BY country 
HAVING COUNT(DISTINCT certification) > 10 ;

--
	-- Select the country and the average budget as average_budget,
		--rounded to two decimal, from films.public.films.
	-- Group the results by country.
	-- Filter the results to countries with an average budget
		--of more than one billion (1000000000).
	-- Sort by descending order of the average_budget.
SELECT country, ROUND(CAST(AVG(budget) AS NUMERIC),2) AS average_budget 
FROM films.public.films 
GROUP BY country 
HAVING ROUND(CAST(AVG(budget) AS NUMERIC),2) > 1000000000 
ORDER BY average_budget ;

--Select the release_year for each film in the films table, 
--filter for records released after 1990, and group by release_year.
SELECT release_year 
FROM films.public.films 
WHERE release_year > 1990 
GROUP BY release_year;

--List the release_year, average budget as avg_budget and
--average gross as avg_gross for the years greater than 1990.
SELECT 
	release_year, 
	AVG(budget) AS avg_budget, 
	AVG(gross) AS avg_gross 
FROM films.public.films 
WHERE release_year > 1990 
GROUP BY release_year;

--List the release_year, average budget as avg_budget and
--average gross as avg_gross for the years greater than 1990
--and average budget more than 60 million.
SELECT 
	release_year, 
	AVG(budget) AS avg_budget, 
	AVG(gross) AS avg_gross 
FROM films.public.films 
WHERE release_year > 1990 
GROUP BY release_year 
HAVING AVG(budget) > 60000000;

--List the release_year, average budget as avg_budget and 
--average gross as avg_gross for the years greater than 1990 
--and average budget more than 60 million and finally order 
--the results from highest to lowest average gross and limit to one.
SELECT 
	release_year, 
	AVG(budget) AS avg_budget, 
	AVG(gross) AS avg_gross 
FROM films.public.films 
WHERE release_year > 1990 
GROUP BY release_year 
HAVING AVG(budget) > 60000000 
ORDER BY AVG(gross) DESC LIMIT 1;