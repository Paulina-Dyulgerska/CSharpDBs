--SELECT TownID FROM SoftUni.dbo.Towns

USE SoftUni
-- V Select moga da dawam ne samo imena na koloni, no i preobrazuvaniq po tqh:
SELECT TownID, [Name], LEN([Name]), LEFT([Name], 1), SUBSTRING([Name], 1, 2) FROM Towns 
--vzimam dyljinata na Towns, pyvata bukva i pyrvite 2 bukvi.

SELECT GETDATE() --2020-05-22 23:22:06.943

SELECT TownID, [Name], LEN([Name]), LEFT([Name], 1), SUBSTRING([Name], 1, 2) 
	FROM Towns 
	WHERE [Name] = 'Sofia'

SELECT TownID, [Name], LEN([Name]), SUBSTRING([Name], 1, 2) 
	FROM Towns 
	WHERE LEFT([Name], 1) = 'S' --pyrvata bukva = S

SELECT *
	FROM Towns 
	WHERE LEFT([Name], 1) = 'S' --pyrvata bukva = S

--Ot dve tablici Addresses i Towns az pravq JOIN po 
--TownID i vadq kolonite ot Addresses.AddressText i Towns.Name v 1 tablica!!!
SELECT AddressText, [Name]
	FROM [Addresses]
	JOIN Towns ON Addresses.TownID = Towns.TownID

--vzimam samo gradovete s imena pochvashti sys S:
SELECT AddressText, [Name]
	FROM [Addresses]
	JOIN Towns ON Addresses.TownID = Towns.TownID
	WHERE LEFT([Name], 1) = 'S'

SELECT AddressText, [Name]
	FROM [Addresses]
	JOIN Towns ON Addresses.TownID = Towns.TownID
	WHERE [Name] = 'Bellevue'

-- promenqm imeto na column!!!
SELECT EmployeeID AS ID,
       FirstName,
       LastName
  FROM Employees

--davam imena na novite columns:
SELECT TownID AS [Town Column], [Name], LEN([Name]) AS [Length], LEFT([Name], 1) AS FirstChar, SUBSTRING([Name], 1, 2) As FirstTwoChars
	FROM Towns 
	WHERE LEFT([Name],1) = 'B'

SELECT A.AddressText, T.[Name]
	FROM Addresses AS A
	JOIN Towns AS T ON A.TownID = T.TownID
	WHERE [Name] = 'Bellevue'

SELECT AddressText, [Name]
	FROM Addresses  A
	JOIN Towns T ON A.TownID = T.TownID
	WHERE [Name] = 'Bellevue'

--SELECT moje da e vhodna tochka na druga zaqwka SELECT:
--syzdawa se virtualna table v RAM-a i se raboti s neq kato tablica s ime tmpTable:
SELECT * FROM 
	(SELECT [Name], LEN([Name]) AS [Length], LEFT([Name], 1) AS FirstChar
		FROM Towns) as tmpTable

--tuk si izpolzwam virtualnata table tmpTable i imenata na kolinite j, za da pravq selection po rows:
SELECT * FROM 
	(SELECT [Name], LEN([Name]) AS [Length], LEFT([Name], 1) AS FirstChar
		FROM Towns) as tmpTable
	WHERE FirstChar = 'B'

--taka concateniram stringove:
SELECT FirstName + ' ' + LastName AS [Full Name],
       EmployeeID AS [No.]
  FROM Employees

  -- podredeni sa v reda, v kojto sa zapisani v DB-a
SELECT FirstName + ' ' + LastName
    AS [Full Name],
       JobTitle,
       Salary
  FROM Employees

--ako iskam da polucha samo unicalnite zapisi v dadena kolona, a ne vsichki, pravq taka:
SELECT DISTINCT
       JobTitle
  FROM Employees

--ako iskam da polucha vsichki zapisi, pravq taka, no tuk imam povtoreniq:
SELECT 
       JobTitle
  FROM Employees

SELECT DISTINCT TOP(10)
       JobTitle
  FROM Employees

SELECT DISTINCT 
       JobTitle, FirstName
  FROM Employees

SELECT COUNT(DISTINCT JobTitle)
	FROM Employees

--vzimam zverski broq na slujitelite v dadena JobTitle - no po kofti nachin e towa pravene:
SELECT DISTINCT
	JobTitle,
	(SELECT COUNT(*) FROM Employees AS e2 WHERE e2.JobTitle = e1.JobTitle)
	FROM Employees AS e1

--pravilniqt nachin da se naprawi gornoto e tozi:
SELECT JobTitle, COUNT(*) AS [Count]
	FROM Employees
	GROUP BY JobTitle

SELECT JobTitle, MAX(Salary), MIN(Salary), COUNT(*), MAX(Salary) - MIN(Salary) AS [Difference], AVG(Salary)
	FROM Employees
	GROUP BY JobTitle

SELECT DISTINCT
	JobTitle
	FROM Employees
	--JOIN
	WHERE JobTitle='Accountant'
	ORDER BY JobTitle
	--HAVING -- tova e edin posleden WHERE, sled vsichki drugi WHEREs se pishe.

SELECT *
	FROM Employees
	WHERE Salary >= 40000

SELECT *
	FROM Employees
	WHERE Salary = 10000

SELECT *
	FROM Employees
	WHERE FirstName = 'Chris'

--LIKE mi e kato Contains() - a % vytre znachi 'kakvo da e', % e = *
SELECT *
	FROM Employees
	WHERE FirstName LIKE '%ris' --Baris, Chris, Doris

SELECT *
	FROM Employees
	--WHERE FirstName LIKE 'Pet%' --Pete, Peter
	--WHERE FirstName LIKE '%ete%' --Pete, Peter, Tete
	WHERE FirstName LIKE '%e%t%e%' --Pete, Peter, Tete, Sylvester, Annette

SELECT *
	FROM Employees
	WHERE Salary != 10000

SELECT *
	FROM Employees
	WHERE NOT (Salary = 10000)

SELECT *
	FROM Employees
	WHERE Salary >= 10000 
		AND Salary <= 20000 
		AND JobTitle = 'Production Technician'
		AND ManagerID = 185

		
SELECT *
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 20000 
		AND JobTitle = 'Production Technician'
		AND ManagerID = 185
		
SELECT *
	FROM Employees
	WHERE (FirstName = 'Alice' OR LastName = 'Li') AND Salary >= 10000

SELECT *
	FROM Employees
	WHERE FirstName LIKE '[ABC]%' --samo imena pochvashti s A,B ili C mi vryshta.

SELECT *
	FROM Employees
	WHERE ManagerID IN (16, 167, 2, 3)

SELECT *
	FROM Employees
	WHERE MiddleName IS NOT NULL
		AND MiddleName != ''

SELECT LastName, HireDate
    FROM Employees
	ORDER BY HireDate ASC --po default e ASC!!!! T.e. moga i da ne pisha ASC tuk i bez ASC shte mi gi dade pak v narastwasht red.

SELECT LastName, HireDate
    FROM Employees
	ORDER BY HireDate DESC -- podrejda gi w namalqwasht red.

SELECT LastName, Salary
    FROM Employees
	ORDER BY Salary DESC

SELECT LastName, Salary
    FROM Employees
	ORDER BY Salary ASC

SELECT LastName, Salary
    FROM Employees
	ORDER BY LastName DESC

SELECT *
    FROM Employees
	ORDER BY FirstName, LastName

SELECT *
    FROM Employees
	ORDER BY FirstName, LastName

SELECT *
    FROM Employees
	ORDER BY FirstName ASC, LastName DESC

SELECT *
    FROM Employees
	WHERE FirstName Like 'Andrew'
	ORDER BY FirstName ASC, LastName DESC

SELECT JobTitle, FirstName
    FROM Employees
	GROUP BY JobTitle, FirstName

SELECT *
    FROM Employees
	WHERE HireDate >= '2000-01-01' AND HireDate <= '2001-01-01' --Vzimam naznachenite prez 2000 g.

SELECT *
    FROM Employees
	--WHERE YEAR(HireDate) = 2000 --vzima godinata ot datata tazi f-q YEAR()
	--WHERE MONTH(HireDate) = 1 --vzima meseca ot datata
	--WHERE DAY(HireDate) = 1 --vzima day ot datata
	--WHERE DATEPART(dw, HireDate) = 2 --vzima dw(day of week) ot datata, 1 e Sunday i t.n. vyrvqt
	WHERE DATENAME(dw, HireDate) = 'Monday' --vzima dw(day of week) ot datata

SELECT HireDate, DATENAME(dw, HireDate)
    FROM Employees
	
--shte vzema samo pyrvite 2 bukvi ot denq ot sedmicata:
SELECT HireDate, LEFT(DATENAME(dw, HireDate),2)
    FROM Employees

--shte vzema samo poslednite 3 bukvi ot denq ot sedmicata:
SELECT HireDate, RIGHT(DATENAME(dw, HireDate),3)
    FROM Employees

--CREATE VIEW v_EmployeesByDepartment AS
--SELECT FirstName + ' ' + LastName AS [Full Name],
--       Salary
--  FROM Employees

SELECT * FROM v_EmployeesByDepartment --This is the Executed query

--CREATE VIEW v_GetHireDateAndDateOfWeek AS
--SELECT HireDate, DATENAME(dw, HireDate) AS [DayOfWeek]
--    FROM Employees

SELECT * FROM [dbo].[v_GetHireDateAndDateOfWeek] ----This is the Executed query

SELECT [DayOfWeek] FROM [dbo].[v_GetHireDateAndDateOfWeek] ----This is the Executed query

SELECT [Full Name] FROM v_EmployeesByDepartment ----This is the Executed query

