-- Le Minh Duc - 20200164

-- E1.
-- 00. View tables.
SELECT * FROM student;
SELECT * FROM faculty_member;
SELECT * FROM class;
SELECT * FROM enrolled;

-- 01. Create all relations in this database.
-- Pay attention to data types and data sizes.
DROP TABLE IF EXISTS student CASCADE;
CREATE TABLE student (
	snum		INTEGER,
	name		VARCHAR(75),
	major		VARCHAR(75),
	level		VARCHAR(25),
	age			INTEGER,
	PRIMARY KEY (snum),
	CONSTRAINT valid_level CHECK (
		level IN ('undergraduate', 'graduate', 'professional')
	)
);

DROP TABLE IF EXISTS faculty_member CASCADE;
CREATE TABLE faculty_member (
	fid			INTEGER,
	name		VARCHAR(75),
	dept		VARCHAR(75),
	PRIMARY KEY (fid)
);

DROP TABLE IF EXISTS class CASCADE;
CREATE TABLE class (
	name		VARCHAR(75) NOT NULL,
	semester	INTEGER,
	week_day	INTEGER,
	start_time	TIME,
	end_time	TIME,
	room		VARCHAR(25),
	fid			INTEGER,
	PRIMARY KEY (name),
	FOREIGN KEY (fid) REFERENCES faculty_member (fid),
	CONSTRAINT valid_week_day CHECK (week_day in (2, 3, 4, 5, 6, 7))
);

DROP TABLE IF EXISTS enrolled CASCADE;
CREATE TABLE enrolled (
	snum		INTEGER,
	class_name	VARCHAR(75),
	PRIMARY KEY (snum, class_name),
	FOREIGN KEY (snum) REFERENCES student (snum),
	FOREIGN KEY (class_name) REFERENCES class (name)
);

-- 02. Find the students (Snum, Name) of all CS Majors (Major = "CS") who are
-- enrolled in the course "IT3292E Database 20221".
SELECT s.snum, s.name
FROM student AS s
WHERE s.major = 'CS'
AND s.snum IN (
	SELECT e.snum
	FROM enrolled AS e
	WHERE e.class_name = 'IT3292E Database 20221'
);

SELECT s.snum, s.name
FROM student AS s
JOIN enrolled AS e ON e.snum = s.snum
WHERE s.major = 'CS' AND e.class_name = 'IT3292E Database 20221';

-- 03. Find the students (Snum, Name) of all classes that either meet in room
-- D9-205 or are taught by "Prof. Nguyen" working in “Computer Science”
-- Department.
SELECT s.snum, s.name
FROM student AS s
WHERE s.snum IN (
	SELECT e.snum
	FROM enrolled AS e
	WHERE e.class_name IN (
		SELECT c.name
		FROM class AS c
		WHERE c.room = 'D9-205'
		OR c.fid IN (
			SELECT fm.fid
			FROM faculty_member AS fm
			WHERE fm.name = 'Prof. Nguyen'
			AND fm.dept = 'Computer Science'
		)
	)
);

SELECT DISTINCT s.snum, s.name
FROM student AS s
JOIN enrolled AS e ON e.snum = s.snum
JOIN class AS c ON c.name = e.class_name
JOIN faculty_member AS fm ON fm.fid = c.fid
WHERE c.room = 'D9-205'
OR (fm.name = 'Prof. Nguyen' AND fm.dept = 'Computer Science');

-- 04. Find the (Snum, Name) of all pairs of students who are enrolled in some
-- class together.
SELECT DISTINCT s1.snum, s1.name, s2.snum, s2.name
FROM enrolled AS e1
JOIN enrolled AS e2 ON e1.class_name = e2.class_name
JOIN student AS s1 ON s1.snum = e1.snum
JOIN student AS s2 ON s2.snum = e2.snum
WHERE e1.snum < e2.snum;

-- 05. Find the students (Snum, Name), who are enrolled in two classes that meet
-- at the same time, and names of these two classes.
SELECT DISTINCT s.snum, s.name, c1.name, c2.name
FROM class AS c1
JOIN class AS c2
	ON c1.week_day = c2.week_day
	AND c1.semester = c2.semester
	AND c2.start_time <= c1.start_time
	AND c1.start_time <= c2.end_time
JOIN enrolled AS e1 ON e1.class_name = c1.name
JOIN enrolled AS e2 ON e2.class_name = c2.name
JOIN student AS s ON s.snum = e1.snum
WHERE c1.name != c2.name
AND e1.snum = e2.snum;

-- 06. Find the faculty members (fid, name) who teach every weekday in the
-- semester 20221.
SELECT DISTINCT fm.fid, fm.name
FROM faculty_member AS fm
WHERE fm.fid IN (
	SELECT c.fid
	FROM class AS c
	WHERE c.semester = 20221
	GROUP BY c.fid
	HAVING COUNT(DISTINCT c.week_day) = 6
);

SELECT DISTINCT fm.fid, fm.name
FROM faculty_member AS fm
JOIN class AS c ON c.fid = fm.fid
WHERE c.semester = 20221 
GROUP BY fm.fid
HAVING COUNT(DISTINCT c.week_day) = 6;

-- 07. Print the Level and the average age of students for that Level.
SELECT DISTINCT s.level, AVG(s.age) AS average_age
FROM student AS s
GROUP BY s.level;

-- 08. Find the faculty members (fid, name), who teach more than 4 classes per
-- semester, and the number of classes they teach in each of these semesters.
SELECT DISTINCT fm.fid, fm.name, COUNT(c.name) AS classes
FROM faculty_member AS fm
JOIN class AS c ON c.fid = fm.fid
GROUP BY fm.fid, fm.name, c.semester
HAVING COUNT(c.name) > 4;

-- 09. Find the students with the least number of classes enrolled.
WITH student_classes AS (
	SELECT s.snum, s.name, COUNT(e.class_name) AS classes
	FROM student AS s
	LEFT JOIN enrolled AS e ON e.snum = s.snum
	GROUP BY s.snum, s.name
)
SELECT DISTINCT sc.snum, sc.name
FROM student_classes AS sc
WHERE sc.classes = (SELECT MIN(classes) FROM student_classes);

-- 10. Find the names of all students who are not enrolled in any class taught
-- by professors from department “Computer Science”.
SELECT DISTINCT s.name
FROM student AS s
WHERE s.snum NOT IN (
	SELECT e.snum
	FROM enrolled AS e
	WHERE e.class_name IN (
		SELECT c.name
		FROM class AS c
		WHERE c.fid IN (
			SELECT fm.fid
			FROM faculty_member AS fm
			WHERE fm.dept = 'Computer Science'
		)
	)
);

SELECT DISTINCT s.snum, s.name
FROM student AS s
EXCEPT
SELECT DISTINCT s.snum, s.name
FROM student AS s
JOIN enrolled AS e ON e.snum = s.snum
JOIN class AS c ON c.name = e.class_name
JOIN faculty_member AS fm ON fm.fid = c.fid
WHERE fm.dept = 'Computer Science';
