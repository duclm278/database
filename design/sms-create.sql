CREATE SCHEMA IF NOT EXISTS sms;

CREATE TABLE sms.faculty (
	name varchar(35) NOT NULL,
	location varchar(10),
	CONSTRAINT pk_faculty PRIMARY KEY (name)
);

CREATE TABLE sms.lecturer (
	id char(12) NOT NULL,
	first_name varchar(35),
	last_name varchar(35),
	gender char(1),
	birthday date,
	status boolean,
	join_date date,
	address varchar(70),
	email varchar(35),
	phone varchar(12),
	faculty_name varchar(35),
	CONSTRAINT pk_lecturer PRIMARY KEY (id)
);

CREATE TABLE sms.program (
	name varchar(35) NOT NULL,
	credit_price integer,
	faculty_name varchar(35),
	CONSTRAINT pk_program PRIMARY KEY (name)
);

CREATE TABLE sms.student (
	id char(8) NOT NULL,
	first_name varchar(35),
	last_name varchar(35),
	gender char(1),
	birthday date,
	status boolean,
	join_date date,
	address varchar(70),
	email varchar(35),
	phone varchar(12),
	credit_debt integer,
	tutition_debt integer,
	program_name varchar(35),
	CONSTRAINT pk_student PRIMARY KEY (id)
);

CREATE TABLE sms.subject (
	id char(6) NOT NULL,
	name varchar(35),
	study_credit integer,
	tutition_credit integer,
	midterm_weight integer,
	final_weight integer,
	prerequisite char(6),
	faculty_name varchar(35),
	CONSTRAINT pk_subject PRIMARY KEY (id)
);

CREATE TABLE sms.class (
	id char(6) NOT NULL,
	type char(3),
	semester char(5),
	start_time time,
	end_time time,
	study_weeks varchar(35),
	location varchar(10),
	current_cap integer,
	max_cap integer,
	company_id char(6),
	lecturer_id char(12),
	subject_id char(6),
	CONSTRAINT pk_class PRIMARY KEY (id)
);

CREATE TABLE sms.enrollment (
	student_id char(8) NOT NULL,
	class_id char(6) NOT NULL,
	midterm_score integer,
	final_score integer,
	absent_count integer,
	CONSTRAINT pk_enrollment PRIMARY KEY (student_id, class_id)
);

CREATE TABLE sms.specialization (
	lecturer_id char(12) NOT NULL,
	subject_id char(6) NOT NULL,
	CONSTRAINT pk_specialization PRIMARY KEY (lecturer_id, subject_id)
);

ALTER TABLE sms.class
ADD CONSTRAINT fk_class_class FOREIGN KEY (company_id) REFERENCES sms.class(id);

ALTER TABLE sms.class
ADD CONSTRAINT fk_class_subject FOREIGN KEY (subject_id) REFERENCES sms.subject(id);

ALTER TABLE sms.class
ADD CONSTRAINT fk_class_lecturer FOREIGN KEY (lecturer_id) REFERENCES sms.lecturer(id);

ALTER TABLE sms.enrollment
ADD CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id) REFERENCES sms.student(id);

ALTER TABLE sms.enrollment
ADD CONSTRAINT fk_enrollment_class FOREIGN KEY (class_id) REFERENCES sms.class(id);

ALTER TABLE sms.lecturer
ADD CONSTRAINT fk_lecturer_faculty FOREIGN KEY (faculty_name) REFERENCES sms.faculty(name);

ALTER TABLE sms.program
ADD CONSTRAINT fk_program_faculty FOREIGN KEY (faculty_name) REFERENCES sms.faculty(name);

ALTER TABLE sms.specialization
ADD CONSTRAINT fk_specialization_lecturer FOREIGN KEY (lecturer_id) REFERENCES sms.lecturer(id);

ALTER TABLE sms.specialization
ADD CONSTRAINT fk_specialization_subject FOREIGN KEY (subject_id) REFERENCES sms.subject(id);

ALTER TABLE sms.student
ADD CONSTRAINT fk_student_program FOREIGN KEY (program_name) REFERENCES sms.program(name);

ALTER TABLE sms.subject
ADD CONSTRAINT fk_subject_faculty FOREIGN KEY (faculty_name) REFERENCES sms.faculty(name);

ALTER TABLE sms.subject
ADD CONSTRAINT fk_subject_subject FOREIGN KEY (prerequisite) REFERENCES sms.subject(id);
