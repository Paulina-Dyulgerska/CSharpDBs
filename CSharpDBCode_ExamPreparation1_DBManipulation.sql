--Database Basics MSSQL Exam – 17 Feb 2019 - Exam Preparation

--Problem 2: inserts
INSERT INTO Teachers(FirstName,LastName,Address,Phone,SubjectId)
VALUES
('Ruthanne', 'Bamb' ,'84948 Mesta Junction', '3105500146', 6),
('Gerrard', 'Lowin', '370 Talisman Plaza', '3324874824', 2),
('Merrile', 'Lambdin', '81 Dahle Plaza', '4373065154', 5),
('Bert', 'Ivie', '2 Gateway Circle', '4409584510', 4)

INSERT INTO Subjects([Name], Lessons)
VALUES
('Geometry', 12),
('Health', 10),
('Drama', 7),
('Sports', 9)

-- Problem 3. Update
--Make all grades 6.00, where the subject id is 1 or 2, if the grade is above or equal to 5.50

UPDATE StudentsSubjects SET Grade = 6.00 WHERE ((SubjectId = 1 OR SubjectId = 2) AND Grade >=5.50)

SELECT * FROM StudentsSubjects WHERE ((SubjectId = 1 OR SubjectId = 2) AND Grade >=5.50)


--4. Delete
--Delete all teachers, whose phone number contains ‘72’.

SELECT Id FROM Teachers WHERE Phone LIKE '%72%'

SELECT * FROM StudentsTeachers WHERE TeacherId IN (SELECT Id FROM Teachers WHERE Phone LIKE '%72%')


DELETE FROM StudentsTeachers WHERE TeacherId IN (SELECT Id FROM Teachers WHERE Phone LIKE '%72%')

DELETE FROM Teachers WHERE Phone LIKE '%72%'


--Problem 5. Teen Students
--Select all students who are teenagers (their age is above or equal to 12). Order them by first name (alphabetically), 
--then by last name (alphabetically). Select their first name, last name and their age.

SELECT FirstName, LastName, Age FROM Students
WHERE AGE >= 12
ORDER BY FirstName ASC, LastName ASC


--Problem 6. Students Teachers
--Select all students and the count of teachers each one has. 

SELECT s.FirstName, s.LastName, st.TeachersCount 
FROM Students AS s
LEFT JOIN (
SELECT StudentId, COUNT(TeacherId) AS TeachersCount FROM StudentsTeachers GROUP BY StudentId) AS st ON st.StudentId=s.Id
ORDER BY LastName ASC


--Problem 7. Students to Go
--Find all students, who have not attended an exam. Select their full name (first name + last name).
--Order the results by full name (ascending).

SELECT s.FirstName + ' ' + s.LastName AS FullName
FROM Students AS s
LEFT JOIN StudentsExams AS se ON s.Id = se.StudentId
WHERE se.ExamId IS NULL OR se.Grade IS NULL OR se.StudentId IS NULL
ORDER BY FullName ASC


--Problem 8. Top Students
--Find top 10 students, who have highest average grades from the exams.
--Format the grade, two symbols after the decimal point.
--Order them by grade (descending), then by first name (ascending), then by last name (ascending)

--SELECT 
--s.FirstName
--,s.LastName 
--,s.Id
--,(SELECT AVG(Grade) FROM StudentsExams WHERE StudentsExams.StudentId = s.Id) AS Grade
--FROM Students AS s
--LEFT JOIN StudentsExams AS se ON s.Id = se.StudentId
--ORDER BY Grade DESC, FirstName ASC, LastName ASC


SELECT TOP(10) FirstName, LastName, FORMAT(AVG(Grade), 'F2') AS Grade
FROM StudentsExams AS se
JOIN Students AS s ON se.StudentId = s.Id
GROUP BY StudentId, FirstName, LastName
ORDER BY Grade DESC, FirstName ASC, LastName ASC


--Problem 9. Not So In The Studying
--Find all students who don’t have any subjects. Select their full name. The full name is combination of first name, 
--middle name and last name. Order the result by full name
--NOTE: If the middle name is null you have to concatenate the first name and last name separated with single space.

SELECT 
CONCAT(FirstName,' ', (MiddleName + ' '), LastName) AS [Full Name]
FROM Students AS s
LEFT JOIN StudentsSubjects AS ss ON s.Id = ss.StudentId
WHERE ss.SubjectId IS NULL
ORDER BY [Full Name]


--Problem 10. Average Grade per Subject
--Find the average grade for each subject. Select the subject name and the average grade. 
--Sort them by subject id (ascending).


SELECT 
sbj.[Name]
,AVG(ss.Grade)
FROM Subjects AS s
LEFT JOIN StudentsSubjects AS ss ON s.Id = ss.SubjectId
JOIN Subjects AS sbj ON ss.SubjectId = sbj.Id
GROUP BY ss.SubjectId, sbj.[Name]
ORDER BY ss.SubjectId


----Problem 11. Exam Grades
--Create a user defined function, named udf_ExamGradesToUpdate(@studentId, @grade), that receives a student id and grade.
--The function should return the count of grades, for the student with the given id, which are above the received grade 
--and under the received grade with 0.50 added (example: you are given grade 3.50 and you have to find all grades for 
--the provided student which are between 3.50 and 4.00 inclusive):
--If the condition is true, you must return following message in the format:
--•	 “You have to update {count} grades for the student {student first name}”
--If the provided student id is not in the database the function should return “The student with provided id does not 
--exist in the school!”
--If the provided grade is above 6.00 the function should return “Grade cannot be above 6.00!”
--Note: Do not update any records in the database!

GO
CREATE OR ALTER FUNCTION udf_ExamGradesToUpdate (@studentId int, @grade decimal(3,2))
RETURNS nvarchar(MAX)
AS
BEGIN

DECLARE @CountOfGrades int = (SELECT COUNT(*) AS CountGrades
	FROM StudentsExams AS se
	WHERE ((se.Grade >= @grade AND se.Grade <= @grade + 0.50) AND se.StudentId = @studentId));

DECLARE @StudentFirstName nvarchar(50) = (SELECT FirstName
	FROM Students AS s
	WHERE s.Id = @studentId);

	IF (@grade > 6.00)
		RETURN 'Grade cannot be above 6.00!';

	IF (@StudentFirstName IS NULL)
		RETURN 'The student with provided id does not exist in the school!';

	RETURN 'You have to update ' + CAST(@CountOfGrades AS nvarchar(50)) + ' grades for the student ' + @StudentFirstName
END

SELECT dbo.udf_ExamGradesToUpdate(12, 6.20)

SELECT dbo.udf_ExamGradesToUpdate(12, 5.50)

SELECT dbo.udf_ExamGradesToUpdate(121, 5.50)


--Problem 12. Exclude from school
--Create a user defined stored procedure, named usp_ExcludeFromSchool(@StudentId), that receives a student id and attempts
--to delete the current student. A student will only be deleted if all of these conditions pass:
--•	If the student doesn’t exist, then it cannot be deleted. Raise an error with the message 
--“This school has no student with the provided id!”
--If all the above conditions pass, delete the student and ALL OF HIS REFERENCES!
GO
CREATE OR ALTER PROCEDURE usp_ExcludeFromSchool(@StudentId int)
AS 
BEGIN TRANSACTION
	IF ((SELECT s.Id FROM Students s WHERE s.Id = @StudentId) IS NULL)
	BEGIN
		ROLLBACK;
		THROW 50001, 'This school has no student with the provided id!', 1;
	END

	DELETE FROM StudentsExams WHERE StudentId = @StudentId;
	DELETE FROM StudentsSubjects WHERE StudentId = @StudentId;
	DELETE FROM StudentsTeachers WHERE StudentId = @StudentId;
	DELETE FROM Students WHERE Id = @StudentId;

COMMIT

EXEC usp_ExcludeFromSchool 301

EXEC usp_ExcludeFromSchool 1
SELECT COUNT(*) FROM Students
