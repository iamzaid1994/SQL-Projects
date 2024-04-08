-- creating a database to store our tables
CREATE DATABASE films ;

-- creating films table which will be containing 
-- films titles, release year, ratings, budgets and earnings etc.
CREATE TABLE IF NOT EXISTS films.public.films
(
	id INT PRIMARY KEY NOT NULL,
	title VARCHAR,
	release_year FLOAT,
	country VARCHAR,
	duration FLOAT,
	language VARCHAR,
	certification VARCHAR,
	gross FLOAT,
	budget FLOAT
);

-- coying films data from the csv file stored into the computer
COPY films.public.films(id, 
		   title, 
		   release_year, 
		   country, 
		   duration, 
		   language, 
		   certification, 
		   gross, 
		   budget)
FROM 'D:\films.csv' -- path to csv file
DELIMITER ','
CSV;

-- Checking the films table
SELECT * FROM films.public.films;

SELECT 
	COUNT(*) AS total_rows, 
	COUNT(DISTINCT id) AS unique_records 
FROM films.public.films;


-- creating people table, it will be containing
-- data of the people related to films like directors, actors etc.
CREATE TABLE IF NOT EXISTS films.public.people
(
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR,
	birthdate date,
	deathdate date
);

-- coying people data from the csv file stored into the computer
COPY films.public.people(	
	id,
	name,
	birthdate,
	deathdate
)
FROM 'D:\people.csv' -- path to csv file
DELIMITER ','
CSV;

-- Checking the people table
SELECT * FROM films.public.people;

SELECT 
	COUNT(*) AS total_rows, 
	COUNT(DISTINCT id) AS unique_records 
FROM films.public.people;

-- creating reviews table, it will be containing
-- data of the of the critics, ratings, votes and facebook likes of each film.
CREATE TABLE IF NOT EXISTS films.public.reviews
(
	film_id INT,
	num_user FLOAT,
	num_critic FLOAT,
	imdb_score FLOAT,
	num_votes FLOAT,
	facebook_likes FLOAT
);

-- coying reviews data from the csv file stored into the computer
COPY films.public.reviews(	
	film_id,
	num_user,
	num_critic,
	imdb_score,
	num_votes,
	facebook_likes
)
FROM 'D:\reviews.csv' -- path to csv file
DELIMITER ','
CSV;

-- Checking the people table
SELECT * FROM films.public.reviews;

SELECT 
	COUNT(*) AS total_rows, 
	COUNT(DISTINCT film_id) AS unique_records 
FROM films.public.reviews;

-- creating roles table, it will be containing
-- data of the of the roles played by the people for each film
CREATE TABLE IF NOT EXISTS films.public.roles
(
	id INT PRIMARY KEY NOT NULL,
	film_id INT,
	person_id INT,
	role VARCHAR
);

-- coying reviews data from the csv file stored into the computer
COPY films.public.roles(	
	id,
	film_id,
	person_id,
	role
)
FROM 'D:\roles.csv' -- path to csv file
DELIMITER ','
CSV;
films.public.
-- Checking the roles table
SELECT * FROM films.public.roles;

SELECT 
	COUNT(*) AS total_rows, 
	COUNT(DISTINCT id) AS unique_records 
FROM films.public.roles;
