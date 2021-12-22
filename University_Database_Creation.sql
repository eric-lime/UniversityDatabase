/*Creating Tables*/
CREATE TABLE student (
	student_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    major VARCHAR(40),
    gpa DECIMAL(2,1),
    gender VARCHAR(1),
    year INT,
    mentor_id INT,
    advisor_id INT,
    club_id INT,
    FOREIGN KEY(mentor_id) REFERENCES student(student_id) ON DELETE SET NULL
);

CREATE TABLE professor (
	prof_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    salary INT,
    birth_date DATE,
    office_num INT
); 

-- Add foreign key to student(advisor_id) after creating professor table.
ALTER TABLE student
ADD FOREIGN KEY(advisor_id) REFERENCES professor(prof_id) ON DELETE SET NULL;

CREATE TABLE course(
	course_id INT PRIMARY KEY,
    course_name VARCHAR(40),
    aff_major VARCHAR(40), -- affiliated major
    prof_id INT,
    FOREIGN KEY(prof_id) REFERENCES professor(prof_id) ON DELETE CASCADE
);

CREATE TABLE club (
	club_id INT PRIMARY KEY,
    club_name VARCHAR(40),
    manager_id INT,
    FOREIGN KEY(manager_id) REFERENCES professor(prof_id) ON DELETE SET NULL
);

ALTER TABLE student
ADD FOREIGN KEY(club_id) REFERENCES club(club_id) ON DELETE SET NULL;

CREATE TABLE exam (
	course_id INT,
    exam_id INT,
    exam_type VARCHAR(40),
    PRIMARY KEY(course_id, exam_id),
    FOREIGN KEY(course_id) REFERENCES course(course_id)
);

CREATE TABLE course_roster(
	course_id INT,
    student_id INT,
    grade INT,
    PRIMARY KEY(course_id, student_id),
    FOREIGN KEY(course_id) REFERENCES course(course_id) ON DELETE CASCADE,
    FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE
);

/*Inserting Data*/

--Professor
INSERT INTO professor VALUES(201, 'Felix', 'Bowers', 33000, '1987-10-03', 301);
INSERT INTO professor VALUES ('202', 'Gary', 'Oneil', '50000', '1986-12-30', '302');
INSERT INTO professor VALUES ('203', 'Upton', 'Heath', '120000', '1968-06-07', '303');
INSERT INTO professor VALUES ('204', 'Derek', 'Zimmerman', '115000', '1971-03-24', '304');
INSERT INTO professor VALUES ('205', 'Cathleen', 'Horton', '102000', '1972-08-19', '305');
INSERT INTO professor VALUES ('206', 'Gannon', 'Whitfield', '77000', '1980-05-22', '306');
INSERT INTO professor VALUES ('207', 'Neve', 'Avery', '67000', '1984-07-27', '307');
INSERT INTO professor VALUES ('208', 'Steven', 'Weber', '55000', '1985-09-28', '308');
INSERT INTO professor VALUES ('209', 'Ivana', 'Burnett', '48000', '1986-11-06', '309');
INSERT INTO professor VALUES ('210', 'Rina', 'House', '132000', '1965-12-04', '310');
INSERT INTO professor VALUES ('211', 'Griffin', 'Kramer', '84000', '1977-06-23', '311');
INSERT INTO professor VALUES ('212', 'Dara', 'Mcintyre', '92000', '1979-03-15', '312');
INSERT INTO professor VALUES ('213', 'Keelie', 'Jarvis', '66000', '1985-02-17', '313');
INSERT INTO professor VALUES ('214', 'Uriel', 'Hickman', '72000', '1983-10-26', '314');
INSERT INTO professor VALUES ('215', 'Wilma', 'Pollard', '127000', '1967-05-28', '315');
INSERT INTO professor VALUES ('216', 'Vielka', 'ONeill', '108000', '1970-07-07', '316');
INSERT INTO professor VALUES ('217', 'Wade', 'Weeks', '92000', '1972-08-05', '317');
INSERT INTO professor VALUES ('218', 'Hunter', 'Marsh', '63000', '1983-12-16', '318');
INSERT INTO professor VALUES ('219', 'Beatrice', 'Duncan', '54000', '1987-01-14', '319');
INSERT INTO professor VALUES ('220', 'Faith', 'Morin', '91000', '1973-01-27', '320');

-- Club
INSERT INTO club VALUES(1001, 'Sustainability', 204);
INSERT INTO club VALUES(1002, 'Film', 211);
INSERT INTO club VALUES(1003, 'Sport', 202);
INSERT INTO club VALUES(1004, 'Book', 219);
INSERT INTO club VALUES(1005, 'Outdoor', 215);

/* Student Table*/ 
-- Student 1
INSERT INTO student VALUES (1, 'Bevis', 'Foley', 'Biology', 3.2, 'M', 4, NULL, 204, 1002);

-- Student 2 -> mentor
INSERT INTO student VALUES (2, 'Madeline', 'Knapp', 'Chemistry', 3.4, 'F', 3, NULL, 219, 1003);
INSERT INTO student VALUES (32, 'Gannon', 'Eaton', 'Chemistry', 3.3, 'M', 4, NULL, 219, 1003);

UPDATE student 
SET mentor_id = 32
WHERE student_id = 2;

-- Student 3
INSERT INTO student VALUES (3, 'Cameron', 'Weeks', 'Anthropology', 3.1, 'M', 4, NULL, 207, 1001);

-- Student 4
INSERT INTO student VALUES (4, 'Teagan', 'Stephenson', 'Biology', 3.9, 'M', 2, 1, 204, 1004);

-- Student 5 -> mentor -> mentor
INSERT INTO student VALUES (5, 'Cheyenne', 'Haney', 'Computer Science', 3.2, 'F', 4, NULL, 203, 1001); -- 28
INSERT INTO student VALUES (28, 'Isabelle', 'Burt', 'Computer Science', 3.7, 'F', 1, NULL, 203, 1001); -- 14
INSERT INTO student VALUES (14, 'Vance', 'Conway', 'Computer Science', 2.6, 'M', 2, 5, 203, 1003);

UPDATE student
SET mentor_id = 28
WHERE student_id = 5;

UPDATE student
SET mentor_id = 14
WHERE student_id = 28;

-- Student 6
INSERT INTO student VALUES (6, 'Bree', 'Willis', 'Mathematics', 4.0, 'F', 1, NULL, 201, 1005);

-- Student 7
INSERT INTO student VALUES (7, 'Isabella', 'Travis', 'Economics', 2.7, 'F', 4, NULL, 218, 1005);

-- Student 8
INSERT INTO student VALUES (8, 'Keith', 'Huffman', 'Economics', 3.8, 'M', 2, 7, 218, NULL);

-- Student 9
INSERT INTO student VALUES (9, 'Dolan', 'Hodge', 'English', 3.2, 'M', 3, NULL, 210, 1002);
INSERT INTO student VALUES (35, 'Drake', 'Blackwell', 'English', 3.8, 'M', 3, NULL, 210, NULL);

UPDATE student
SET mentor_id = 35
WHERE student_id = 9;

-- Student 10
INSERT INTO student VALUES (10, 'Donna', 'Carroll', 'Physics', 2.8, 'F', 4, 6, 211, 1005);

-- Student 11 -> mentor -> mentor
INSERT INTO student VALUES (11, 'Aidan', 'Dejesus', 'Art', 2.1, 'M', 2, NULL, 213, 1002); -- 23
INSERT INTO student VALUES (23, 'Evan', 'Sosa', 'Art', 4.0, 'M', 2, NULL, 213, 1005); -- 12
INSERT INTO student VALUES (12, 'Wendy', 'Campos', 'Art', 3.5, 'F', 4, NULL, 213, 1002);

UPDATE student
SET mentor_id = 23
WHERE student_id = 11;

UPDATE student
SET mentor_id = 12
WHERE student_id = 23;

-- Student 13
INSERT INTO student VALUES (13, 'Breanna', 'Rose', 'Physics', 3.0, 'F', 3, 6, 220, 1001);

-- Student 15
INSERT INTO student VALUES (15, 'Madeline', 'Wheeler', 'Economics', 3.7, 'F', 2, 7, 218, 1003);

-- Student 16
INSERT INTO student VALUES (16, 'Ursula', 'Espinoza', 'Business', 3.8, 'F', 3, NULL, 209, 1005);

-- Student 17 -> mentor
INSERT INTO student VALUES (17, 'Carson', 'Bryan', 'Psychology', 3.3, 'M', 3, NULL, 205, NULL); -- 18
INSERT INTO student VALUES (18, 'Sylvester', 'Boyer', 'Psychology', 4.0, 'M', 4, NULL, 205, 1004);

UPDATE student 
SET mentor_id = 18
WHERE student_id = 17;

-- Student 19 -> mentor
INSERT INTO student VALUES (19, 'Amos', 'Barker', 'Astronomy', 2.2, 'M', 1, NULL, 215, 1004); -- 38
INSERT INTO student VALUES (38, 'Jameson', 'Hooper', 'Astronomy', 2.9, 'M', 3, NULL, 215, 1005);

UPDATE student
SET mentor_id = 38
WHERE student_id = 19;

-- Student 20
INSERT INTO student VALUES (20, 'Charles', 'Faulkner', 'Business', 3.8, 'M', 1, 16, 209, 1002);

-- Student 21
INSERT INTO student VALUES (21, 'Chaney', 'Strong', 'Mathematics', 3.1, 'F', 1, 6, 201, 1003);

-- Student 22
INSERT INTO student VALUES (22, 'Jamal', 'Harvey', 'Chemistry', 3.0, 'M', 2, 2, 219, 1004);

-- Student 24
INSERT INTO student VALUES (24, 'Orla', 'Pugh', 'French', 3.2, 'F', 3, NULL, 214, NULL);

-- Student 25 -> mentor
INSERT INTO student VALUES (25, 'Dana', 'Fuentes', 'Spanish', 2.6, 'F', 4, NULL, 206, 1001); -- 36
INSERT INTO student VALUES (36, 'Porter', 'Holland', 'Spanish', 4.0, 'M', 4, NULL, 212, 1003);

UPDATE student 
SET mentor_id = 36
WHERE student_id = 25;

-- Student 26
INSERT INTO student VALUES (26, 'Lavinia', 'Rocha', 'English', 2.9, 'F', 1, 9, 210, 1002);

-- Student 27
INSERT INTO student VALUES (27, 'Ignacia', 'Jimenez', 'Biology', 3.4, 'F', 1, 4, 204, 1003);

-- Student 29
INSERT INTO student VALUES (29, 'Olympia', 'Whitaker', 'Psychology', 2.9, 'F', 4, 16, 205, 1005);

-- Student 30
INSERT INTO student VALUES (30, 'John', 'Ballard', 'Economics', 2.2, 'M', 1, 15, 218, 1003);

-- Student 31
INSERT INTO student VALUES (31, 'Cameron', 'Franks', 'Geology', 3.2, 'M', 3, NULL, 217, 1002);

-- Student 33
INSERT INTO student VALUES (33, 'Francesca', 'Pitts', 'Business', 2.8, 'F', 2, 20, 209, 1004);

-- Student 34
INSERT INTO student VALUES (34, 'Aphrodite', 'Cabrera', 'Mathematics', 3.5, 'M', 1, 6, 201, 1005);

-- Student 37
INSERT INTO student VALUES (37, 'Rashad', 'Mcmillan', 'Anthropology', 3.0, 'M', 4, 3, 207, 1001);

-- Student 39
INSERT INTO student VALUES (39, 'Bo', 'Ward', 'Physics', 3.1, 'F', 1, 13, 211, 1002);

-- Student 40
INSERT INTO student VALUES (40, 'Wang', 'Walton', 'Psychology', 3.8, 'F', 2, 17, 205, 1004);

/*Course*/
INSERT INTO course VALUES (101, 'Introduction to Psychology', 'Psychology', 205);
INSERT INTO course VALUES (102, 'Encounters', 'English', 210);
INSERT INTO course VALUES (103, 'Spanish 101', 'Spanish', 206);
INSERT INTO course VALUES (104, 'Computer Fundamentals', 'Computer Science', 203);
INSERT INTO course VALUES (105, 'Calc 1', 'Mathematics', 201);
INSERT INTO course VALUES (106, 'Calc 2', 'Mathematics', 202);
INSERT INTO course VALUES (107, 'Micro-Econ', 'Economics', 218);
INSERT INTO course VALUES (108, 'Macro-Econ', 'Economics', 218);
INSERT INTO course VALUES (109, 'General Chemistry', 'Chemistry', 219);
INSERT INTO course VALUES (110, 'Physics 1', 'Physics', 220);
INSERT INTO course VALUES (111, 'Introduction to Humans', 'Antrhopology', 207);
INSERT INTO course VALUES (112, 'Astronomy 101', 'Astronomy', 208);
INSERT INTO course VALUES (113, 'Physics 2', 'Physics', 211);
INSERT INTO course VALUES (114, 'English Lit', 'English', 210);
INSERT INTO course VALUES (115, 'Painting', 'Art', 213);
INSERT INTO course VALUES (116, 'Drawing', 'Art', 213);
INSERT INTO course VALUES (117, 'Supply Chain 101', 'Business', 209);
INSERT INTO course VALUES (118, 'French 101', 'French', 214);
INSERT INTO course VALUES (119, 'Spanish 102', 'Spanish', 206);
INSERT INTO course VALUES (120, 'Intro to Geo', 'Geology', 217);
INSERT INTO course VALUES (121, 'Biology 101', 'Biology', 204);
INSERT INTO course VALUES (122, 'Web Design', 'Computer Science', 203);
INSERT INTO course VALUES (123, 'Cognitive Psychology', 'Psychology', 205);
INSERT INTO course VALUES (124, 'Spanish 102', 'Spanish', 212);
INSERT INTO course VALUES (125, 'Space and Stars', 'Astronomy', 208);

/* Exam Table*/
INSERT INTO exam VALUES (101, 401, 'Midterm');
INSERT INTO exam VALUES (101, 402, 'Final');
INSERT INTO exam VALUES (102, 403, 'Midterm');
INSERT INTO exam VALUES (102, 404, 'Final');
INSERT INTO exam VALUES (103, 405, 'Midterm');
INSERT INTO exam VALUES (103, 406, 'Final');
INSERT INTO exam VALUES (104, 407, 'Midterm');
INSERT INTO exam VALUES (104, 408, 'Final');
INSERT INTO exam VALUES (105, 409, 'Midterm');
INSERT INTO exam VALUES (105, 410, 'Final');
INSERT INTO exam VALUES (106, 411, 'Midterm');
INSERT INTO exam VALUES (106, 412, 'Final');
INSERT INTO exam VALUES (107, 413, 'Midterm');
INSERT INTO exam VALUES (107, 414, 'Final');
INSERT INTO exam VALUES (108, 415, 'Midterm');
INSERT INTO exam VALUES (108, 416, 'Final');
INSERT INTO exam VALUES (109, 417, 'Midterm');
INSERT INTO exam VALUES (109, 418, 'Final');
INSERT INTO exam VALUES (110, 419, 'Midterm');
INSERT INTO exam VALUES (111, 420, 'Final');
INSERT INTO exam VALUES (112, 421, 'Midterm');
INSERT INTO exam VALUES (113, 422, 'Final');
INSERT INTO exam VALUES (114, 423, 'Midterm');
INSERT INTO exam VALUES (115, 424, 'Final');
INSERT INTO exam VALUES (115, 425, 'Midterm');
INSERT INTO exam VALUES (116, 426, 'Final');
INSERT INTO exam VALUES (116, 427, 'Midterm');
INSERT INTO exam VALUES (117, 428, 'Final');
INSERT INTO exam VALUES (118, 429, 'Midterm');
INSERT INTO exam VALUES (118, 430, 'Final');
INSERT INTO exam VALUES (119, 431, 'Midterm');
INSERT INTO exam VALUES (119, 432, 'Final');
INSERT INTO exam VALUES (120, 433, 'Midterm');
INSERT INTO exam VALUES (120, 434, 'Final');
INSERT INTO exam VALUES (121, 435, 'Midterm');
INSERT INTO exam VALUES (121, 436, 'Final');
INSERT INTO exam VALUES (122, 437, 'Midterm');
INSERT INTO exam VALUES (122, 438, 'Final');
INSERT INTO exam VALUES (123, 439, 'Midterm');
INSERT INTO exam VALUES (123, 440, 'Final');
INSERT INTO exam VALUES (124, 441, 'Midterm');
INSERT INTO exam VALUES (124, 442, 'Final');
INSERT INTO exam VALUES (125, 443, 'Midterm');
INSERT INTO exam VALUES (125, 444, 'Final');

/* Course Roster Table */ 
INSERT INTO course_roster VALUES (101, 17, 92);
INSERT INTO course_roster VALUES (101, 40, 87);
INSERT INTO course_roster VALUES (101, 13, 82);
INSERT INTO course_roster VALUES (102, 25, 93);
INSERT INTO course_roster VALUES (102, 9, 95);
INSERT INTO course_roster VALUES (103, 26, 83);
INSERT INTO course_roster VALUES (103, 24, 73);
INSERT INTO course_roster VALUES (104, 28, 85);
INSERT INTO course_roster VALUES (104, 12, 77);
INSERT INTO course_roster VALUES (104, 6, 87);
INSERT INTO course_roster VALUES (105, 28, 88);
INSERT INTO course_roster VALUES (105, 21, 95);
INSERT INTO course_roster VALUES (106, 6, 69);
INSERT INTO course_roster VALUES (106, 22, 74);
INSERT INTO course_roster VALUES (106, 34, 79);
INSERT INTO course_roster VALUES (107, 7, 81);
INSERT INTO course_roster VALUES (107, 33, 92);
INSERT INTO course_roster VALUES (107, 8, 67);
INSERT INTO course_roster VALUES (108, 8, 84);
INSERT INTO course_roster VALUES (108, 7, 92);
INSERT INTO course_roster VALUES (108, 40, 99);
INSERT INTO course_roster VALUES (109, 4, 90);
INSERT INTO course_roster VALUES (109, 22, 84);
INSERT INTO course_roster VALUES (110, 39, 82);
INSERT INTO course_roster VALUES (110, 21, 87);
INSERT INTO course_roster VALUES (110, 34, 92);
INSERT INTO course_roster VALUES (111, 3, 54);
INSERT INTO course_roster VALUES (111, 37, 69);
INSERT INTO course_roster VALUES (111, 29, 89);
INSERT INTO course_roster VALUES (112, 19, 90);
INSERT INTO course_roster VALUES (112, 31, 91);
INSERT INTO course_roster VALUES (112, 23, 94);
INSERT INTO course_roster VALUES (113, 13, 73);
INSERT INTO course_roster VALUES (113, 22, 79);
INSERT INTO course_roster VALUES (113, 15, 92);
INSERT INTO course_roster VALUES (114, 35, 91);
INSERT INTO course_roster VALUES (114, 9, 84);
INSERT INTO course_roster VALUES (115, 11, 86);
INSERT INTO course_roster VALUES (115, 12, 92);
INSERT INTO course_roster VALUES (115, 23, 56);
INSERT INTO course_roster VALUES (116, 11, 72);
INSERT INTO course_roster VALUES (116, 12, 84);
INSERT INTO course_roster VALUES (117, 16, 88);
INSERT INTO course_roster VALUES (117, 7, 92);
INSERT INTO course_roster VALUES (117, 2, 74);
INSERT INTO course_roster VALUES (117, 17, 70);
INSERT INTO course_roster VALUES (118, 24, 83);
INSERT INTO course_roster VALUES (118, 30, 95);
INSERT INTO course_roster VALUES (118, 40, 82);
INSERT INTO course_roster VALUES (119, 25, 90);
INSERT INTO course_roster VALUES (119, 26, 56);
INSERT INTO course_roster VALUES (119, 14, 84);
INSERT INTO course_roster VALUES (120, 31, 93);
INSERT INTO course_roster VALUES (120, 35, 82);
INSERT INTO course_roster VALUES (120, 37, 73);
INSERT INTO course_roster VALUES (121, 27, 77);
INSERT INTO course_roster VALUES (121, 2, 94);
INSERT INTO course_roster VALUES (121, 22, 91);
INSERT INTO course_roster VALUES (121, 1, 85);
INSERT INTO course_roster VALUES (122, 5, 92);
INSERT INTO course_roster VALUES (122, 14, 98);
INSERT INTO course_roster VALUES (122, 28, 70);
INSERT INTO course_roster VALUES (123, 17, 73);
INSERT INTO course_roster VALUES (123, 18, 94);
INSERT INTO course_roster VALUES (123, 40, 86);
INSERT INTO course_roster VALUES (123, 10, 85);
INSERT INTO course_roster VALUES (123, 19, 93);
INSERT INTO course_roster VALUES (124, 36, 74);
INSERT INTO course_roster VALUES (124, 25, 56);
INSERT INTO course_roster VALUES (124, 10, 92);
INSERT INTO course_roster VALUES (125, 19, 67);
INSERT INTO course_roster VALUES (125, 38, 94);
INSERT INTO course_roster VALUES (125, 34, 85);
INSERT INTO course_roster VALUES (125, 1, 72);
