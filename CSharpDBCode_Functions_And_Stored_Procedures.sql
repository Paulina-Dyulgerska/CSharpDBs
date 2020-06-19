-- HOMEWORK Functions And Stored Procedures

--Problem 1.	Employees with Salary Above 35000
--Create stored procedure usp_GetEmployeesSalaryAbove35000 that returns all 
--employees’ first and last names for whose salary is above 35000. 

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
	SELECT FirstName, LastName FROM Employees
	WHERE Salary > 35000
GO --da gi puskam bez GO i EXEC v Judge.

EXEC usp_GetEmployeesSalaryAbove35000;

--Problem 2.	Employees with Salary Above Number
--Create stored procedure usp_GetEmployeesSalaryAboveNumber that accept a number 
--(of type DECIMAL(18,4)) as parameter and returns all employees’ first and last names
--whose salary is above or equal to the given number. 

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Number decimal(18,4))
AS
SELECT FirstName, LastName FROM Employees
WHERE Salary >= @Number

EXEC usp_GetEmployeesSalaryAboveNumber 12400


--Problem 3.	Town Names Starting With
--Write a stored procedure usp_GetTownsStartingWith that accept string as parameter and 
--returns all town names starting with that string. 

CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith (@StartingString NVARCHAR(100))
AS
	DECLARE @StartingStringLength int = LEN(@StartingString)
	SELECT [Name] AS Town FROM Towns
		WHERE LEFT([Name], @StartingStringLength) = @StartingString

EXEC usp_GetTownsStartingWith 'Re'


--Problem 4.	Employees from Town
--Write a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and 
--return the employees’ first and last name that live in the given town. 

CREATE OR ALTER PROCEDURE usp_GetEmployeesFromTown (@TownName nvarchar(100))
AS
	SELECT FirstName, LastName FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON t.TownID = a.TownID
		WHERE t.[Name] = @TownName

EXEC usp_GetEmployeesFromTown 'Sofia'


--Problem 5.	Salary Level Function
--Write a function ufn_GetSalaryLevel(@salary DECIMAL(18,4)) that receives salary of an 
--employee and returns the level of the salary.
--•	If salary is < 30000 return "Low"
--•	If salary is between 30000 and 50000 (inclusive) return "Average"
--•	If salary is > 50000 return "High"

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS nvarchar(7)
AS
BEGIN
	DECLARE @salaryLevel nvarchar(7) = NULL
	IF (@salary < 30000)
		SET @salaryLevel = 'Low'
	ELSE IF (@salary >= 30000 AND @salary <= 50000)
		SET @salaryLevel = 'Average'
	ELSE IF (@salary > 50000)
		SET @salaryLevel = 'High'
	RETURN @salaryLevel
END

SELECT FirstName, LastName, dbo.ufn_GetSalaryLevel(Salary) FROM Employees


----Problem 6.	Employees by Salary Level
--Write a stored procedure usp_EmployeesBySalaryLevel that receive as parameter level of salary
--(low, average or high) and print the names of all employees that have given level of salary.
--You should use the function - "dbo.ufn_GetSalaryLevel(@Salary) ", which was part of the 
--previous task, inside your "CREATE PROCEDURE …" query.

CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel (@SalaryLevel nvarchar(7))
AS
BEGIN
	SELECT FirstName, LastName 
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLevel
END

EXEC usp_EmployeesBySalaryLevel 'Low'


----Problem 7.	Define Function
--Define a function ufn_IsWordComprised(@setOfLetters, @word) that returns true or false depending 
--on that if the word is a comprised of the given set of letters. 

CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters nvarchar(1000), @word nvarchar(1000))
RETURNS bit
AS
BEGIN
	DECLARE @wordLength int = LEN(@word);
	WHILE ( @wordLength > 0)
	BEGIN
		DECLARE @CurrentChar char(1) = LEFT(@word, 1);
		IF CHARINDEX(@CurrentChar, @setOfLetters) = 0
				RETURN 0;
		SET @word = SUBSTRING(@word, 2, @wordLength);
		SET @wordLength = @wordLength - 1;
	END
	RETURN 1;
END

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'So');
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves');
SELECT dbo.ufn_IsWordComprised('bobr', 'Rob');
SELECT dbo.ufn_IsWordComprised('pppp', 'Guy');


----Problem 8.	* Delete Employees and Departments
--Write a procedure with the name usp_DeleteEmployeesFromDepartment (@departmentId INT) 
--which deletes all Employees from a given department. Delete these departments from the 
--Departments table too. Finally SELECT the number of employees from the given department. 
--If the delete statements are correct the select query should return 0.
--After completing that exercise restore your database to revert all changes.
--Hint:
--You may set ManagerID column in Departments table to nullable (using query "ALTER TABLE …").

SELECT * INTO Emp FROM Employees
SELECT * INTO Dmp FROM Departments

CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN

--Employees that are going to be deleted:
--SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId
--za da gi iztriq, az trqbwa da razkacha vsichki vryzki m/u tezi EmployeeIDs i ostanalite tablici ot
--DB-a!!! Towa znachi, che ako otvorq Diagramata na DB-a i vidq ot koi tablici kakwi FK-ove sochat
--kym tablicata, v koqto iskam da triq - tezi FKs sa vsichki vryzki, na koito jyltiqt klyuch otiva
--vyv tablicata Employees!!!! T.e. towa sa zapisi v drugi tablici, za koito ima zapisan FK s nomer,
--kojto shte byde iztrit ot Employees!!!
--Pochwam da prekyswam tezi vryzki za zasegnatite hora (tezi, koito shte
--bydat iztriti). Pyrwo otiwam i triq ot EmployeesProjects tezi hora. Posle Nuliram ManagerID v
--tablicata Employees da im sa NULL na tezi ManagerID, koito shte bydat iztriti, ako sa zapisani nqkyde kato
--manager na nqkoj - taka prekyswam self-relationship-a na tezi hora v samata tablica Employees. T.e.
--ako dadeno ID shte se trie, a to prisystwa kato ManagerID na nqkoj Employee, to towa ManagerID trqbwa da
--stane NULL!!!  
--Posle trqbwa da nuliram ManagerID v 
--Departments table da e null, no to e zabraneno da e null i zatowa pyrwo alternvam
--Department table column ManagerID i mu pozwolqwam da e NULL. Sled towa zapiswam NULL
--za managerID na vsichki hora, kojto shte triq. Sled towa triq horata ot Employees. Sled
--towa triq Departmenta ot Departments i dawam sprawka za COUNT che mi e 0 i  nqmam veche
--hora ot tozi department!!!

--Delete Employees that are going to be deleted later from Employees Table, t.e.
--razkacham vryzkata na Employees, koito ID-ta shte triq, s EmployeesProjects.
DELETE FROM EmployeesProjects 
	WHERE EmployeeID IN 
	(SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

--Set ManagerID to NULL where Manager is an Employee that is going to be deleted, t.e.
--kysam vryzkata na ManagerID s EmployeeID
UPDATE Employees SET ManagerID = NULL WHERE ManagerID IN
 (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)
 --da vnimawam s towa, zashtoto izpuska hora: s 1 i 7 za departmentID mi grymna!!!
--UPDATE Employees SET ManagerID = NULL WHERE DepartmentID = @departmentId

--Alter column ManagerID in Departments table to make it nullable
ALTER TABLE Departments
ALTER COLUMN ManagerID INT --taka pravq ManagerID da e NULLable!!!!

--Set ManagerID to NULL where Manager is an Employee that is going to be deleted, t.e.
--kysam vryzkata na ManagerID s EmployeeID
UPDATE Departments SET ManagerID = NULL WHERE ManagerID IN
 (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

DELETE FROM Employees WHERE DepartmentID = @departmentId

DELETE FROM Departments WHERE DepartmentID = @departmentId

--pravq si obratno kolonata ManagerID da ne moje da e NULL
ALTER TABLE Departments
ALTER COLUMN ManagerID INT NOT NULL

SELECT COUNT(*) FROM Employees WHERE DepartmentID = @departmentId

END


--na kratko e towa:
CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
DELETE FROM EmployeesProjects 
	WHERE EmployeeID IN 
	(SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)
UPDATE Employees SET ManagerID = NULL WHERE ManagerID IN
 (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)
ALTER TABLE Departments
	ALTER COLUMN ManagerID INT --taka pravq ManagerID da e NULLable!!!!
UPDATE Departments SET ManagerID = NULL WHERE ManagerID IN
 (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)
DELETE FROM Employees WHERE DepartmentID = @departmentId
DELETE FROM Departments WHERE DepartmentID = @departmentId
ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NOT NULL
SELECT COUNT(*) FROM Employees WHERE DepartmentID = @departmentId
END

EXEC usp_DeleteEmployeesFromDepartment 7


--Problem 9.	Find Full Name
--You are given a database schema with tables AccountHolders(Id (PK), FirstName, LastName, SSN) 
--and Accounts(Id (PK), AccountHolderId (FK), Balance).  Write a stored procedure 
--usp_GetHoldersFullName that selects the full names of all people. 

CREATE OR ALTER PROCEDURE usp_GetHoldersFullName
AS
BEGIN
SELECT FirstName + ' ' + LastName AS [Full Name] FROM AccountHolders
END

--Problem 10.	People with Balance Higher Than
--Your task is to create a stored procedure usp_GetHoldersWithBalanceHigherThan that accepts a 
--number as a parameter and returns all people who have more money in total of all their accounts 
--than the supplied number. Order them by first name, then by last name

CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan(@Number money)
AS 
BEGIN
SELECT FirstName, LastName 
	FROM AccountHolders AS ah
	JOIN (
			SELECT AccountHolderId, SUM(Balance) AS SumBalances FROM Accounts 
			GROUP BY AccountHolderId
			HAVING SUM(Balance) > @Number
		  ) AS a ON ah.Id = a.AccountHolderId 
	ORDER BY FirstName, LastName
END

EXEC usp_GetHoldersWithBalanceHigherThan 10000


----Problem 11. Future Value Function
--Your task is to create a function ufn_CalculateFutureValue that accepts as 
--parameters – sum (decimal), yearly interest rate (float) and number of years(int). 
--It should calculate and return the future value of the initial sum rounded to the fourth 
--digit after the decimal delimiter. Using the following formula:
--FV=I×(〖(1+R)〗^T)
--	I – Initial sum
--	R – Yearly interest rate
--	T – Number of years

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue 
				(@Sum decimal(18,4), @YearlyInterestRate float, @NumberOfYears int)
RETURNS decimal(18,4)
AS
BEGIN
	DECLARE @Result decimal(18,4)
	SET @Result = @Sum * (POWER((1 + @YearlyInterestRate), @NumberOfYears));
	RETURN @Result
END

SELECT dbo.ufn_CalculateFutureValue(1500, 0.006, 1)


--Problem 12.	Calculating Interest
--Your task is to create a stored procedure usp_CalculateFutureValueForAccount that uses the 
--function from the previous problem to give an interest to a person's account for 5 years,
--along with information about his/her account id, first name, last name and current balance
--as it is shown in the example below. It should take the AccountId and the interest rate 
--as parameters. Again you are provided with “dbo.ufn_CalculateFutureValue” function which 
--was part of the previous task.

--Account Id	First Name	Last Name	Current Balance	Balance in 5 years
--1	Susan	Cane	123.12	198.2860


CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount (@AccountID int, 
																@YearlyInterestRate float)
AS 
BEGIN
DECLARE @Years INT = 5;
SELECT AccountHolderId AS [Account Id] 
	, FirstName AS [First Name]
	, LastName AS [Last Name]
	, Balance AS [Current Balance]
	, dbo.ufn_CalculateFutureValue(Balance, @YearlyInterestRate, @Years) AS [Balance in 5 years]
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON ah.Id = a.AccountHolderId
	WHERE a.Id = @AccountID
END

EXEC usp_CalculateFutureValueForAccount 1, 0.1


--Problem 13.	*Scalar Function: Cash in User Games Odd Rows
--You are given a database "Diablo" holding users, games, items, characters and statistics 
--available as SQL script. Your task is to write some stored procedures, views and other 
--server-side database objects and write some SQL queries for displaying data from the database.
--Important: start with a clean copy of the "Diablo" database on each problem. Just execute the
--SQL script again.
--Create a function ufn_CashInUsersGames that sums the cash of odd rows. Rows must be ordered 
--by cash in descending order. The function should take a game name as a parameter and return 
--the result as table. Submit only your function in.
--Execute the function over the following game names, ordered exactly like: "Love in a mist".
--Output
--SumCash
--8585.00
--Hint use ROW_NUMBER to get the rankings of all rows based on order criteria.

CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@GameName NVARCHAR(50))
RETURNS TABLE AS
RETURN (
SELECT SUM(b.Cash) AS [SumCash]
	FROM
	(
	SELECT *
		FROM 
		(
			SELECT TOP (1000) g.[Id]
				  ,[GameId]
				  ,[UserId]
				  ,[CharacterId]
				  ,[Level]
				  ,[JoinedOn]
				  ,[Cash]
				  ,ROW_NUMBER() OVER (ORDER BY Cash DESC) AS RowNumber
			  FROM  UsersGames AS ug
			  JOIN Games AS g ON g.Id = ug.GameId
			  WHERE g.[Name] = @GameName
		  ) AS a
	WHERE a.RowNumber % 2 = 1
	) AS b
)

SELECT * FROM dbo.ufn_CashInUsersGames('Love in a mist')


--Problems from 14 to 22 --they are in the Trigger and Transaction file

