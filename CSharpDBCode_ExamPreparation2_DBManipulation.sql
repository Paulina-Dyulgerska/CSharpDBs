--Databases MSSQL Server Exam - 20 Oct 2019
--Exam Select

INSERT INTO Employees (FirstName,LastName,Birthdate,DepartmentId)
VALUES
('Marlo','O''Malley','1958-9-21','1'),
('Niki','Stanaghan','1969-11-26','4'),
('Ayrton','Senna','1960-03-21','9'),
('Ronnie','Peterson','1944-02-14','9'),
('Giovanna','Amati','1959-07-20','5')

INSERT INTO Reports(CategoryId,StatusId,OpenDate,CloseDate,[Description],UserId,EmployeeId)
VALUES
(1,1,'2017-04-13', NULL,'Stuck Road on Str.133',6,2), --da vminawam ako ima prazna cell v word-a, trqbwa da dam NULL v dannite si!!!
(6,3,'2015-09-05','2015-12-06','Charity trail running',3,5),
(14,2,'2015-09-07', NULL, 'Falling bricks on Str.58',5,2),
(4,3,'2017-07-03','2017-07-06','Cut off streetlight on Str.11',1,1)

--Ako ne iska da insertne i mi kazwa 
--Explicit value must be specified for identity column in table 'Reports'
--trqbwa da proverq dali e OFF identityto j i ako ne e OFF, da go naprawq na OFF!!! Zashtoto po-nagore mi e napraveno da e ON i zatowa
--mi dawa takawa greshka. Tq se opravq taka:
--SET IDENTITY_INSERT [dbo].Reports OFF; -- tova razreshava obratno avtomatichno da se popylwa Id-tata po reda im.
--ako IDENTITY_INSERT ako e na ON --moga az da vkarwam nomerata na Id colonata. Ama az obiknoveno ne iskam da go prawq towa, mnogo
--rqdko se prawi towa.


UPDATE Reports SET CloseDate = GETDATE() WHERE CloseDate IS NULL

DELETE FROM Reports WHERE StatusId = 4

--Problem 5:
SELECT 
[Description],
FORMAT(OpenDate, 'dd-MM-yyyy') AS OpenDate --tozi format pravi taka, che ORDER BY ne mi raboti, zashtoto tazi
--function vryshta string i toj se podrejda po dd, a ne po year posle mm i nakraq dd!!!T.e. ne e kakto ochakwam da se
--sortira po data. Towa se opravq kato sortiram po originalnata OpenDate!!! Towa stawa
--kato izbera Reports.OpenDate ASC i gotowo.
--CONVERT razchita na lokalnite nastrojki na mashinata, zatowa e po-dobre da izbiram FORMAT za da opravq formata i toj da
--e kakyvto iskam tochno az. FORMAT dawa poveche vyzmojnosti ot CONVERT.
FROM Reports 
WHERE EmployeeId IS NULL
ORDER BY Reports.OpenDate ASC, Description ASC

--Problem 6:
SELECT 
[Description],
c.Name AS CategoryName
FROM Reports AS r
JOIN Categories AS c ON r.CategoryId = c.Id
--WHERE CategoryId IS NOT NULL --tova e izlishno, zashtoto JOIN-a mi e INNER tuk
ORDER BY [Description] ASC, CategoryName ASC

--Problem 7.	Most Reported Category
Select the top 5 most reported categories and order them by the number of reports per 
category in descending order and then alphabetically by name.

SELECT TOP(5)
[Name] AS CategoryName,
COUNT(*) AS ReportsNumber
FROM Reports AS r
JOIN Categories AS c ON r.CategoryId = c.Id
GROUP BY CategoryId, Name
ORDER BY ReportsNumber DESC, CategoryName ASC

--moje i taka - no towa e po-glupava i po-bavna zaqwka, zashtoto ima 2 selecta, a gornata e po-pravilna i po-byrza, zashtoto ima
--1 select!!!!! Vlojenite zaqwki spestqwat JOIN i GROUP BY, no towa ne znachi, che sa po-byrzi ili po-pravilni!!!
SELECT TOP(5)
[Name] AS CategoryName,
(SELECT COUNT(*) FROM Reports WHERE CategoryId = c.Id) AS ReportsNumber --mnogo hitro!!!!
FROM Categories AS c 
ORDER BY ReportsNumber DESC, CategoryName ASC


--Problem 8.	Birthday Report
--Select the user's username and category name in all reports in which users have submitted a report on their birthday.
--Order them by username (ascending) and then by category name (ascending).

SELECT 
u.Username AS Username,
c.Name AS CategoryName
FROM Reports AS r
JOIN Users AS u ON r.UserId = u.Id
JOIN Categories AS c ON c.Id = r.CategoryId
--WHERE (MONTH(r.OpenDate) = MONTH(u.Birthdate) AND DAY(r.OpenDate) = DAY(u.Birthdate))
--WHERE (DATEPART(day, r.OpenDate) = DATEPART(day, u.Birthdate)) AND (DATEPART(month, r.OpenDate) = DATEPART(month, u.Birthdate))
WHERE FORMAT(r.OpenDate, 'dd-MM') = FORMAT(u.Birthdate, 'dd-MM') 
ORDER BY u.Username ASC, c.Name ASC


--Problem 9. Users per Employee 
--Select all employees and show how many unique users each of them has served to.
--Order by users count  (descending) and then by full name (ascending).

SELECT 
e.FirstName + ' ' + e.LastName AS FullName
--,e.Id
--,c.Id
,ISNULL(c.UsersCount, 0)
FROM Employees AS e 
LEFT JOIN (SELECT 
				e.Id
				,COUNT(*) AS UsersCount
			FROM Reports AS r
			JOIN Employees AS e ON r.EmployeeId = e.Id
			GROUP BY e.Id
			) AS c ON e.Id = c.Id
ORDER BY c.UsersCount DESC, FullName ASC

--moje i taka:
SELECT 
e.FirstName + ' ' + e.LastName AS FullName
,ISNULL(c.UsersCount, 0)
FROM Employees AS e 
LEFT JOIN (SELECT 
				r.EmployeeId
				,COUNT(DISTINCT UserId) AS UsersCount
			FROM Reports AS r
			GROUP BY r.EmployeeId
			) AS c ON e.Id = c.EmployeeId
ORDER BY c.UsersCount DESC, FullName ASC


--moje i taka:
SELECT 
e.FirstName + ' ' + e.LastName AS FullName
,(SELECT COUNT(DISTINCT UserId) FROM Reports WHERE EmployeeId = e.Id) AS UsersCount
----COUNT mi broi kolko razlichni UserIds imam v kutijkata na vseki edin Employee!!!!
FROM Employees AS e 
ORDER BY UsersCount DESC, FullName ASC

SELECT 
e.FirstName + ' ' + e.LastName AS FullName
,COUNT(DISTINCT UserId) AS UsersCount --COUNT mi broi kolko razlichni UserIds imam v kutijkata na vseki edin Employee!!!!
FROM Reports AS r
RIGHT JOIN Employees AS e ON r.EmployeeId = e.Id
GROUP BY e.Id, e.FirstName, e.LastName
ORDER BY UsersCount DESC, FullName ASC


--Problem 10.	Full Info
--Select all info for reports along with employee first name and last name (concataned with space), department name, 
--category name, report description, open date, status label and name of the user. Order them by first name (descending), 
--last name (descending), department (ascending), category (ascending), description (ascending), open date (ascending), 
--status (ascending) and user (ascending).
--Date should be in format - dd.MM.yyyy
--If there are empty records, replace them with 'None'.
SELECT
ISNULL(e.FirstName + ' ' + e.LastName, 'None') AS FullName,
ISNULL(d.[Name], 'None') AS DepartmentName,
ISNULL(c.[Name], 'None') AS CategoryName,
ISNULL(r.[Description], 'None') AS [Discription],
FORMAT(r.OpenDate, 'dd.MM.yyyy') AS OpenDate,
ISNULL(s.[Label], 'None') AS StatusLabel,
ISNULL(u.[Name], 'None') AS [NameOfUser]
FROM Reports AS r
LEFT JOIN Employees AS e ON r.EmployeeId = e.Id
LEFT JOIN Departments AS d ON e.DepartmentId = d.Id
LEFT JOIN Categories AS c ON r.CategoryId = c.Id
LEFT JOIN Status AS s ON r.StatusId = s.Id
LEFT JOIN Users AS u ON u.Id = r.UserId
ORDER BY 
e.FirstName DESC, 
e.LastName DESC,
DepartmentName ASC, 
CategoryName ASC, 
[Description] ASC,
OpenDate ASC, 
StatusLabel ASC, 
NameOfUser ASC

ISNULL(s.[Label], 'None') AS StatusLabel --moje da se napishe i taka kato proverka:
IFF(s.[Label] IS NULL, 'None', s.[Label]) AS StatusLabel --tova e IF function, kojto proverrqwa dali e vqren 1 parameter
--i ako e veren vryshta 2-riq parameter, a ako ne e veren vryshta 3-tiq parameter.


----Problem 11.	Hours to Complete
--Create a user defined function with the name udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME) that 
--receives a start date and end date and must returns the total hours which has been taken for this task. 
--If start date is null or end is null return 0.

CREATE OR ALTER FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS int
AS 
BEGIN
	IF (@StartDate IS NULL OR @EndDate IS NULL)
		RETURN 0;
	RETURN DATEDIFF(hour, @StartDate, @EndDate);
END

SELECT dbo.udf_HoursToComplete('2020-06-18', '2020-06-29')

SELECT dbo.udf_HoursToComplete(OpenDate, CloseDate) AS TotalHours FROM Reports

GO
----Problem 12.	Assign Employee
--Create a stored procedure with the name usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT) 
--that receives an employee's Id and a report's Id and assigns the employee to the report only if
--the department of the employee and the department of the report's category are the same. Otherwise
--throw an exception with message: "Employee doesn't belong to the appropriate department!". 

CREATE OR ALTER PROCEDURE usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
AS
BEGIN TRANSACTION
DECLARE @CategoryDepartment int = (SELECT
									c.DepartmentId
									FROM Reports AS r
									JOIN Categories AS c ON r.CategoryId = c.Id
									WHERE r.Id = @ReportId)
DECLARE @EmployeeDepartment int = (SELECT DepartmentId FROM Employees WHERE Id = @EmployeeId)

	IF (@CategoryDepartment != @EmployeeDepartment)
	BEGIN
		ROLLBACK;
		THROW 50001, 'Employee doesn''t belong to the appropriate department!', 1;
	END
	UPDATE Reports SET Reports.EmployeeId = @EmployeeId WHERE Id = @ReportId
COMMIT

EXEC usp_AssignEmployeeToReport 30, 1

EXEC usp_AssignEmployeeToReport 17, 2