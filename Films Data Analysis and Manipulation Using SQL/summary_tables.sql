-- Creating Tables that could be used for analysis
-- Gathering scattered information from different 
	--relevant tables into a single table by using joins
	
SELECT * FROM films.public.films;
SELECT * FROM films.public.people;
SELECT * FROM films.public.roles;
SELECT * FROM films.public.reviews;	

-- create a summarized table as films_summary for films having
	-- title, release_year, 
	-- duration in hours round to 2 decimal places as duration_hours, 
		-- language, certification, gross and budget columns from films table 
	-- number of perosns associated with each film but 
		-- actors and non-actors separatelty
		-- number of actors as num_actors, number of non-actors as num_non_actors
	-- imdb_score, num_votes and facebook_likes from reviews table.

CREATE TABLE IF NOT EXISTS films_summary AS
(SELECT
 	f.id,
	f.title, 
	f.release_year, 
	ROUND(CAST((f.duration/60) AS NUMERIC), 2) AS duration_hours,
	act.num_actors,
	non_act.num_non_actors,
	rev.imdb_score, 
	rev.num_votes,
	rev.facebook_likes
	FROM films AS f
LEFT JOIN
	(SELECT
		film_id,
		COUNT(DISTINCT person_id) as num_actors
		FROM roles
		WHERE role = 'actor'
		GROUP BY film_id) AS act
ON f.id = act.film_id
LEFT JOIN
	(SELECT
		film_id,
		COUNT(DISTINCT person_id) as num_non_actors
		FROM roles
		WHERE role <> 'actor'
		GROUP BY film_id) AS non_act
ON f.id = non_act.film_id
LEFT JOIN
	(SELECT
	 	film_id,
	 	imdb_score, 
	 	num_votes,
	 	facebook_likes 
	 	FROM reviews) AS rev
ON f.id = rev.film_id
	)
;

commit;

-- cross validation of films_summary
SELECT * FROM films_summary;
SELECT COUNT(id), COUNT(*) FROM films_summary;

-- create a summarized table as people_summary
	-- id, name, birthdate, deathdate from people table
	-- number of films as num_films, 
		-- Create 2 separate columns for roles as if_actor and if_non_actor
			-- if the person is actor populate if_actor with 1 else 0
			-- if the person is non-actor populate ifnon__actor with 1 else 0

CREATE TABLE IF NOT EXISTS people_summary AS
(SELECT
	id,
	name,
	birthdate,
	deathdate,
	rol.num_films,
	rol.if_actor,
	rol.if_non_actor
FROM people AS ppl
LEFT JOIN
	(SELECT 
	 	person_id,
		COUNT(film_id) AS num_films,
		CASE
	 		WHEN role = 'actor' THEN 1 
	 		ELSE 0 
	 	END AS if_actor,
		CASE
	 		WHEN role <> 'actor' THEN 1 
	 		ELSE 0 
	 	END AS if_non_actor
	FROM roles
	GROUP BY person_id, if_actor, if_non_actor) AS rol
ON ppl.id = rol.person_id
	)
;
	
commit;

-- cross validation of people_summary
SELECT * FROM people_summary;
SELECT COUNT(id), COUNT(*) FROM people_summary;

