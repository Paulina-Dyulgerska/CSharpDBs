CREATE DATABASE School

CREATE TABLE [Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FacultyNumber] [char](6) NOT NULL,
	[Photo] [varbinary](max) NULL,
	[DateOfEnlistment] [date] NOT NULL,
	[ListOfCourses] [nvarchar](1000) NULL,
	[YearOfGraduation] [date] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)
)

CREATE TABLE Courses(
	[Id] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](20) NOT NULL,
)

CREATE TABLE CoursesStudent(
	[StudentId] [int] PRIMARY KEY NOT NULL,
	[CourseId] INT NOT NULL,
)

CREATE TABLE [dbo].Countries(
	[Id] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](50) NOT NULL UNIQUE,
)

SELECT * 
	FROM Courses
	JOIN Towns ON Courses.Id = Towns.Id
	ORDER BY CourseName

CREATE TABLE Mountains(
  MountainID INT PRIMARY KEY,
  MountainName VARCHAR(50) NOT NULL
);

CREATE TABLE Peaks(
  PeakId INT PRIMARY KEY,
  PeakName VARCHAR(50) NOT NULL,
  MountainID INT NOT NULL, --zabranqwam vryh da e bez planina
  CONSTRAINT FK_Peaks_Mountains FOREIGN KEY (MountainID) REFERENCES Mountains(MountainID)
)

CREATE TABLE Drivers(
  DriverID INT PRIMARY KEY,
  DriverName VARCHAR(50)
)

CREATE TABLE Cars(
  CarID INT PRIMARY KEY,
  DriverID INT UNIQUE, --tozi UNIQUE pravi vryzkata One-To-One - pravi One driver per Car
  CONSTRAINT FK_Cars_Drivers FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
)

--join po coposite key:
SELECT * 
FROM Table1
INNER JOIN Table2 ON Table1.Key1 = Table2.Key1 AND Table1.Key2 = Table2.Key2 AND Table1.Key3 = Table2.Key3

USE Geography

SELECT m.MountainRange, p.PeakName, p.Elevation 
	FROM Peaks AS p
	JOIN Mountains AS m ON p.MountainId = m.Id
	WHERE MountainRange = 'Rila'
	ORDER BY p.Elevation DESC

--TRIPLE TABLE JOIN:
SELECT DISTINCT PeakName, Elevation, MountainRange, ContinentName
	FROM Peaks AS p
	JOIN Mountains AS m ON p.MountainId = m.Id
	JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
	JOIN Countries AS c ON c.CountryCode = mc.CountryCode
	JOIN Continents AS cont ON c.ContinentCode = cont.ContinentCode
	--WHERE MountainRange = 'Rila'
	ORDER BY p.Elevation DESC

--primer za cascade delete i negovoto razreshavane:
CREATE TABLE Drivers(
  DriverID INT PRIMARY KEY,
  DriverName VARCHAR(50)
)

CREATE TABLE Cars(
  CarID INT PRIMARY KEY,
  DriverID INT,
  CONSTRAINT FK_Car_Driver FOREIGN KEY(DriverID) REFERENCES Drivers(DriverID) ON DELETE CASCADE
)

--Cascade Update: Example
CREATE TABLE Products(
  BarcodeId INT PRIMARY KEY,
  Name VARCHAR(50)
)

CREATE TABLE Stock(
  Id INT PRIMARY KEY,
  Barcode INT,
  CONSTRAINT FK_Stock_Products FOREIGN KEY(BarcodeId) REFERENCES Products(BarcodeId) ON UPDATE CASCADE 
)






--HOMEWORK Table Relationships
CREATE DATABASE ExercisesTR

USE ExercisesTR

--Problem 1.	One-To-One Relationship
CREATE TABLE Passports (
	PassportID INT PRIMARY KEY NOT NULL,
	PassportNumber CHAR(8) NOT NULL
);

INSERT INTO Passports(PassportID, PassportNumber)
	VALUES	(101, 'N34FG21B'),
			(102, 'K65LO4R7'),
			(103, 'ZE657QP2');

CREATE TABLE Persons (
	PersonID INT PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	Salary DECIMAL(7,2) NOT NULL,
	PassportID INT FOREIGN KEY REFERENCES Passports(PassportID) UNIQUE
);

INSERT INTO Persons(PersonID, FirstName, Salary, PassportID)
	VALUES	(1, 'Roberto', 43300.00, 102),
			(2, 'Tom',	56100.00, 103),
			(3, 'Yana', 60200.00, 101)

--vtori variant:
CREATE TABLE Passports (
	PassportID INT NOT NULL,
	PassportNumber CHAR(8) NOT NULL
);

ALTER TABLE Passports
	ADD CONSTRAINT PK_PassportID PRIMARY KEY (PassportID)

INSERT INTO Passports(PassportID, PassportNumber)
	VALUES	(101, 'N34FG21B'),
			(102, 'K65LO4R7'),
			(103, 'ZE657QP2');

CREATE TABLE Persons (
	PersonID INT NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	Salary DECIMAL(7,2) NOT NULL,
	PassportID INT UNIQUE NOT NULL
);

ALTER TABLE Persons
	ADD CONSTRAINT PK_PersonID PRIMARY KEY(PersonID)

ALTER TABLE Persons
	ADD CONSTRAINT FK_PassportID FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)

INSERT INTO Persons(PersonID, FirstName, Salary, PassportID)
	VALUES	(1, 'Roberto', 43300.00, 102),
			(2, 'Tom',	56100.00, 103),
			(3, 'Yana', 60200.00, 101)


--Problem 2.	One-To-Many Relationship
CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) NOT NULL,
	EstablishedOn DATE NOT NULL
)

CREATE TABLE Models(
	ModelID INT PRIMARY KEY IDENTITY(101,1),
	[Name] NVARCHAR(50) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers
	VALUES	('BMW', '1916-03-07'),
			('Tesla', '2003-01-01'),
			('Lada', '1966-05-01')

INSERT INTO Models
	VALUES	('X1', 1),
			('i6', 1),
			('Model S', 2),
			('Model X', 2),
			('Model 3', 2),
			('Nova', 3)


--Problem 3.	Many-To-Many Relationship
CREATE DATABASE ExercisesTR

USE ExercisesTR

CREATE TABLE Students(
	StudentID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
)

INSERT INTO Students
VALUES
('Mila'),
('Toni'),
('Ron')

CREATE TABLE Exams(
	ExamID INT IDENTITY(101,1) PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
)

INSERT INTO Exams
VALUES
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

CREATE TABLE StudentsExams(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
	CONSTRAINT PK_StudentsExams_Composite PRIMARY KEY(StudentID, ExamID)
	--moje i samo taka da naprawq compositen key: PRIMARY KEY(StudentID, ExamID)
)

INSERT INTO StudentsExams
VALUES
(1,	101),
(1,	102),
(2,	101),
(3,	103),
(2,	102),
(2,	103)

--DROP DATABASE ExercisesTR

SELECT s.[Name],e.[Name]  
	FROM StudentsExams AS se
	JOIN Students AS s ON se.StudentID = s.StudentID
	JOIN Exams AS e ON se.ExamID = e.ExamID
	ORDER BY e.[Name] DESC

-- Problem 4.	Self-Referencing 
CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY IDENTITY(101,1),
	[Name] NVARCHAR(50) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers
VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101)

--Problem 5.	Online Store Database
CREATE TABLE Cities (
	CityID INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE ItemTypes (
	ItemTypeID INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Items (
	ItemID INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(50) NOT NULL,
	ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(50) NOT NULL,
	Birthday DATE,
	CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE Orders (
	OrderID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderItems(
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
	CONSTRAINT PK_OrderItems_Composite PRIMARY KEY(OrderID, ItemID)
)


--Problem 6.	University Database
CREATE TABLE Majors (
	MajorID INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Subjects (
	SubjectID INT IDENTITY(1,1) PRIMARY KEY,
	SubjectName NVARCHAR(100) NOT NULL
)

CREATE TABLE Students (
	StudentID INT IDENTITY(1,1) PRIMARY KEY,
	StudentNumber CHAR(10) NOT NULL,
	StudentName NVARCHAR(100) NOT NULL,
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Agenda(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
	CONSTRAINT PK_AgendaStudentSubjects PRIMARY KEY (StudentID, SubjectID)
)

CREATE TABLE Payments(
	PaymentID INT IDENTITY(1,1) PRIMARY KEY,
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL(7,2) NOT NULL,
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID)
)

--Problem 9.	*Peaks in Rila
SELECT MountainRange, PeakName, Elevation FROM Peaks
	JOIN Mountains ON Peaks.MountainId = Mountains.Id
	WHERE MountainRange = 'Rila'
	ORDER BY Elevation DESC



--VIDOVE JOINs:

--vzimam vsichko v A:
SELECT * 
	FROM TableA AS A
	LEFT JOIN TableB AS B ON A.Key = B.Key

--vzimam vsichko v B:
SELECT * 
	FROM TableA AS A
	RIGHT JOIN TableB AS B ON A.Key = B.Key

--sechenie na A i B, t.e. A ∩ B
--tove se naricha INNER JOIN syshto:
SELECT * 
	FROM TableA AS A
	JOIN TableB AS B ON A.Key = B.Key

--tova e razlika na mnojestva: A\B={x| x \in A, x \notin B}
SELECT * 
	FROM TableA AS A
	LEFT JOIN TableB AS B ON A.Key = B.Key
	WHERE B.Key IS NULL

--tova e razlika na mnojestva: B\A={x| x \in B, x \notin A}
SELECT * 
	FROM TableA AS A
	RIGHT JOIN TableB AS B ON A.Key = B.Key
	WHERE A.Key IS NULL

--tova e simetrichna razlika na mnojesta: (A ∪ B) \ (A ∩ B)
SELECT * 
	FROM TableA AS A
	FULL OUTER JOIN TableB AS B ON A.Key = B.Key
	WHERE B.Key IS NULL OR A.Key IS NULL

--tova e OBEDINENIE na mnojesta: A ∪ B
SELECT * 
	FROM TableA AS A
	FULL OUTER JOIN TableB AS B ON A.Key = B.Key
