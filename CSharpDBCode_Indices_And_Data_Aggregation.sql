Indices and Data Aggregation:
How to Get Data Insights?


Pravi indexes kogato gonim byrzodejstvie v DB-a si.
iskam operacii w opredeleni koloni da sa byrzi - togawa polzwame
indexes. Naprimer - ako tyrsq mnogo chesto neshto v kolona
BirthDate - pravq index tam po tazi kolona!!!!
SQL Servera izgrajda takiwa indexes za tazi kolona - tyrsi se
byrzo po tazi kolona, kakto tyrsq byrzo v kniga po indexes
Cenata za indexes e poveche pamet, a izgrajdaneto na idexa, 
promqnata na indexa i trieneto tam - struwa poveche vreme, zashtoto
trqbwa da se izgradi i update-ne tozi index!!! Kakto indexatora v
edna kniga!!!
Vseki PK stawa avtomatichno Index!!!!
PK e clustered Index!!!
Vseki dr. index v DB-a e dopylnitelen, toj stoi izvyn tablicata
ni, a prosto indexira tablicite po adress!!!
Indexes (bez PK) stoqt izvyn tablicite!!!
Za da naprawq edna zaqwka byrza e nujno da vidq kakvo ima v
clausite j GROUP BY, WHERE, ORDER BY (toj po-malko) i da gi
naprawq na indexes - towa bi zabyrzalo zaqwkata!!!! Tova
promenq byrzodejstwieto na DB-ite!!!

Indices vs PK - PK e index!!! Vsqka druga kolona ne e Index.
Ako neshto go naprawq Unique - kolonata pak stawa Index.
Indexes se polzwat ako vidq che imam neshto obshto v zaqwkite, 
ednovremenno s towa sa bavni - togawa obshtata im kolona e
kandidat za index!!! FK syshto e kandidat za Index syshto, 
zashtoto FK-q po princip ne se pravi na INDEX. Ot druga
strana se predpolaga, che shtom e FK, az shte go polzwam chesto - zatowa
ako resha, che mi trqbwa performance, trqbwa da naprawq FK-a na
index. No da ne prekalqwam s indexite, zashtoto te mnogo namalqwat
performance na DB-a, ako se slagat nawsqkyde ili na wsqka kolona
nenujno. ako bqha universalni, to shtqha da sa by default indexirani
vsichki koloni. Indexes sa neshto kato B-Tree-a v Windows.
da procheta za B-Tree. Index moje da se pravi ot 1 kolona, no
moje da se naprawi i po composite PK, moje da se napravi index
po nqkolko koloni.
Za 1 tablica - ako e ot 5 koloni, to za neq PK + 1 Index e dobre.
Ako imam 10 koloni - 2 index-a. neshto kato na 5 koloni po 1 Index
e optimalno na praktika spored NIKI (bez da broq PK-a).
SQL pravi plan za dejstvie v/u zaqwkata i posle q izpylnqwa, no
toj vinagi prochita cqlata zqwka i sled towa precenq kak da q
izpylni i w kakyw red.

Indices:
Clustered and Non-Clustered Indexes
Indices speed up the searching of values in a certain column or group of columns:
	Usually implemented as B-trees
Indices can be built-in the table (clustered) or stored externally (non-clustered)
Adding and deleting records in indexed tables is slower!
	Indices should be used for big tables only (e.g. 50 000 rows).

JOIN, Group BY, WHERE biha se vyzpolzwali ot Indexes!!!
V momenta na napravata na Execution plana se vzimat predvid
vsichki neshta v zaqwkata barabar s Indexes.
B-Tree prilicha na BinarySearchTree.

Kak e vyzmojno neshto, koeto otnema malko poveche pamet, da mi
napravi tyrseneto po-byrzo.
DB-a bez index pravi linejno tyrsene - preravq zapisite edin sled
drug, dokato nameri kakvoto j trqbwa - towa tyrsene e bavno, dori
i za DBs, koito DBs po princip rabotqt byrzo i sa optimirani!!!
zatowa imame B-Tree ili Binary-Tree ili Indexes, koito izgrajdat
takiwa structuri, togawa dannite se podrejdat po opredelen nachin!!!
indexes pravqt podredba pri zapisvaneto na dannite i zatowa posle
lesno mi gi namirat - te sa kato Sorted Dictionary.
Binary Tree: Dannite sa podredeni s
2 childa i 1 parent, kato ot lqwo sa po-malkite danni (po-malkiq
ot dvata child-a), a ot dqsno e po-golemqit ot dvata child-a!!!
Balansiraneto na dyrvoto gubi vreme!!! Ima algorithmi za balansirane
na tezi Trees. Vseki index poddyrja po edno takowa dopylnitelno 
dyrvo!!!! DB-a habi vreme za balansirane na tezi dyrveta,zashtoto
ot vreme na wreme te se rebalansirat, kato se pravi nov zapis ili
neshto podobno, i trqbwa wreme, za da se balansirat obratno!!!!
B-Tree e podredeno i prilicha na Binary Tree. Osnovnoto zabavqne
na DB-a idwa ot cheteneto na harda!!! 
B-Tree moje da ima poveche ot 2 childa!!! Drugoto za nego e, che ne 
pazi tochni stojnosti, a intervali (ot...do) za stojnostite!!!
Ne pazi chislo naprimer, a pazi ot 1 do 10 sa tuk v tozi child!!!
Towa e razlikata s Binary Tree!!! Parenta se naricha
koren = root!!!!
B-Trees pestqt vreme za tyrsene ot chetene ot harda!!!!!
No pyk harchat vreme za da se napravqt, kakto i malko mqsto, za
da se syhranqwat!!!!
B-Tree mi dawa Log slojnost. ako imam 1 miliard zapisa, shte
mi trqbwat 30 tyrseniq, za da namerq kakwoto mi trqbwa, a inache
shte mi trqbwat 1000000000 tyrseniq, za da namerq kakwoto mi
trqbwa!!!! Da procheta za B-Trees v internet!!!
B-Tree e abstrakciq na Binary Tree!!! Binary Tree e B-Tree, koeto
e malko po-abstraktno, t.e. vdiga abstrakciqta B-Tree-a!!!
Predimstvoto na indexes se izpolzwa navsqkyde v programiraneto
za byrzo tyrsene i za indexaciq!!!!!
Vsqka tochka ot B-Tree sydyrja kakwo?
Clusteriziran index - v nego e zapisan celiq red ot DB-a!!!!
Pri neclusteriziranite indexes - pravi se referenciq kym reda
ot clustered index-a, kojto dyrzi dannite!!!!!!!!
Ima FS (file systems) koito izpolzwat B-Trees za realizirane na
fajlova sistema - FS e prosto zapisi, nie gi pipame.
Clusteriziran Index e po-byrz ot neclusteriziran index.
Neclusteriziran index ima 1 ideq po-bavno neshto zaradi towa, che
dyrji referenciq, a ne chista danna!!
Clusteriziran index e samo PK-a!!! Az ne moga da izbiram
koj da e clusteriziran ili ne, resheno e ot DB-a.
Dvuichno dyrvo da probwam da si narpawq, ili B-Tree ili 
Cherveno-Cherno tree - da si naprawq sama takowa neshto!!!
Da vidq kak da si go naprawq.
FK ne moje da se napravi na index avtomatichno pri syzdawaneto
na tablicata, a trqbwa s nov red da mu kaja, che FK-a e index!!!
Clustered Indexa se pravi avtomatichno zaedno s PK-a.
FK se syhranqwa kato otdelna structura dopylnitelno i zatowa se
kazwa non-clustered index.
1 Index e v pyti po-malyk ot samata tablica. 1 index e golqm
kolkoto e samata kolona, toj e vse edno kopie na kolonata
koqto e stanala index - tolkowa mqsto mi habi edin neclustered
index. No, clustred index e mnogo malko dopylnitelno mqsto, zashtoto
toj se zapisva vytre w samata kolona pri syzdawaneto j!!! Zatowa
v sywremenniqt svqt indexite sa evvtini ot kym razhod na pamet!!!
Problem e dobavqneto, iztriwaneto i updatevaneto na zapisi, koito
kasaqt tazi kolona, zashtoto trqbwa da se obnovi element v B-Treea
Pri nowost v zapisa, trqbwa da uvedomq tree-a da se update-ne!!!
zatowa promqnata iziskwa prenarejdane, koeto iska izvestno vreme.
pyrvonachalno syzdawaneto na index, otnema syshto vreme.
zatowa ako prekalq s indexes, to shte e mnogo kofti za vremeto
na rabota na DB-a!!!
Zatowa - ako polzwam mnogo edna kolona, tq stawa index!!!
DB-a po princip si sledi tyrseniqta mi i sam si pravi statistiki
na tyrseniqta mi!!!! Tq sama shte znae po koe se tyrsi mnogo i shte
si optimizira tyrseniqta sama!!! towa e chast ot hitrinata na DBs
s koqto te postigat golqmoto si byrzodejstwie, koeto byrzodejstwie
az ne moga da naprawq sama v zapisi v textov file!!!
vajno e tree-a da ne e izkriwen!!! wajno e B-Tree da e balansiran!!!
Ot vreme na vreme DB-a rebalansira trees, s koito raboti.
ot wreme na wreme go prawi towa tq sama, towa e Defragmentation!!!!
DB-a si pravi defragmentation, tq si go pravi sama ot vreme na vreme
za da si balansira dyrvetata, zashtoto tezi dyrveta s vremeto i 
narastvaneto na dannite, koito vkarwam v DB-a, dyrvoto se
izkriwqwa i trqwba da se prepodredi otnowo - towa e defragmentation!!!!
V syvremenniq svqt - Pod 1000000 zapisa v edna tablica ne si 
struwa da pravq indexes (ne PK-a se ima predwid tuk!!!)
Trqwba da imam mnogo zapisi, za da predobie indexa smisyl i da si
struwa cenata za negowoto poddyrjane ot DB-a!!!

Clustered Indexes:
Clustered index is actually the data itself
	Very useful for fast execution of WHERE, JOIN, ORDER BY 
	and GROUP BY clauses.
Maximum 1 clustered index per table
	If a table has no clustered index, its data rows are stored in an unordered structure (heap).

Ako tablicata si nqma PK, indexa se syhranqwa v HEAP!!!
HEAP e kato tree, no pri nego prosto naj-golemiqt zapis se
zapiswa naj-otgore. da vidq kakwo e HEAP v neta.
Da izbqgwam tablici bez PK!!!!

Na naj-dolniq red na B-Tree-a s indexes se namirat moite istinski
danni!!!!
Imam koren na dyrvoto.
Imam i PageID - towa e page ot DB-a, towa e parche ot Harda, towa
e parche ot HDD, koeto e nqkolko bytes!!!
Tozi page pokazwa kyde da otide tochno na HDD-to i ot kyde da
zapochne glavata da chete natatyk!!!!
Clustered indexa e nareden po PK-a!!! Indexite na clustered index
realno sa samite indexi izpolzwani za PK-a!!!

Non-Clustered Indexes:
Useful for fast retrieving of a single record or a range of records
Maintained in a separate structure in the DB
Tend to be much narrower than the base table
	Can locate the exact record(s) with less I/O
Has at least one more intermediate level than the clustered index
	Much less valuable if a table doesn’t have a clustered index

Pri neclustered indexes - te sa postroeni v/u nqkakyv clustered
index, kato neclustered pazi vryzka kym realnite danni, koito sa
zapisani v clustered index tree-a!!!!
Originalnite danni sa v clustered index!!!!
Non-clustered index e po-malyk kato obem ot clustered indexa,
zashtoto ne pazi realni danni, a samo referenciq!!!
Non-clustered index
A non-clustered index has pointers to the actual data rows (pointers to the clustered index if there is one).

Indices Syntax:
CREATE NONCLUSTERED INDEX IX_Employees_FirstName_LastName
ON Employees(FirstName, LastName)

Demo: Index Performance
Live Demo
Da puskam zaqwkata CHECKPOINT DBCC DROPCLEANBUFFERS - tq
chisti cash-a!!! taka sym sigurna, che pravq pylniq nabor ot 
operacii, a ne vzimam gotovi danni ot cash-a!!!

Zaradi clustered index zad PK-a, to tyrseneto po PK vinagi e
byrzo!!!!
V DB-a mili seconds sa vajni, a ne seconds!!!!

Syzdawaneto na 1 index moje i da otneme 10 seconds.
No towa e normalno, zashtoto indexa pravi tree vyrhu
milioni zapisi.
pri milioni zapisi 10 pyti po-byrzo shte se tyrsi v edna
tablica, otkolkoto kogato nqmam index!!!
V Execution plan-a na moqta zaqwka moga da vijdam ot kyde pochwa tyrseneto i kolko
struwa vsqka stypka v execution-a na moqta zaqwka!!!!
DB-ite sa taka optimalni, che da rovq w 40000000 zapisa za po-malko
ot sekunda!!!!
V URL-to na wseki address ima edno chislo, koeto mi pokazwa i
koj red v dadena tablica ima danni za tazi zaqwka, naprimer:
https://softuni.bg/trainings/2988/databases-basics-ms-sql-server-may-2020/internal#lesson-16282
tuk imam 2988- towa e ID-to na moq kurs!!!!
Naprimer DB-a na Mtel e ujasno golqma - tam se zapisvat ujasno
mnogo danni - wseki razgowor na wseki chowek!!!!
Chesto se pravqt kopiq na DB-a, za da se pravi vyzmojno DB-a
da pravi reporti i w syshtoto vreme da rabotqt drugite hora 
s DB-a, zashtoto ako pravq tyrsene,a w tozi moment nqkoj pishe neshto 
novo v DB-a, to trqbwa nanowo da se pochne tyrseneto i t.n.
Zatowa se prawi kopie na DB-a i ot nego se izwlichat golemite
reporti, a realnata DB prodyljawa da si raboti za horata
koito prevqt promeni po neq (delete, update, insert)

DROP INDEX NameOfIndex ON TableName --taka se trie index!!!!

Indexes se imenuwat s IX_NeshtoSi ili IDX_NeshtoSi
Indexes se namirat v Object Browser-a v papka Indexes!!!

Ako napravq index, kojto ne e PK, ne i FK, pak se pravqt
2 trees zad tozi index!!! 1 tree pazi clustered index, a
2-riqt tree pazi unclustered index, kojto az syzdawam i v nego
ima referencii zapisani na posledniq mu red, koito sochat kym
clustered tree-a!!!! Vinagi se pravqt 2 indexni dyrveta zad
edin unclustered index, a zad clustered index se pravi vinagi
1 B-tree!!!!

Index-a se pravi chak sled kato sym vkarala dannite!!!
ako imam mnogo inserts - slagam index-a sled kato populatena
tablicata.
Ako slojim indexes na edna colona i posle se nalaga mnogo da q
update-vam, to po-dobre da mahna index-a, da q update-na
i sled towa da go sloja otnovo!!!!
Ako vidq w SoftUni DB-a - naj-otdoly sa wsichki FK, Indexes i
t.n. neshta. Updatevaneto mnogo pyti na dyrvoto e mnogo
po-bavno ot syzdawaneto mu!!!! 

Tablicata e zapisana na harda po razprystnat nachin, nie q wijdame
tablichno, no na praktika e na otdelni parcheta ot harda!!!
I se zapisva kyde da se brykne, za da se vzemat dannite i da se
sglobi tablicata mi!!!!

Grouping:obrabotnwaneto na tablichnata informaciq i wsiwaneto na
dannite w razlichni grupi.
Consolidating Data Based On Criteria:
Grouping allows receiving data into separate groups 
based on a common property

Sled grupiraneto poluchawam po 1 red za wsqka grupa!!!
Vsichki redove se smachkwam. rezultata mi ot grupiraneto e
tolkowa na broj unikalni redove, kolkoto sa bili unikalnite
stojnosti v kolonata, po koqto sym grupirala!!!

GROUP BY allows you to get each separate group and use an "aggregate" function over it (like Average, Min or Max):
  
  SELECT e.DepartmentID 
    FROM Employees AS e
GROUP BY e.DepartmentID --Group Columns

DISTINCT allows you to get all unique values:
SELECT DISTINCT e.DepartmentID  --Unique Values
	FROM Employees AS e

Towa po koeot grupiram moga da go vzema w select-a!!!NO 
dannite ot predi grupiraneto, ne moga da go wzema!!!
Grupiraneto mi dawa da polzwam aggregirashti function vyrhu 
dannite!!! Tezi aggregirashti functions ne mogat bez grupirane.
MIN i COUNT mogat bez grouping, no te razglejdat v tozi wariant
wsichkite zapisi v kolonata kato 1 ogromna grupa!!!!
Towa ne moje da stane:
SELECT FirstName
  FROM [SoftUni].[dbo].[Employees]
  GROUP BY DepartmentID
  zashtoto ne e grupirano po FirstName!!!!
  Column 'SoftUni.dbo.Employees.FirstName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

  no moga da vzema towa, zashtoto e grupirano po DepartmentID!!!:
 SELECT DepartmentID,
	(SELECT [Name] FROM Departments AS d 
					WHERE d.DepartmentID = e.DepartmentID)
	--izmykvvam Name i nego syshto go pokazwam!!!
	--ako bqh napisala direktno Name, nqmashte da mi dade,
	--zashtoto ne e grupirano po Name. No ako bqh group
	--po DepartmentID i po Name zaedno, to, shteshe da mi gi
	--dade(vij dolnata zaqwka)!!! 
	--No e po-hitro s gornata vytreshna select
	--zaqwka da si izmykna kakwoto mi lipswa w grouping-a!!!
  FROM [Employees] AS e
  GROUP BY DepartmentID

  DepartmentID	(No column name)
1	Engineering
2	Tool Design

--towa e drugiq nachin:
 SELECT DepartmentID, Name
  FROM Departments AS e
  GROUP BY DepartmentID, Name

  DepartmentID	Name
1	Engineering
2	Tool Design


  No moga da si neshto, po koeto ne e grupirano, kato go 
  vmykna w edna vytreshna zaqwka:

  
  Kogato polzwam aggregirashti functions, naprimer MIN, COUNT,
  vyrhu Groups, to te si gledat tochnata grupa.

  moga da prawq group po nqkolko neshta ednovremenno.
  togawa nova grupa e wsqka razlichna kombinaciq ot neshtata, po
  koito grupiram!!!!

  Za razlika ot Distinct, s Group By moga da polzwam 
  aggregirashti functions, a s Distinct - ne moga da aggregiram.
  Zatowa Group e mnogo po-moshtno ot Distinct!!!
  Distinct prosto vryshta edna collection ot stojnosti!!!
  Ne moga da vzimam danni za neshto, po koeto ne sym grupirala,
  no moga da prilagam aggregirashti functions vyrhu wsichko, t.e.
  dori i vyrhu towa, vyrhu koeto NE sym grupirala.

  Ne moga towa:
  SELECT FirstName
  FROM [SoftUni].[dbo].[Employees]
  GROUP BY DepartmentID

  No moga towa:
  SELECT DepartmentID, STRING_AGG(FirstName, ' ')
  FROM [SoftUni].[dbo].[Employees]
  GROUP BY DepartmentID
  vryshta mi dannite ot kutijkite FirstName Aggregirani!!!!:
  DepartmentID	(No column name)
1	Roberto Gail Jossef Terri Michael Sharon
2	Ovidiu Janice Rob Thierry
3	Stephen Michael Linda Jillian Garrett Tsvi Pamela Shu Jose David Amy Jae Ranjit Tete Syed Rachel Lynn Brian
4	Wanida John Mary Terry Kevin Sariya Mary Jill

  SELECT DepartmentID, COUNT(*), STRING_AGG(FirstName, ' ')
  FROM [SoftUni].[dbo].[Employees]
  GROUP BY DepartmentID

  SELECT DepartmentID, COUNT(*), MIN(Salary), STRING_AGG(FirstName, ' ')
  FROM [SoftUni].[dbo].[Employees]
  GROUP BY DepartmentID
  DepartmentID	(No column name)	(No column name)	(No column name)
1	6	32700.00	Roberto Gail Jossef Terri Michael Sharon
2	4	25000.00	Ovidiu Janice Rob Thierry

Sled Group By moga da sortiram po novosyzdadenata kolona.

Problem: Departments Total Salaries
Use "SoftUni" database to create a query which prints the total sum of salaries for each department. 
Order them by DepartmentID (ascending).

--After grouping every employee by it's department we can use an aggregate function to calculate the total amount of money per group.
SELECT e.DepartmentID, 
  SUM(e.Salary) AS TotalSalary --Column Alias
FROM Employees AS e --Table Alias
GROUP BY e.DepartmentID --Group Columns
ORDER BY e.DepartmentID

Ako ima WHERE toj se izpylnqwa predi GROUP BY!!!

  SELECT DepartmentID, COUNT(*), MIN(Salary), STRING_AGG(FirstName, ' ')
  FROM [SoftUni].[dbo].[Employees]
  WHERE Salary > 100000
  GROUP BY DepartmentID

  Imam samo 1 rezultat:
  DepartmentID	(No column name)	(No column name)	(No column name)
16	1	125500.00	Ken

JOIN raboti v kombinaciq s GROUP:

SELECT d.[Name], SUM(Salary) AS TotalSalary --Column Alias
FROM Employees AS e --Table Alias
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
GROUP BY d.[Name]
ORDER BY d.[Name]

Aggregate Functions:
COUNT, SUM, MAX, MIN, AVG…
Operate over (non-empty) groups - !!!!!!!!!!!
Perform data analysis on each one
	MIN, MAX, AVG, COUNT, etc.

SELECT e.DepartmentID, 
 MIN(e.Salary) AS MinSalary
FROM Employees AS e
GROUP BY e.DepartmentID

GROUP BY NE preskacha neshta, koito sa NULL I  gi vrupira.
NO!!! Aggregate functions usually ignore NULL values.
te ignorirat NULL pri obrabotkata na dannite, v/u koito se
prilagat!!!

MIN imam v/u stringove, imam i MAX na strings.

COUNT(Salary) vryshta kolko e sumata na Nenulevite zapisi v 
dadena grupa, ne broi zapisi, koito sa v grupata no sa NULL!!!
COUNT(*) - broi kolko reda imam i toj shte vzeme brojkata
i na nullevite redove v sebe si!!! T.e. Count(*) != Count(Salary),
zashtoto ako imam rabotnik sys salary NULL, toj nqma da se otchete
ot COUNT(Salary)!!!

ako imam:
Niki Kostov
Pesho Kostov
NiKI Ivanov
Pesho Ivanov
GROUP BY FirstName -> 2 grupi imam: Niki, Pesho
GROUP BY LastName -> 2 grupi imam: Kostov, Ivanov
GROUP BY FirstName, LastName -> 4 grupi: 
									Niki Kostov
									Pesho Kostov
									NiKI Ivanov
									Pesho Ivanov

Aggregate Functions: COUNT
COUNT - counts the values in one or more grouped columns
Ignores NULL values
COUNT Syntax:
COUNT(ColumnName)

SELECT e.DepartmentID, 
	COUNT(*), 
	COUNT(DISTINCT FirstName),
	COUNT(e.Salary) AS SalaryCount
    FROM Employees AS e
GROUP BY e.DepartmentID

Note: COUNT ignores any employee with NULL salary.
zatowa imam razlichni stojnosti ot gornata zaqwka ako imam NULL
za nqkoq zaplata!!!!

COUNT(DISTINCT FirstName) -- vryshta broq unikalni imena w
dadena kolona, a ne vsichki imena v neq, kakto bi vyrnalo
COUNT(*)!!!

Izbqgwaj Subqueries - osnoven tip!!!
Ako ne mojesh da minesh s WHERE i t.n., togawa subquery

Aggregate Functions: SUM
SUM - sums the values in a column. 
SUM Syntax:
If any department has no salaries, it returns NULL.!!!!!

  SELECT e.DepartmentID,
         SUM(e.Salary) AS TotalSalary
    FROM Employees AS e
GROUP BY e.DepartmentID

Aggregate Functions: MAX
MAX - takes the largest value in a column.
MAX Syntax:
  SELECT e.DepartmentID, MAX(e.Salary) AS MaxSalary
    FROM Employees AS e
GROUP BY e.DepartmentID

SELECT e.DepartmentID, 
		MAX(e.Salary) AS MaxSalary,
		MIN(e.Salary) AS MinSalary,
		MAX(e.Salary) - MIN(e.Salary) AS Diff
    FROM Employees AS e
GROUP BY e.DepartmentID

MAX raboti s dati i strings!!!
MIN raboti s date i strings syshto!!!!
 
 Aggregate Functions: MIN
 MIN - takes the smallest value in a column. 
MIN Syntax:
  SELECT e.DepartmentID, MIN(e.Salary) AS MinSalary
    FROM Employees AS e
GROUP BY e.DepartmentID

Aggregate Functions: AVG
AVG - calculates the average value in a column. 
AVG Syntax: AVG(Salary) = SUM(Salary) / COUNT(Salary)
  SELECT e.DepartmentID, 
         AVG(e.Salary) AS AvgSalary
    FROM Employees AS e
GROUP BY e.DepartmentID


Aggregate Functions: STRING_AGG
STRING_AGG - Concatenates the values of string expressions and places separator values between them. The separator is not added at the end of string
STRING_AGG ( expression, separator ) 
  [WITHIN GROUP ( ORDER BY expression [ ASC | DESC ] )]
Expressions are converted to NVARCHAR or VARCHAR types during concatenation. Non-string types are converted to NVARCHAR type

Imame oshte mnogo aggregirashti functions:
STDEV, PERCENTILE_CONT i t.n.
GROUPING_ID - da procheta za nego
COUNT_BIG - za nad 2 miliarda zapisi da q polzwam neq.

Having:
Using Predicates While Grouping
Having Clause:
The HAVING clause is used to filter data based on aggregate values 
	We cannot use it without grouping first
Aggregate functions (MIN, MAX, SUM etc.) are executed only once
	Unlike HAVING, WHERE filters rows before aggregation

HAVING Clause: Example
Filter departments having total salary more than or equal to 15,000

  SELECT e.DepartmentID,         SUM(e.Salary) AS TotalSalary
    FROM Employees AS e
GROUP BY e.DepartmentID
  HAVING SUM(e.Salary) >= 15000

  tezi sa ednakvi:
  SELECT DepartmentID, COUNT(*)
	FROM Departments AS d
	WHERE DepartmentID > 10
	GROUP BY DepartmentID

SELECT DepartmentID, COUNT(*)
	FROM Departments AS d
	GROUP BY DepartmentID
	HAVING DepartmentID > 10

	NO!!! Ne pishem takiwa neshta, koito sa za WHERE, v 
	HAVING!!! V HAVING pishem aggregirashti functions!!!!

Sled GROUP BY ne moga da pisha WHERE. WHERE e winagi samo vyrhu
originalnata tablica!!! Zatowa ako sled Grouping mi trqbwa otnovo
Where, da si pisha HAVING!!! HAVING = WHERE, samo deto se pishe
sled GROUP BY!!!

SELECT DepartmentID, COUNT(*)
	FROM Employees AS e
	GROUP BY DepartmentID
	HAVING AVG(Salary) < 15000 AND COUNT(*) < 10


SELECT e.DepartmentID, 
	COUNT(*) AS [Count], 
	COUNT(DISTINCT FirstName),
	COUNT(e.Salary) AS SalaryCount
    FROM Employees AS e
GROUP BY e.DepartmentID
--HAVING [Count] > 10 --ne moga da q polzwam, zashtoto tazi
--kolona oshte ne e syzdadena!!!
--no moga towa:
HAVING COUNT(*) > 10
--i towa:
HAVING e.DepartmentID > 4

HAVING ne moje da ima bez GROUP BY!!!

ORDER BY vinagi e nakraq, sled HAVING!!! Zashtoto order 
podrejda krajniqt rezultat, a ne neshto drugo!!!!


Summary:
Grouping by Shared Properties
Aggregate Functions
Having Clause

SELECT 
  SUM(e.Salary) AS 'TotalSalary'
FROM Employees AS e
GROUP BY e.DepartmentID
HAVING SUM(e.Salary) >= 15000












https://www.youtube.com/watch?v=zHiWqnTWsn4 - lekciq

Ako iskam da sym dobyr developer: 
Da ucha za files, mreji, OS, windows administraciq,
mashine learning, hardware tools.

AI the modern approach - lyubima kniga book na Niki KOstov
Code Complite - kinga book da procheta, za da pisha cachestven kod

Ima machine learning neshta zalojeni v SQL Servera. 
Ima R i Phyton i s tqh moga da pravq algorithmi na Phyton
ili R za obrabotka i machine learning na tezi danni 
Mashine Learning = ML. Big Data = BD
Da cheta za ML i BD. 
BD razpredelqt dannite v/u nqkolko servera - i taka DB e
ednovremenno na nqkolko mesta!!!

Raspberry Pi 4 - mikro komputer, na kojto moga da pisha na C#!!!
I da si go karam da pravi razni neshta!!
Toj e s 8 GB RAM, 4 cores CPU i vyrhu nego moga da runna ARM
arhitektura, zashtoto mu e takyv processor-a - s ARM 
arhitektura!!! Moga da runna Obunto, Windows ARM versia syshto
Moga da runna C# code. Ima libraries Gpio C# da tyrsq.
I moga da mu kazwam - eto na towa pinche pusni tok i da zadejstwam
nqkakwa druga systema!!!!








