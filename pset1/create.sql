DROP TABLE IF EXISTS regions CASCADE;
DROP TABLE IF EXISTS countries CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS jobs CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS job_history CASCADE;
DROP TABLE IF EXISTS job_grades CASCADE;

CREATE TABLE regions (
	region_id		SERIAL,
	region_name		VARCHAR(25)
);

CREATE TABLE countries (
	country_id		CHAR(2),
	country_name	VARCHAR(40),
	region_id		INTEGER
);

CREATE TABLE locations (
	location_id		SERIAL,
	street_address	VARCHAR(40),
	postal_code		VARCHAR(12),
	city			VARCHAR(30),
	state_province	VARCHAR(25),
	country_id		CHAR(2)
);

CREATE TABLE departments (
	department_id	SERIAL,
	department_name	VARCHAR(30),
	manager_id		INTEGER,
	location_id		INTEGER
);

CREATE TABLE jobs (
	job_id			VARCHAR(10),
	job_title		VARCHAR(35),
	min_salary		NUMERIC,
	max_salary		NUMERIC
);

CREATE TABLE employees (
	employee_id		SERIAL,
	first_name		VARCHAR(20),
	last_name		VARCHAR(25),
	email			VARCHAR(25),
	phone_number	VARCHAR(20),
	hire_date		DATE,
	job_id			VARCHAR(10),
	salary			NUMERIC,
	commission_pct	NUMERIC,
	manager_id		INTEGER,
	department_id	INTEGER
);

CREATE TABLE job_history (
	employee_id		INTEGER,
	start_date		DATE,
	end_date		DATE,
	job_id			VARCHAR(10),
	department_id	INTEGER
);

CREATE TABLE job_grades (
	grade_level		VARCHAR(2),
	lowest_sal		NUMERIC,
	highest_sal		NUMERIC
);
