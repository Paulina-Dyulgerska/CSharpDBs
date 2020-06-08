--Homework JOINS, CTE, Subqueries

USE SoftUni
-- Problem 1.	Employee Address
--Write a query that selects:
--•	EmployeeId
--•	JobTitle
--•	AddressId
--•	AddressText
--Return the first 5 rows sorted by AddressId in ascending order.

SELECT TOP(5) e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	ORDER BY e.AddressID ASC

--Problem 2.	Addresses with Towns
--Write a query that selects:
--•	FirstName
--•	LastName
--•	Town
--•	AddressText
--Sorted by FirstName in ascending order then by LastName. Select first 50 employees.

SELECT TOP(50) e.FirstName, e.LastName, t.Name AS Town, a.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	ORDER BY e.FirstName ASC, e.LastName

--Problem 3.	Sales Employee
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	LastName
--•	DepartmentName
--Sorted by EmployeeID in ascending order. Select only employees from "Sales" department.

SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] AS DepartmentName
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE d.[Name] = 'Sales'
	ORDER BY e.EmployeeID ASC

--Problem 4.	Employee Departments
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	Salary
--•	DepartmentName
--Filter only employees with salary higher than 15000. Return the first 5 rows sorted by DepartmentID in ascending 
--order.

SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.[Name] AS DepartmentName
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY e.DepartmentID ASC

--Problem 5.	Employees Without Project
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--Filter only employees without a project. Return the first 3 rows sorted by EmployeeID in ascending order.

SELECT TOP(3) e.EmployeeID, e.FirstName
	FROM EmployeesProjects AS ep
	RIGHT JOIN Employees AS e ON ep.EmployeeID = e.EmployeeID
	LEFT JOIN Projects AS p ON p.ProjectID = ep.ProjectID
	WHERE p.Name IS NULL
	ORDER BY EmployeeID ASC

--Problem 6.	Employees Hired After
--Write a query that selects:
--•	FirstName
--•	LastName
--•	HireDate
--•	DeptName
--Filter only employees hired after 1.1.1999 and are from either "Sales" or "Finance" departments, 
--sorted by HireDate (ascending).

SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS DeptName
	FROM Employees AS e
	LEFT JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE e.HireDate > '1999-01-01' AND d.[Name] IN ('Sales', 'Finance')
	ORDER BY e.HireDate ASC
	
--Problem 7.	Employees with Project
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). 
--Return the first 5 rows sorted by EmployeeID in ascending order.

SELECT TOP(5) e.EmployeeID, e.FirstName, p.[Name] AS ProjectName
	FROM EmployeesProjects AS ep
	JOIN Employees AS e ON ep.EmployeeID = e.EmployeeID
	LEFT JOIN Projects AS p ON p.ProjectID = ep.ProjectID
	WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
	ORDER BY EmployeeID ASC

--Problem 8.	Employee 24
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ProjectName
--Filter all the projects of employee with Id 24. If the project has started during or after 2005 the 
--returned value should be NULL.

SELECT e.EmployeeID, e.FirstName, 
	CASE 
		WHEN p.[StartDate] >= '2005-01-01' THEN NULL
		ELSE p.[Name] 
	END AS ProjectName
	FROM EmployeesProjects AS ep
	JOIN Employees AS e ON ep.EmployeeID = e.EmployeeID
	JOIN Projects AS p ON p.ProjectID = ep.ProjectID
	WHERE e.EmployeeID = 24

--Problem 9.	Employee Manager
--Write a query that selects:
--•	EmployeeID
--•	FirstName
--•	ManagerID
--•	ManagerName
--Filter all employees with a manager who has ID equals to 3 or 7. Return all the rows, sorted by
--EmployeeID in ascending order.

SELECT e.EmployeeID, e.FirstName, e.ManagerID, m.FirstName AS ManagerName
	FROM Employees AS e
	LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
	WHERE m.EmployeeID IN (3,7)
	ORDER BY e.EmployeeID ASC

--Problem 10. Employee Summary
--Write a query that selects:
--•	EmployeeID
--•	EmployeeName
--•	ManagerName
--•	DepartmentName
--Show first 50 employees with their managers and the departments they are in (show the departments of the employees). 
--Order by EmployeeID.

SELECT TOP(50) e.EmployeeID, 
	e.FirstName + ' ' + e.LastName AS EmployeeName, 
	m.FirstName + ' ' + m.LastName AS ManagerName, 
	d.[Name] AS DepartmentName
	FROM Employees AS e
	LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	ORDER BY e.EmployeeID

--Problem 11. Min Average Salary
--Write a query that returns the value of the lowest average salary of all departments.

SELECT TOP(1) AVG(Salary) FROM Employees
	GROUP BY DepartmentID
	ORDER BY AVG(Salary)


USE Geography
--Problem 12. Highest Peaks in Bulgaria
--Write a query that selects:
--•	CountryCode
--•	MountainRange
--•	PeakName
--•	Elevation
--Filter all peaks in Bulgaria with elevation over 2835. Return all the rows sorted by elevation in descending order.

SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation
	FROM Peaks AS p
	JOIN Mountains AS m ON p.MountainId = m.Id
	JOIN MountainsCountries AS mc ON p.MountainId = mc.MountainId
	WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
	ORDER BY p.Elevation DESC

--Problem 13. Count Mountain Ranges
--Write a query that selects:
--•	CountryCode
--•	MountainRanges
--Filter the count of the mountain ranges in the United States, Russia and Bulgaria.

SELECT	f.CountryCode, 
		COUNT(*) AS MountainRanges
	FROM
		(SELECT mc.CountryCode, m.MountainRange
			FROM MountainsCountries AS mc 
			JOIN Mountains AS m ON m.Id = mc.MountainId
			JOIN Countries AS c ON mc.CountryCode = c.CountryCode
			WHERE c.CountryName IN ('United States', 'Russia', 'Bulgaria')
		) as f
	GROUP BY f.CountryCode

--Problem 14. Countries with Rivers
--Write a query that selects:
--•	CountryName
--•	RiverName
--Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order.


SELECT TOP(5) c.CountryName, r.RiverName
	FROM CountriesRivers AS cr
	RIGHT JOIN Countries AS c ON c.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
	LEFT JOIN Continents AS cont ON cont.ContinentCode = c.ContinentCode
	WHERE cont.ContinentName = 'Africa'
	ORDER BY c.CountryName


--Problem 15. *Continents and Currencies
--Write a query that selects:
--•	ContinentCode
--•	CurrencyCode
--•	CurrencyUsage
--Find all continents and their most used currency. Filter any currency that is used in only one country. 
--Sort your results by ContinentCode.

SELECT g.ContinentCode, g.CurrencyCode, g.CurrencyUsage 
	FROM	(SELECT	f.ContinentCode, 
					f.CurrencyCode, 
					f.CurrencyUsage, 
					DENSE_RANK() OVER(PARTITION BY f.ContinentCode ORDER BY f.CurrencyUsage DESC) AS DR
						FROM	( SELECT c.ContinentCode, c.CurrencyCode, COUNT(c.CurrencyCode) AS CurrencyUsage
									FROM Countries AS c
									GROUP BY c.ContinentCode, c.CurrencyCode) AS f --tova e CurrencyCountQuery
									--grupiram pyrvo po ContinentCode i posle vyv vsqka otdelna grupa
									--se pravqt podgrupi po CurrencyCode!!!! Dvojno group by e towa!!!! 
									--Pravq Kutijka za vseki kontinent i v neq
									--pravq otdelni kutijki za vsqka valuta, v koito nablyskvam vsqka otdelna country!!!
			) AS g --tove e CurrencyRankQuery
	WHERE g.DR = 1 AND g.CurrencyUsage <>1
	ORDER BY g.ContinentCode ASC

SELECT g.ContinentCode, g.CurrencyCode, g.CurrencyUsage 
	FROM (SELECT c.ContinentCode, 
				 c.CurrencyCode, 
				 COUNT(c.CurrencyCode) AS CurrencyUsage,
				 DENSE_RANK() OVER(PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS DR
			FROM Countries AS c
			GROUP BY c.ContinentCode, c.CurrencyCode --grupiram pyrvo po ContinentCode i posle vyv vsqka otdelna grupa
			--se pravqt podgrupi po CurrencyCode!!!! Dvojno group by e towa!!!! Pravq Kutijka za vseki kontinent i v neq
			--pravq otdelni kutijki za vsqka valuta, v koito nablyskvam vsqka otdelna country!!!
			--Gropu By mi dava dostyp posle otvyn samo na towa, po koeto sym grupirala, t.e. samo po towa, po koeto sym 
			--grupirala moga da pravq koloni sled towa otvyn! NO!!! Pri group by moga da pravq aggregation v/u dannite!!!!
			--Moga da pravq aggregation v/u vsqka kolona ot FROM statementa, bez znachenie dali gupiram ili ne grupiram
			--po neq!!!! T.e. Moga da vikam Max, min, count na vsichko to Countries, a ne samo na c.ContinentCode, c.CurrencyCode !!!!
		) AS g --tova e CurrencyCountAndRankQuery, no moje bi ne e gotino i e po-dobre da gi razdelq na 2 queryta kato po-gore.
	WHERE g.DR = 1 AND g.CurrencyUsage <> 1
	ORDER BY g.ContinentCode ASC

--Problem 16. Countries Without Any Mountains
--Find all the count of all countries, which don’t have a mountain.

SELECT COUNT(*)
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
WHERE mc.CountryCode IS NULL

--Problem 17. Highest Peak and Longest River by Country
--For each country, find the elevation of the highest peak and the length of the longest river, 
--sorted by the highest peak elevation (from highest to lowest), then by the longest river length 
--(from longest to smallest), then by country name (alphabetically). Display NULL when no data is 
--available in some of the columns. Limit only the first 5 rows.


SELECT TOP(5) f.CountryName, f.HighestPeakElevation, f.LongestRiverLength 
	FROM 
		(
		SELECT c.CountryName, 
				p.PeakName, 
				p.Elevation AS HighestPeakElevation,
				DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS DenseRankPeak,
				r.RiverName,
				r.[Length] AS LongestRiverLength,
				DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY r.[Length] DESC) AS DenseRankRiver
			FROM Countries AS c  
			LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
			LEFT JOIN Peaks AS p ON mc.MountainId = p.MountainId
			LEFT JOIN CountriesRivers AS cr ON cr.CountryCode=c.CountryCode
			LEFT JOIN Rivers AS r ON cr.RiverId=r.Id
			GROUP BY c.CountryName, p.PeakName, p.Elevation, r.RiverName, r.[Length]
		) AS f
	WHERE f.DenseRankPeak = 1 AND f.DenseRankRiver = 1
	ORDER BY f.HighestPeakElevation DESC, f.LongestRiverLength DESC, f.CountryName ASC

--taka e po-hitro:
SELECT TOP(5) 
	c.CountryName, 
	MAX(p.Elevation) AS HighestPeakElevation,
	MAX(r.[Length]) AS LongestRiverLength 
FROM Countries AS c  
	LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
	LEFT JOIN Peaks AS p ON mc.MountainId = p.MountainId
	LEFT JOIN CountriesRivers AS cr ON cr.CountryCode=c.CountryCode
	LEFT JOIN Rivers AS r ON cr.RiverId=r.Id
	GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, c.CountryName ASC

--Problem 18. Highest Peak Name and Elevation by Country
--For each country, find the name and elevation of the highest peak, along with its mountain. 
--When no peaks are available in some country, display elevation 0, "(no highest peak)" as 
--peak name and "(no mountain)" as mountain name. When multiple peaks in some country have 
--the same elevation, display all of them. Sort the results by country name alphabetically, 
--then by highest peak name alphabetically. Limit only the first 5 rows.

				
SELECT TOP(500000) 
	f.CountryName AS Country, 
	CASE 
		WHEN f.PeakName IS NULL THEN '(no highest peak)' 
		ELSE f.PeakName
	END AS [Highest Peak Name],
	CASE 
		WHEN f.PeakName IS NULL THEN 0 
		ELSE f.HighestPeakElevation
	END AS [Highest Peak Elevation],
	CASE 
		WHEN f.MountainRange IS NULL THEN '(no mountain)' 
		ELSE f.MountainRange
	END AS Mountain
	FROM 
		(
		SELECT c.CountryName, 
				m.MountainRange,
				p.PeakName, 
				p.Elevation AS HighestPeakElevation,
				DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS DenseRankPeak
			FROM Countries AS c  
			LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
			LEFT JOIN Peaks AS p ON mc.MountainId = p.MountainId
			LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
			GROUP BY c.CountryName, p.PeakName, p.Elevation, m.MountainRange
		) AS f
	WHERE f.DenseRankPeak = 1 
	ORDER BY f.CountryName ASC, f.PeakName ASC

