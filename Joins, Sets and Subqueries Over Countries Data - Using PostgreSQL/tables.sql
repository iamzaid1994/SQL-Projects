CREATE DATABASE countries;

CREATE TABLE cities (
  name                    VARCHAR   PRIMARY KEY,
  country_code            VARCHAR,
  city_proper_pop         REAL,
  metroarea_pop           REAL,
  urbanarea_pop           REAL
);

CREATE TABLE countries (
  code                  VARCHAR     PRIMARY KEY,
  name                  VARCHAR,
  continent             VARCHAR,
  region                VARCHAR,
  surface_area          REAL,
  indep_year            INTEGER,
  local_name            VARCHAR,
  gov_form              VARCHAR,
  capital               VARCHAR,
  cap_long              REAL,
  cap_lat               REAL
);

CREATE TABLE languages (
  lang_id               INTEGER     PRIMARY KEY,
  code                  VARCHAR,
  name                  VARCHAR,
  percent               REAL,
  official              BOOLEAN
);

CREATE TABLE economies (
  econ_id               INTEGER     PRIMARY KEY,
  code                  VARCHAR,
  year                  INTEGER,
  income_group          VARCHAR,
  gdp_percapita         REAL,
  gross_savings         REAL,
  inflation_rate        REAL,
  total_investment      REAL,
  unemployment_rate     REAL,
  exports               REAL,
  imports               REAL
);

CREATE TABLE currencies (
  curr_id               INTEGER     PRIMARY KEY,
  code                  VARCHAR,
  basic_unit            VARCHAR,
  curr_code             VARCHAR,
  frac_unit             VARCHAR,
  frac_perbasic         REAL
);

CREATE TABLE populations (
  pop_id                INTEGER     PRIMARY KEY,
  country_code          VARCHAR,
  year                  INTEGER,
  fertility_rate        REAL,
  life_expectancy       REAL,
  size                  REAL
);

CREATE TABLE economies2015 (
  code                  VARCHAR     PRIMARY KEY,
  year                  INTEGER,
  income_group          VARCHAR,
  gross_savings         REAL
);

CREATE TABLE economies2019 (
  code                  VARCHAR     PRIMARY KEY,
  year                  INTEGER,
  income_group          VARCHAR,
  gross_savings         REAL
);


CREATE TABLE eu_countries (
  code                  VARCHAR     PRIMARY KEY,
  name                  VARCHAR
);

-- Copy over data from CSVs
COPY cities FROM 
	'D:\cities.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM cities;
SELECT COUNT(*) FROM cities;

COPY economies FROM 
	'D:\economies.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM economies;
SELECT COUNT(*) FROM economies;

COPY currencies FROM 
	'D:\currencies.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM currencies;
SELECT COUNT(*) FROM currencies;

COPY countries FROM 
	'D:\countries.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM countries;
SELECT COUNT(*) FROM countries;

COPY languages FROM 
	'D:\languages.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM languages;
SELECT COUNT(*) FROM languages;

COPY populations FROM 
	'D:\populations.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM populations;
SELECT COUNT(*) FROM populations;

COPY eu_countries FROM 
	'D:\eu_countries.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM eu_countries;
SELECT COUNT(*) FROM eu_countries;

COPY economies2015 FROM 
	'D:\economies2015.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM economies2015;
SELECT COUNT(*) FROM economies2015;

COPY economies2019 FROM 
	'D:\economies2019.csv' 
	(DELIMITER ',', FORMAT CSV, HEADER);
SELECT * FROM economies2019;
SELECT COUNT(*) FROM economies2019;

