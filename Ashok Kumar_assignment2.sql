--Task 1
-- Create the database named "SISDB"
CREATE DATABASE SISDB;

--Create Tables

CREATE TABLE Students(student_id int primary key, first_name varchar(20), last_name varchar(20), date_of_birth date not null, email varchar(30), phone_number varchar(30));

CREATE TABLE Courses(course_id int primary key not null, course_name varchar(20), credits int, teacher_id int references Teacher(teacher_id));

CREATE TABLE Enrollments(enrollment_id int primary key not null, student_id int references Students(student_id), course_id int references Courses(course_id), enrollment_date date);

CREATE TABLE Teacher(teacher_id int primary key not null, first_name varchar(20), last_name varchar(20), email varchar(30))

CREATE TABLE Payments(payment_id int primary key not null, student_id int references Students(student_id), amount int, payment_date date);

--Insert values

-- Insert Values into table Students

INSERT INTO Students VALUES
(101, 'Abi', 'Shek', '2002-01-01', 'abishek@gmail.com', '9236299927'),
(102, 'Ajeeth', 'Kumar', '2001-07-06', 'ajeeth@gmail.com', '8239973472'),
(103, 'Ashok', 'Kumar', '2003-07-07', 'ashok@gmail.com', '7293823734'),
(104, 'Aswin', 'Siva', '2002-09-09', 'aswin@gmail.com', '8239834873'),
(105, 'Barath', 'Kumar', '2003-01-08', 'barath@gmail.com', '9283723872'),
(106, 'Krithik', 'Raja', '2003-02-01', 'kirthik@gmail.com', '7239823727'),
(107, 'Ram', 'Kishore', '2003-02-02', 'ram@gmail.com', '8239872637'),
(108, 'Gokul', 'Kumar', '2003-10-09', 'gokul@gmail.com', '9652282376'),
(109, 'Harish', 'Kannan', '2004-04-04', 'harish@gmail.com', '9293734763'),
(110, 'Arun', 'Siva', '2001-09-09', 'arun@gmail.com', '7293723623');

-- Insert Values into table Teacher

INSERT INTO Teacher VALUES
(201, 'John', 'Wilson', 'johnwill@gmail.com'),
(202, 'Jake', 'Paul', 'jakePaul@gmail.com'),
(203, 'William', 'Anderson', 'william@gmail.com'),
(204, 'John', 'Wick', 'johnwick@gmail.com'),
(205, 'James', 'Anderson', 'james@gmail.com'),
(206, 'Andy', 'Corey', 'corey@gmail.com'),
(207, 'David', 'Miller', 'david@gmail.com'),
(208, 'Deepika', 'Yadav', 'deepika@gmail.com'),
(209, 'Raj', 'Malhotra', 'raj@gmail.com'),
(210, 'Sunita', 'Chopra', 'sunita@gmail.com');

-- Insert Values into table Courses
INSERT INTO Courses VALUES
(1, 'Python', 5, 201),
(2, 'Java', 5, 202),
(3, 'C', 4, 203),
(4, 'C#', 3, 207),
(5, 'C++', 2, 205),
(6, 'SQL', 1, 206),
(7, 'DBMS', 3, 207),
(8, 'OOPS', 4, 208),
(9, 'AIML', 3,209),
(10, 'Web Development', 3, 210);

-- Insert Values into table Enrollments
INSERT INTO Enrollments VALUES
(901, 101, 1, '2024-04-10'),
(902, 102, 2, '2024-01-01'),
(903, 103, 1, '2024-04-10'),
(904,104,2,'2024-04-10'),
(905, 105, 4, '2024-01-01'),
(906, 106, 5, '2024-04-10'),
(907, 107, 5, '2024-03-08'),
(908, 108, 1, '2024-01-01'),
(909, 109, 3, '2024-03-08'),
(910, 110, 2, '2024-04-10');

-- Insert Values into table Payments

INSERT INTO Payments VALUES
(501, 101, 5000, '2024-01-01'),
(502, 102, 80000, '2024-01-01'),
(503, 103, 5000, '2024-01-01'),
(504, 104, 3000, '2024-01-01'),
(505, 105, 1000, '2024-01-01'),
(506, 106, 2000, '2024-01-01'),
(507, 107, 2000, '2024-01-01'),
(508, 108, 5000, '2024-01-01'),
(509, 109, 3000, '2024-01-01'),
(510, 110, 4000, '2024-01-01');
--TASK 2

--1. Write an SQL query to insert a new student into the "Students" table with the following details

INSERT INTO Students values(111,'John','Doe','1995-08-15','john.doe@example.com','1234567890');

--2. Write an SQL query to enroll a student in a course. Choose an existing student and course 
--and insert a record into the "Enrollments" table with the enrollment date.

INSERT INTO Enrollments values(911,111,5,'10-04-2024');

--3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.

UPDATE Teacher set email='corey@gmail.com' WHERE teacher_id=206;

--4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. 
---Select an enrollment record based on the student and course.

DELETE FROM Enrollments WHERE enrollment_id=911;

--5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.

UPDATE Courses SET teacher_id = 207 WHERE course_id = 4;

--6. Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. 
--Be sure to maintain referential integrity.

Delete from Enrollments where student_id=104;
DELETE FROM Enrollments WHERE student_id = 104;

--7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.

UPDATE Payments SET amount = amount*20 WHERE payment_id=502;

-- Task 3

--1. Write an SQL query to calculate the total payments made by a specific student. 
--You will need to join the "Payments" table with the "Students" table based on the student's ID.

SELECT s.student_id, CONCAT(s.first_name,'',s.last_name) AS StudentName,s.email,s.phone_number, SUM(p.amount) AS Total_Payments FROM Payments P JOIN Students s ON p.student_id = s.student_id GROUP BY s.student_id ,s.first_name,s.last_name,s.email,s.phone_number;

--2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. 
--Use a JOIN operation between the "Courses" table and the "Enrollments" table.

SELECT c.course_id, c.course_name , COUNT(e.student_id) AS "Students Enrolled" FROM Courses c JOIN Enrollments e ON c.course_id = e.course_id GROUP BY c.course_id,c.course_name;

--3. Write an SQL query to find the names of students who have not enrolled in any course. 
---Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.

SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS StudentName FROM Students s LEFT JOIN Enrollments e ON s.student_id = e.student_id WHERE e.student_id IS NULL;

--4.  Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. 
-- Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.

SELECT s.first_name, s.last_name, c.course_name FROM Students s JOIN Enrollments e ON s.student_id = e.student_id JOIN Courses c ON e.course_id = c.course_id;

--5. Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

SELECT t.first_name, t.last_name , c.course_name  FROM Teacher t JOIN Courses c ON t.teacher_id = c.teacher_id;

--6. Retrieve a list of students and their enrollment dates for a specific course. 
--You'll need to join the "Students" table with the "Enrollments" and "Courses" tables

SELECT s.first_name, s.last_name, c.course_name, e.enrollment_date FROM Students s JOIN Enrollments e ON s.student_id = e.student_id JOIN Courses c ON e.course_id = c.course_id;

--7. Find the names of students who have not made any payments. 
-- Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.

SELECT s.first_name, s.last_name, s.email,s.phone_number FROM Students s LEFT JOIN Payments p ON s.student_id = p.student_id WHERE p.student_id IS NULL;

--8. Write a query to identify courses that have no enrollments. 
-- You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.

SELECT c.course_id , course_name FROM Courses c LEFT JOIN Enrollments e ON c.course_id = e.course_id WHERE e.enrollment_id IS NULL;

--9. Identify students who are enrolled in more than one course.
 -- Use a self-join on the "Enrollments" table to find students with multiple enrollment records.

Insert into Enrollments values(911,110,3,'2024-04-15')

SELECT e1.student_id, COUNT(e1.course_id) AS num_of_enrollments FROM Enrollments e1 JOIN Enrollments e2 ON e1.student_id = e2.student_id WHERE e1.course_id <> e2.course_id GROUP BY e1.student_id HAVING COUNT(e1.course_id) > 1;

--10. Find teachers who are not assigned to any courses. 
-- Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.

SELECT t.first_name , t.last_name FROM Teacher t LEFT JOIN Courses c ON t.teacher_id = c.teacher_id WHERE c.teacher_id IS NULL;

-- Task 4. Subquery and its type

--1. Write an SQL query to calculate the average number of students enrolled in each course. Use
--aggregate functions and subqueries to achieve this.

SELECT AVG(StudentCount) AS AverageEnrollmentCount FROM (SELECT COUNT(student_id) AS StudentCount  FROM Enrollments GROUP BY  student_id)AS EnrollmentCount;

--2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum
--payment amount and then retrieve the student(s) associated with that amount.

SELECT CONCAT(first_name,' ',last_name) AS StudentName FROM  Students WHERE student_id IN(SELECT student_id FROM Payments WHERE amount= (SELECT MAX(amount) FROM Payments));

--3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the
--course(s) with the maximum enrollment count.

SELECT c.course_name, COUNT(e.enrollment_id) AS HighestEnrollmentCount FROM Courses c JOIN  Enrollments e ON c.course_id = e.course_id GROUP BY c.course_name HAVING COUNT(e.enrollment_id) = (SELECT MAX(enrollment_count) FROM (SELECT COUNT(enrollment_id) AS enrollment_count FROM Enrollments GROUP BY course_id ) AS max_enrollments);

--4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum
--payments for each teacher's courses.

SELECT CONCAT(first_name,' ',last_name) AS TeacherName, (SELECT SUM(amount) FROM Payments p JOIN Enrollments e ON p.student_id = e.student_id JOIN Courses c ON c.course_id = e.course_id WHERE c.teacher_id = t.teacher_id) AS TotalPayments FROM Teacher t ;

--5. Identify students who are enrolled in all available courses. Use subqueries to compare a
--student's enrollments with the total number of courses.

SELECT CONCAT(first_name,' ',last_name) AS StudentName  FROM Students WHERE (SELECT DISTINCT COUNT(course_id) FROM Enrollments) = (SELECT DISTINCT COUNT(course_id) FROM Enrollments WHERE Students.student_id= Enrollments.student_id);

--6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to
-- find teachers with no course assignments.

SELECT CONCAT(first_name,' ',last_name) AS TeacherName FROM Teacher WHERE teacher_id NOT IN(SELECT teacher_id FROM Courses);

--7. Calculate the average age of all students. Use subqueries to calculate the age of each student
--based on their date of birth.

SELECT AVG(Age) AS AverageAge FROM (SELECT DATEDIFF(YEAR, date_of_birth, GETDATE()) AS Age FROM Students) AS StudentAges;

--8. Identify courses with no enrollments. Use subqueries to find courses without enrollment
--records.

SELECT c.course_id, c.course_name FROM Courses c WHERE NOT EXISTS(SELECT 1  FROM Enrollments e WHERE e.course_id=c.course_id) ;

-- 9. Calculate the total payments made by each student for each course they are enrolled in. Use
--subqueries and aggregate functions to sum payments.

SELECT CONCAT(first_name,' ',last_name) AS StudentName, c.course_id, c.course_name AS StudnetName, (SELECT SUM(amount) FROM Payments p WHERE p.student_id = s.student_id  AND e.course_id= c.course_id)  AS TotalPayments FROM Students s JOIN Enrollments e ON s.student_id = e.student_id JOIN Courses c ON c.course_id = e.course_id;

--10. Identify students who have made more than one payment. Use subqueries and aggregate
--functions to count payments per student and filter for those with counts greater than one.

INSERT INTO Payments VALUES(511,103,2000,'2024-12-04')

SELECT CONCAT(first_name,' ',last_name) AS StudentName FROM  Students WHERE student_id IN(SELECT student_id  FROM Payments GROUP BY student_id HAVING COUNT(student_id)>1);

--11. Write an SQL query to calculate the total payments made by each student. Join the "Students"
--table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.

SELECT CONCAT(first_name,' ',last_name) AS StudentName,(SELECT SUM(amount) FROM Payments p WHERE p.student_id = s.student_id) AS StudenetPayments FROM Students s;

--12. Retrieve a list of course names along with the count of students enrolled in each course. Use
--JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.

SELECT  c.course_name , (SELECT COUNT(enrollment_id)  FROM Enrollments WHERE course_id=c.course_id)AS StudentsEnrolled FROM Courses c;

-- 13. Calculate the average payment amount made by students. Use JOIN operations between the
-- "Students" table and the "Payments" table and GROUP BY to calculate the average.
 
SELECT CONCAT(s.first_name,' ',s.last_name) AS StudentName,(SELECT AVG(amount)  FROM Payments p WHERE p.student_id=s.student_id ) AS AvergaeAmount FROM Students s;

