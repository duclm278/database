drop table if exists student cascade;
drop table if exists faculty_member cascade;
drop table if exists class cascade;
drop table if exists enrolled cascade;

create table student(
	snum bigint,
	name varchar(30),
	major varchar(25),
	level varchar(2),
	age smallint
	);

create table faculty_member(
	fid bigint,
	name varchar(30),
	dept smallint
	);

create table class(
	name varchar(40),
	start_time varchar(20),
	room varchar(10),
	fid bigint
	);

create table enrolled(
	snum bigint,
	class_name varchar(40)
	);
