---Functions
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[MiddleName]
      ,[JobTitle]
      ,[DepartmentID]
      ,[ManagerID]
      ,[HireDate]
      ,[Salary]
      ,[AddressID]
	  ,PERCENTILE_CONT(0.5) WITHIN  --o.5 oznachava sredata, t.e. Mediananta, tova NE E srednoaritmetichno, a chistata mediana, t.e. srednoto chislo
		GROUP (ORDER BY Salary DESC) 
		OVER (PARTITION BY DepartmentId) AS MedianCont
  FROM [SoftUni].[dbo].[Employees]

SELECT FirstName + ' ' + LastName
    AS [Full Name]
  FROM Employees

  SELECT CONCAT(FirstName, ' ', LastName) --priema neogranichen broj parameters
    AS [Full Name]
  FROM Employees

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) --priema neogranichen broj parameters
    AS [Full Name]
  FROM Employees


SELECT CONCAT_WS(' ', FIrstName, MiddleName, LastName) --priema neogranichen broj parameters
    AS [Full Name]
  FROM Employees

SELECT ArticleId, Author, Content,
       SUBSTRING(Content, 1, 200) + '...' AS Summary
  FROM Articles

SELECT *,
      SUBSTRING(FirstName, 1,10) --vrystha ot 1-vi do 10-ti symbol!! Da ne zabravqm che v DB se broi ot 1, a ne ot 0!!!
 FROM Employees


SELECT *,
      SUBSTRING(FirstName, 4,10) --vrystha ot 4-vi do 10-ti symbol!! Da ne zabravqm che v DB se broi ot 1, a ne ot 0!!!
 FROM Employees

SELECT REPLACE('SoftUni', 'Soft', 'Hard');

SELECT LTRIM('          pOLA');

SELECT TRIM('   SADA      ');

SELECT LEN('   SADA      '); -- => 7 --tuka ima BUG!!!!! Ne e 7!!!
SELECT LEN(TRIM('   SADA      ')); -- => 4
SELECT LEN('dasdasdaSADAasdada'); -- => 18

SELECT LEN('dasdasdaSADAasdada'),-- => 18
		DATALENGTH('dasdasdaSADAasdadaКкосда'); -- => 24 

SELECT LEN('Niki'),-- => 4
		DATALENGTH('Niki'); -- => 4

SELECT LEN('Ники'),-- => 4
		DATALENGTH('Ники'); -- => 4
--zashto vryshta 4? ami zashtoto e zapisano no Ники, а ????
--za da se chete ne BG trqbwa da e zapisano v N

--s N mu kazwam, che sledva 2B symbol niz i SQL-a da go interpretira kato 2 B za 1 symbol, taka shte se opravi problema s ?????-te
SELECT LEN(N'Ники'),-- => 4
		DATALENGTH(N'Ники'); -- => 8



SELECT [FirstName],
      LEFT(FirstName, 4), --vrystha pyrvite 4 symbols!! Da ne zabravqm che v DB se broi ot 1, a ne ot 0!!!
	  SUBSTRING(FirstName, 1, 4), --syshtoto e kato gorniq red
	  RIGHT(FirstName, 4),--vrystha poslednite 4 symbols!! Da ne zabravqm che v DB se broi ot 1, a ne ot 0!!!
	  SUBSTRING(FirstName, LEN(FirstName) - 3, 4) --syshtoto kato gornoto
 FROM Employees

SELECT LEFT(N'Ники',2) -- => Ни

SELECT [FirstName],
      UPPER(FirstName)
 FROM Employees

SELECT [FirstName],
      LOWER(FirstName)
 FROM Employees

SELECT UPPER(N'Ники')

SELECT LOWER(N'Ники')

SELECT REVERSE('Paulina')

SELECT FORMAT(0.15, '%', 'bg-BG')

--трябва да внимавам какъв тип данни давам на формат
SELECT FORMAT(GETDATE(), 'MMMM', 'bg-BG'); -- юни -- getdate vryshta format ot datetime!!!
SELECT FORMAT(GETDATE(), 'dd MMMM yyyy', 'en-EN'); -- 01 June 2020
SELECT FORMAT(GETDATE(), 'dd MMMM yyyy', 'bg-BG'); -- 01 Юни 2020
SELECT FORMAT(CONVERT(DATETIME, '2010-01-01'), 'MMMM', 'bg-BG'); --януари
SELECT FORMAT(CAST('2010-01-01' AS DATETIME), 'MMMM', 'bg-BG'); --януари


SELECT 
	REPLACE(REPLACE(N'АДАДАСДА', N'А', N'Б'), N'С', '*') --БДБДБ*ДБ

SELECT 
VALUE FROM STRING_SPLIT('sdsd adsa sdad a', ' ')

SELECT FORMAT(1.2121223231, 'p5') --1.21223%
SELECT FORMAT(1.2121223231, 'N5') --1.21223

SELECT TOP (1000) [CustomerID]
      ,[FirstName]
      ,[LastName]
      ,[PaymentNumber]
  FROM [Demo].[dbo].[Customers]

CREATE VIEW v_CustomersWithObfuscatedNumbers AS
SELECT TOP (1000) [CustomerID]
      ,[FirstName]
      ,[LastName]
	  ,CONCAT(LEFT(PaymentNumber, 6), REPLICATE('*', LEN(PaymentNumber) - 6))
		AS PaymentNumber
  FROM [Demo].[dbo].[Customers]

SELECT * from v_CustomersWithObfuscatedNumbers

SELECT CHARINDEX('P', 'Polq') -->1
SELECT CHARINDEX('k', 'Polq') -->0

SELECT STUFF('I am vary clever girl', 5, 0, ' not') --I am not vary clever girl
SELECT STUFF('I am vary clever girl', 5, 4, ' not a') --I am not ay clever girl --4 znachi, che e iztrilo 4 symbola na mqstoto na vmykvaneto
SELECT STUFF('I am vary clever girl', 5, 0, ' not a') --I am not a vary clever girl

SELECT 10/3.0 --3.3333

SELECT TOP (1000) [Id]
      ,[Name]
      ,[Quantity]
      ,[BoxCapacity]
      ,[PalletCapacity]
	  ,Quantity / BoxCapacity --taka vryshta celochisleno delenie
	  ,1.0*Quantity / BoxCapacity --taka vryshta sys zapetajka delenie
	  ,CAST(Quantity AS FLOAT) / BoxCapacity --taka vryshta sys zapetajka delenie
  FROM [Demo].[dbo].[Products]

SELECT *
  FROM Triangles2 

SELECT Id,
       --(A*H)/2 AS Area --A i H sa float po zadanie ot tablicata, no e po-dobre da pisha 2.0!!!!
	   --zashtoto ako utre nqkoj smeni typa ot fload na int, pak shte mi raboti formulata s 2.0!!!
	   (A*H)/2.0 AS Area
  FROM Triangles2

SELECT 9 % 6 --> 3

SELECT PI() *2 -->6.28318530717959

SELECT ABS(-45) -->45

SELECT Id, X1,X2,Y1,Y2,SQRT(SQUARE(X1-X2) + SQUARE(Y1-Y2)) AS Length
  FROM Lines

SELECT POWER(CAST(2 AS BIGINT), 31) -- 2147483648



ROUND – obtains the desired precision
Negative precision rounds characters before the decimal point
ROUND(Value, Precision)

SELECT ROUND(1.2121223231, 2) --1.2100000000 --tova e float!!!!
SELECT FORMAT(1.2121223231, 'F2') --1.21 --tova e string!!!!!!
SELECT ROUND(1.2121223231, 2) + 0.1 --1.3100000000 --tova e float!!!!
SELECT ROUND(132323.2121223231, -2) + 0.1 --132300.1000000000 --tova e float!!!!


FLOOR & CEILING – return the nearest integer
	FLOOR(Value)
	CEILING(Value)

SELECT FLOOR(1.99) -->1
SELECT CEILING(1.99) -->2
SELECT CEILING(1.39) -->2

Problem: Pallets
Calculate the required number of pallets to ship each item
BoxCapacity specifies how many items can fit in one box
PalletCapacity specifies how many boxes can fit in a pallet

SELECT TOP (1000) [Id]
      ,[Name]
      ,[Quantity]
      ,[BoxCapacity]
      ,[PalletCapacity]
  FROM [Demo].[dbo].[Products]

--tova e moeto reshenie
SELECT [Id]
      ,[Name]
      ,CEILING(([Quantity] * 1.0) /([BoxCapacity]*[PalletCapacity])) AS [Number of pallets]
  FROM [Demo].[dbo].[Products]

--tova e tqhnoto reshenie
SELECT
  CEILING(
    CEILING(
      CAST(Quantity AS float) / 
      BoxCapacity) / PalletCapacity)
    AS [Number of pallets]
  FROM Products

SIGN – returns 1, -1 or 0, depending on the value of the sign--SAMO 3 resulta ima!!

SELECT SIGN(-1) --> -1
SELECT SIGN(0) -->-
SELECT SIGN(9) --> 1


RAND – gets a random float value in the range [0, 1]
If Seed is not specified, it will be assigned randomly
RAND NE E TOLKOWA POLEZEN V DB-ite
SELECT RAND() --> 0.0543293804768689 

SELECT RAND(3) --> tova e seed, ako seed-a e edin i sysht v ramkite na 1 zaqwka, to
--i chisloto, koeto shte poluchawam shte e edno i syshto!!!!!! Ako nqmam seep, to
--chisloto shte e razlichno pri vseki nov rand v ramkute na zaqwkata.

MIN, MAX, LOG, SIN, imam vsqkakwi functions!!!

Date Functions:
vinagi da si zapisvam datite v UTC universalnata chasova zona!!!1 Taka da si pazq
dannite v DB-ite, koito az si pravq.
Da razlichavam vinagi data, koqto e symbol niz, ot data kato data v DB-a!!!
Na DB-a trqbwa izrishno da mu kazwam che neshto e data!!! DB-a ne znae kakwo da 
pravi sys symbol nizowe!!!
Polzite da zapisvam neshto kato DATETIME, a ne kato symbol, e che moga da priloja 
functions posle vyrhu tezi DATETIME formati!!!1 Za string ne moga da polzwam gotowi function
za dannite v nego i da mi smqta naprimer dni ili meseci i t.n. nagotowo.
GETDATE, DATEDIFF, DATEPART, Etc.

DATEPART – extract a segment from a date as an integer
Part can be any part and format of date or time
DATEPART(Part, Date)
year, yyyy, yy		YEAR(Date)
month, mm, m		MONTH(Date)
day, dd, d			DAY(Date)

For a full list, take a look at the official documentation

SELECT TOP (1000) [ProjectID]
      ,[Name]
      --,[Description]
      ,[StartDate]
      ,[EndDate]
	  --,DATEPART(year, StartDate)
	  --,YEAR(StartDate)
	  --,DATEPART(month, StartDate)
	  --,MONTH(StartDate)
	  --,DATEPART(day, StartDate)
	  --,DAY(StartDate)
	  --,DATEPART(WEEKDAY, StartDate)
	  --,DATEPART(HOUR, StartDate)
	  --,DATEPART(WEEK, StartDate)
	  --,DATEPART(DAYOFYEAR, StartDate)
	  ,DATEPART(QUARTER, StartDate)
  FROM [SoftUni].[dbo].[Projects]

SELECT DATEPART(MONTH, '2020-03-06') -- AKO TOVA NE RABOTI, PISHA TAKA:

SELECT DATEPART(MONTH, CAST('2020-03-06' AS DATETIME2))

Problem: Quarterly Report
Prepare sales data for aggregation by displaying yearly quarter, month, year and day of sale
SELECT TOP (1000) [ProjectID]
      ,[Name]
      ,[Description]
      ,[StartDate]
      ,[EndDate]
	  ,DATEPART(QUARTER, StartDate) AS QUARTER
	  ,DATEPART(year, StartDate) AS YEAR
	  ,DATEPART(month, StartDate) AS MONTH
	  ,DATEPART(day, StartDate) AS DAY
  FROM [SoftUni].[dbo].[Projects]

DATEDIFF – finds the difference between two dates
DATEDIFF(Part, FirstDate, SecondDate)

Part can be any part and format of date or time
Example: Show employee experience
SELECT FirstName, LastName,
       DATEDIFF(YEAR, HireDate, '2017/01/25')
    AS [Years In Service]
  FROM Employees

SELECT TOP (1000) [ProjectID]
      ,[Name]
      ,[StartDate]
      ,[EndDate]
       ,DATEDIFF(YEAR, StartDate, EndDate) AS [Years In Work]
       ,DATEDIFF(DAY, StartDate, EndDate) AS [Days In Work]    
  FROM [Projects]
  ORDER BY [Days In Work] DESC

--DATENAME – gets a string representation of a date's part
--DATENAME(Part, Date)
--SELECT DATENAME(weekday, '2017/01/27');

SELECT TOP (1000) [ProjectID]
      ,[Name]
      ,[StartDate]
      ,[EndDate]
       ,DATENAME(weekday, StartDate) AS [Day OF WEEK]    
  FROM [Projects]

DATEADD – performs date arithmetic
Part can be any part and format of date or time
DOBAVQ NESHTO KYM DATA!!!
SELECT TOP (1000) [ProjectID]
      ,[Name]
      ,[StartDate]
      ,[EndDate]
       ,DATEADD(DAY, 10, StartDate)  --DOBAVIH 10 DNI KYM DATATA
       ,DATEADD(hour, 11110, StartDate)  --DOBAVIH 11110 hours KYM DATATA
       ,DATEADD(minute, 11, StartDate)  --DOBAVIH 11 minutes KYM DATATA
  FROM [Projects]

UPDATE Projects SET StartDate = DATEADD(minute, 5, StartDate) --dobavih 5 minuti kym vseki project!

   
GETDATE – obtains the current date and time
SELECT GETDATE()

EOMONTH – returns the last day of the month

SELECT FORMAT(GETDATE(), 'yyyy MMMM dd (dddd)', 'bg-BG'); -- 2020 юни 01 (понеделник)
SELECT FORMAT(GETDATE(), 'dddd', 'bg-BG') --понеделник

Other Functions:
CAST & CONVERT – conversion between data types--izpolzwat se glawno kogato nqkoq
function NE priema moqt type danni i se nalaga da si convertna (castna) moqt type danni
do dannite, koito functiona priema kato type na vhodniq i parameter.

CAST(Data AS NewType)
CONVERT(NewType, Data)

SELECT CAST(1.4 AS INT) --> 1

SELECT CAST(1.564 AS INT) --> 1

ISNULL – swaps NULL values with a specified default value
ISNULL(Data, DefaultValue)
SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[MiddleName]
	  ,ISNULL(MiddleName, '_')
      ,[JobTitle]
      ,[DepartmentID]
      ,[ManagerID]
      ,[HireDate]
      ,[Salary]
      ,[AddressID]
  FROM [SoftUni].[dbo].[Employees]

Example: Display “Not Finished” for projects with no EndDate
SELECT ProjectID, Name,
       ISNULL(CAST(EndDate AS varchar), 'Not Finished') --trqbwa da konvertna datata, za da moje da pishe
	   v tazi kletka string!!!
  FROM Projects

COALESCE – evaluates the arguments in order and returns the current value of the first expression that initially does not evaluate to NULL
SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value'); -->// third_value

ISNULL Pravi syshtoto kato COALESCE, no samo s 2 argumenta!!!
ISNULL(6,5) --> 6
ISNULL(NULL, 5) --> 5!!!
ISNULL i COALESCE sa kato || v JS!!!

OFFSET & FETCH – get only specific rows from the result set
Used in combination with ORDER BY for pagination - tova se naricha da naprawq paigirane!!!
t.e. trqbwa da sa ORDER BY predi da gi wzimam!!! Predi da imam paigirane, trqbwa da
imam nqkakyw vid sortirovka, za da znae kak da mi gi podredi i da mi gi dawa dannite!!

SELECT EmployeeID, FirstName, LastName
    FROM Employees
ORDER BY EmployeeID --sortirovka na elementite!!! Bez Order Nqma da me pusna da prawq OFFSET i FETCH
  OFFSET 10 ROWS --Rows to skip
   FETCH NEXT 5 ROWS ONLY --Rows to include

--PRAVQ SI EDNA SLED DRUGA ZAQWKITE da mi hodqt po stranicite taka:
str.1
  OFFSET 0 ROWS --Rows to skip
   FETCH NEXT 15 ROWS ONLY --Rows to include
str.2
  OFFSET 15 ROWS --Rows to skip
   FETCH NEXT 15 ROWS ONLY --Rows to include
str.3
  OFFSET 45 ROWS --Rows to skip
   FETCH NEXT 15 ROWS ONLY --Rows to include
i t.n.

Ranking Functions:
udobni functions, imat shantav sintaksis.
ROW_NUMBER – always generate unique values without any   gaps, even if there are ties
Ne se interesuwa dali horata vzimat edna i syshta zaplata!!!! RANK pravi razlilka v towa
dali hora ima s ednakvi zaplati!!!
ako 2-ma sa s ednakvi zaplati i toj gi sloji na 5-to i 6-to mqsto, a sledwashtiq
sled tqh e na 7-mo!!! 

SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees
ORDER BY Salary DESC

SELECT EmployeeID, FirstName, LastName, Salary
	, ROW_NUMBER() OVER(ORDER BY Salary DESC) --sortnati po Salary koj im e nomera -> izkarwam go 
	--v otdelna kolona
    FROM Employees
ORDER BY Salary DESC--sortnati po Salary -> tozi nomer syvpada s nomera ot nowata kolona!!!

SELECT EmployeeID, FirstName, LastName, Salary
	, ROW_NUMBER() OVER(ORDER BY Salary DESC) --sortiram gi po zaplata koj na koe mqsto e!
    --vzimam rank na employee sprqmo zaplatata mu i go pisha kato int v otdelna column!!!
	FROM Employees
ORDER BY EmployeeID DESC --tablicata podrejdam po id na employeer-ite!!!

RANK – can have gaps in its sequence and when values are the same, they get the same rank
ako 2-ma sa s ednakvi zaplati i toj gi sloji i dvamata na 6-to mqsto, to sledwashtiq
sled tqh e na 8-mo mqsto, a ne na 7-mo!!! 
SELECT EmployeeID, FirstName, LastName, Salary
	, ROW_NUMBER() OVER(ORDER BY Salary DESC)
	, RANK() OVER(ORDER BY Salary DESC)
	FROM Employees
ORDER BY EmployeeID DESC

DENSE_RANK – returns the same rank for ties, but it doesn’t have any gaps in the sequence
ako 2-ma sa s ednakvi zaplati i toj gi sloji i dvamata na 6-to mqsto, to sledwashtiq
sled tqh e na 7-mo mqsto, a ne na 8-mo!!!  Towa e plyten (Dense) RANK!!!!
SELECT EmployeeID, FirstName, LastName, Salary
	, ROW_NUMBER() OVER(ORDER BY Salary DESC)
	, RANK() OVER(ORDER BY Salary DESC)
	, DENSE_RANK() OVER(ORDER BY Salary DESC)
	FROM Employees
ORDER BY EmployeeID DESC

NTILE – Distributes the rows in an ordered partition into a specified number of groups
podrejda mi v grupi, kolkoto az mu kaja broj grupi, v koito sa sybrani horata po zaplata
v namalqwasht red!!! S naj-visokite zaplati sa horata ot grupa 1!!!! A naj-niskite
zaplati sa v grupa 10!!!!
SELECT EmployeeID, FirstName, LastName, Salary
	, ROW_NUMBER() OVER(ORDER BY Salary DESC)
	, RANK() OVER(ORDER BY Salary DESC)
	, DENSE_RANK() OVER(ORDER BY Salary DESC)
	, NTILE(10) OVER(ORDER BY Salary DESC)
	FROM Employees
ORDER BY EmployeeID DESC

Vinagi kogato v edin SELECT SQL ne mi dawa da pravq neshto, to tozi SELECT
stawa FROM-a na nov SELECT!!!

--tova minava, ako sloja ORDER BY naj-nakraq, a ako ORDER BY e predi Where, ne stawa, syshto ne stava i ako ORDER BY e predi ) AS TemlResult
SELECT * 
	FROM (SELECT EmployeeID, FirstName, LastName, Salary
			, ROW_NUMBER() OVER(ORDER BY Salary DESC)
			, RANK() OVER(ORDER BY Salary DESC)
			, DENSE_RANK() OVER(ORDER BY Salary DESC)
			, NTILE(10) OVER(ORDER BY Salary DESC) AS GroupNo
			FROM Employees) AS TempResult
	WHERE GroupNo = 9 --vzimam samo 9-ta grupa!!!
	ORDER BY Salary DESC

--towa e syshtoto kato gornoto, no to minawa s ORDER BY vytre v nestnatiq SELECT!!! Towa minawa taka, zashtoto izpolzwam TOP(1000), 
--ako dam che iskam vsichki, ne minava i mi iska TOP, OFFSET ili FOR XML!!!!
SELECT * 
	FROM (	SELECT TOP (1000) [EmployeeID]
				,[FirstName]
				,[LastName]
				,[Salary]
				, ROW_NUMBER() OVER(ORDER BY Salary DESC) AS RowNumber
				, RANK() OVER(ORDER BY Salary DESC) AS RANK
				, DENSE_RANK() OVER(ORDER BY Salary DESC) AS DenseRank
				, NTILE(10) OVER(ORDER BY Salary DESC) AS GroupNo
				FROM [SoftUni].[dbo].[Employees]
				ORDER BY Salary DESC) AS TempResult
	WHERE GroupNo = 9--vzimam samo 9-ta grupa!!!

SELECT EmployeeID, FirstName, LastName, Salary
	, ROW_NUMBER() OVER(ORDER BY Salary DESC)
	, RANK() OVER(ORDER BY Salary DESC)
	, DENSE_RANK() OVER(ORDER BY Salary DESC)
	, NTILE(10) OVER(ORDER BY Salary DESC) AS GroupNo
	, SUM(Salary) OVER(ORDER BY Salary DESC) AS SumSalary --poluchavam akumulirana suma na vseki red sys sledwashtiq i t.n. do kraq!!!
	, AVG(Salary) OVER(ORDER BY Salary DESC) AS AvgSalary --poluchavam srednata zaplata do momenta i t.n. do kraq!!!
	, MIN(Salary) OVER(ORDER BY DepartmentID DESC) AS MinSalary --poluchavam min zaplata za otdela, v kojto raboti choveka!!!
	FROM Employees
ORDER BY Salary DESC

Wildcards:
Selecting Results by Partial Match
Using WHERE … LIKE
Wildcards are used with WHERE for partial filtration
Similar to Regular Expressions, but less capable
Example: Find all employees who's first name starts with "Ro"'

SELECT EMployeeId, FirstName, LastName
  FROM Employees
 WHERE FirstName LIKE 'Ro%' --Ro% e Wildcard symbol

SELECT EmployeeID, FirstName, LastName, Salary, JobTitle
	, ROW_NUMBER() OVER(ORDER BY Salary DESC)
	, RANK() OVER(ORDER BY Salary DESC)
	, DENSE_RANK() OVER(ORDER BY Salary DESC)
	, NTILE(10) OVER(ORDER BY Salary DESC) AS GroupNo
	, SUM(Salary) OVER(ORDER BY Salary DESC) AS SumSalary --poluchavam akumulirana suma na vseki red sys sledwashtiq i t.n. do kraq!!!
	, AVG(Salary) OVER(ORDER BY Salary DESC) AS AvgSalary --poluchavam srednata zaplata do momenta i t.n. do kraq!!!
	, MIN(Salary) OVER(ORDER BY DepartmentID DESC) AS MinSalary --poluchavam min zaplata za otdela, v kojto raboti choveka!!!
	FROM Employees
--WHERE FirstName LIKE 'Ro%' --Ro% e Wildcard symbol -- neshto koeto da zapochva s Ro
--WHERE JobTitle LIKE '%Chief%' --neshto, koeto ima kydeto i da e iz nego Chief
--WHERE JobTitle LIKE '%Manager' --neshto koeto zavyrshva na Manager
--WHERE JobTitle LIKE '[EFSR]%Manager' --neshto koeto zavyrshva na Manager no zapochva s E, F, S ili R!!!
WHERE JobTitle LIKE '[^EFSR]%Manager' --neshto koeto zavyrshva na Manager no da NE zapochva s E, F, S ili R!!!
WHERE JobTitle LIKE '%Manager' ESCAPE % --neshto koeto zavyrshva na %Manager, t.e. escape-vam % i toj veche ne e specialen symbol, a se tyrsi da go ima v zapisa!!!
ORDER BY Salary DESC

--imam  NOT LIKE, nqmam ! LIKE

Wildcard Characters:
Supported characters include:
%    -- any string, including zero-length
_    -- any single character
[…]  -- any character within range
[^…] -- any character not in the range	

ESCAPE – specify a prefix to treat special characters as normal
SELECT ID, Name
  FROM Tracks
 WHERE Name LIKE '%max!%' ESCAPE '!'

Summary:
Various built-in functions:
String functions - CONCAT, LEFT/RIGHT, REPLACE, etc.
Math functions - PI, ABS, POWER, ROUND, etc.
Date functions - DATEPART, DATEDIFF, GETDATE, etc.
Using Wildcards, we can obtain results by partial string matches





--HOMEWORK Built-in Functions:
--Problem 1.	Find Names of All Employees by First Name
USE SoftUni
