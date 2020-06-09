--HOMEWORK Exercises: Data Aggregation


--Problem 1. Records’ Count
SELECT COUNT(*) AS [Count]
FROM WizzardDeposits


--Problem 2. Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits


--Problem 3. Longest Magic Wand Per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup


--Problem 4. * Smallest Deposit Group Per Magic Wand Size
SELECT TOP(2) DepositGroup
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY AVG(MagicWandSize) 


--Problem 5. Deposits Sum
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	GROUP BY DepositGroup


--Problem 6. Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup


--Problem 7. Deposits Filter
--Select all deposit groups and their total deposit sums but only for the wizards who have their 
--magic wands crafted by Ollivander family. Filter total deposit amounts lower than 150000. Order 
--by total deposit amount in descending order.
SELECT *
FROM
(SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup) AS d
WHERE d.TotalSum < 150000
ORDER BY d.TotalSum DESC


--Problem 8.  Deposit Charge
--Create a query that selects:
--•	Deposit group 
--•	Magic wand creator
--•	Minimum deposit charge for each group 
--Select the data in ascending ordered by MagicWandCreator and DepositGroup.
SELECT DepositGroup,
	MagicWandCreator, 
	MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup ASC


--Problem 9. Age Groups
--Write down a query that creates 7 different groups based on their age.
--Age groups should be as follows:
--•	[0-10]
--•	[11-20]
--•	[21-30]
--•	[31-40]
--•	[41-50]
--•	[51-60]
--•	[61+]
--The query should return
--•	Age groups
--•	Count of wizards in it

SELECT d.AgeGroup,
		COUNT(*)
		FROM (SELECT	FirstName, 
						Age, 
						CASE 
							WHEN Age<=10 THEN '[0-10]'
							WHEN Age>10 AND Age<=20 THEN '[11-20]'
							WHEN Age>20 AND Age<=30 THEN '[21-30]'
							WHEN Age>30 AND Age<=40 THEN '[31-40]'
							WHEN Age>40 AND Age<=50 THEN '[41-50]'
							WHEN Age>50 AND Age<=60 THEN '[51-60]'
							WHEN Age>60 THEN '[61+]'
						END AS AgeGroup
				FROM WizzardDeposits) AS d
GROUP BY d.AgeGroup


----Problem 10. First Letter
--Write a query that returns all unique wizard first letters of their first names only if they 
--have deposit of type Troll Chest. Order them alphabetically. Use GROUP BY for uniqueness.

SELECT DISTINCT LEFT(FirstName,1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
ORDER BY FirstLetter


----Problem 11. Average Interest 
--Mr. Bodrog is highly interested in profitability. He wants to know the average interest of 
--all deposit groups split by whether the deposit has expired or not. But that’s not all. He 
--wants you to select deposits with start date after 01/01/1985. Order the data descending by 
--Deposit Group and ascending by Expiration Flag.
--The output should consist of the following columns:
--Example:
--DepositGroup	IsDepositExpired	AverageInterest
--Venomous Tongue	0	16.698947
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest)
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC


--Problem 12. * Rich Wizard, Poor Wizard
--Mr. Bodrog definitely likes his werewolves more than you. This is your last chance to survive! 
--Give him some data to play his favorite game Rich Wizard, Poor Wizard. The rules are simple: 
--You compare the deposits of every wizard with the wizard after him. If a wizard is the last one 
--in the database, simply ignore it. In the end you have to sum the difference between the deposits.

--Host Wizard	Host Wizard Deposit	Guest Wizard	Guest Wizard Deposit	Difference
--Harry	10 000	Tom	12 000	-2000
--Tom	12 000	…	…	…

--At the end your query should return a single value: the SUM of all differences.
--Example:
--SumDifference
--44393.97
SELECT
	(SELECT TOP(1) DepositAmount
	FROM WizzardDeposits
	ORDER BY Id ASC) 
	-
	(SELECT TOP(1) DepositAmount
	FROM WizzardDeposits
	ORDER BY Id DESC) AS SumDifference

SELECT SUM(d.DiffDep)
FROM (
		 SELECT w1.DepositAmount - w2.DepositAmount AS DiffDep--, w1.*
		 FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY Id) AS rowid FROM WizzardDeposits) AS w1
			JOIN (SELECT *, ROW_NUMBER() OVER (ORDER BY Id) AS rowid FROM WizzardDeposits) AS w2
			ON w1.rowid = w2.rowid - 1
	) AS d


WITH WizzardDepositsActions AS
(
    SELECT ROW_NUMBER() OVER (ORDER BY [Id]) -- Create an index number ordered by time.
         AS [RowSequence],
    * from WizzardDeposits
)
SELECT *,
       WizzardDepositsActions.DepositAmount - (SELECT other.DepositAmount 
			FROM WizzardDepositsActions AS Other 
            WHERE other.[RowSequence] = WizzardDepositsActions.[RowSequence] + 1 )
    AS DiffDep
FROM WizzardDepositsActions;


--Problem 13. Departments Total Salaries
--That’s it! You no longer work for Mr. Bodrog. You have decided to find a proper job as an analyst 
--in SoftUni. 
--It’s not a surprise that you will use the SoftUni database. Things get more exciting here!
--Create a query that shows the total sum of salaries for each department. Order by DepartmentID.
--Your query should return:	
--•	DepartmentID
--Example:
--DepartmentID	TotalSalary
--1	241000.00

SELECT DepartmentID, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID ASC


----Problem 14. Employees Minimum Salaries
--Select the minimum salary from the employees for departments with ID (2, 5, 7) but only for 
--those hired after 01/01/2000.
--Your query should return:	
--•	DepartmentID
--Example: 
--DepartmentID	MinimumSalary
--2	25000.00
--5	12800.00

SELECT DepartmentID, MIN(Salary) AS MinimumSalary
FROM Employees
WHERE DepartmentID IN (2, 5, 7) AND HireDate > '2000-01-01'
GROUP BY DepartmentID
ORDER BY DepartmentID ASC


----Problem 15. Employees Average Salaries
--Select all employees who earn more than 30000 into a new table. Then delete all employees who 
--have ManagerID = 42 (in the new table). Then increase the salaries of all employees with DepartmentID=1 
--by 5000. Finally, select the average salaries in each department.
--Example:
--DepartmentID	AverageSalary
--1	45166.6666

--tova ne minava v Judge
SELECT d.DepartmentID, AVG(Salary) 
FROM
(
SELECT DepartmentID, 
		CASE 
			WHEN DepartmentID = 1 THEN Salary + 5000
		ELSE Salary
		END AS Salary
FROM Employees
WHERE ManagerID <> 42 AND Salary > 30000
) AS d
GROUP BY d.DepartmentID


--Copy from 1 table INTO a completely new table:
SELECT * INTO Emp_Temp FROM Employees WHERE Salary > 30000
DELETE FROM Emp_Temp WHERE ManagerID = 42
UPDATE Emp_Temp SET Salary = Salary + 5000 WHERE DepartmentID = 1
SELECT DepartmentID, AVG(Salary) FROM Emp_Temp GROUP BY DepartmentID


----Problem 16. Employees Maximum Salaries
--Find the max salary for each department. Filter those, which have max salaries NOT in the 
--range 30000 – 70000.
--Example:
--DepartmentID	MaxSalary
--2	29800.00

SELECT * FROM 
(
SELECT DepartmentID, MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
) AS d
WHERE d.MaxSalary < 30000 OR d.MaxSalary > 70000


--Problem 17. Employees Count Salaries
--Count the salaries of all employees who don’t have a manager.
--Example:
--Count
--4

SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL


--Problem 18. *3rd Highest Salary
--Find the third highest salary in each department if there is such. 
--Example:
--DepartmentID	ThirdHighestSalary
--1	36100.00

SELECT f.DepartmentID, f.Salary AS ThirdHighestSalary FROM 
(
	SELECT d.DepartmentID, d.SalaryRank, d.Salary FROM 
			(
			SELECT DepartmentID,
					DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY (Salary) DESC) AS SalaryRank,
					Salary
			FROM Employees
			) AS d
	WHERE d.SalaryRank = 3
) as f
GROUP BY f.DepartmentID, f.Salary

--syshtoto e kato gornoto:
SELECT f.DepartmentID, f.Salary AS ThirdHighestSalary FROM 
(
	SELECT * FROM 
		(
		SELECT *, DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY (Salary) DESC) AS SalaryRank
		FROM Employees
		) AS d
		WHERE d.SalaryRank = 3
) as f
GROUP BY f.DepartmentID, f.Salary


----Problem 19. **Salary Challenge
--Write a query that returns:
--•	FirstName
--•	LastName
--•	DepartmentID
--Select all employees who have salary higher than the average salary of their respective departments. 
--Select only the first 10 rows. Order by DepartmentID.
--Example:
--FirstName	LastName	DepartmentID
--Roberto	Tamburello	1

SELECT TOP(10) e.FirstName, e.LastName, e.DepartmentID
	FROM Employees AS e
	JOIN (	SELECT DepartmentID, AVG(Salary) AS AvgSalary
			FROM Employees
			GROUP BY DepartmentID
			) AS d 
			ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary > d.AvgSalary
	ORDER BY DepartmentID