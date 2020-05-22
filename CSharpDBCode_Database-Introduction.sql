-- Problem from 1 to 6:
CREATE DATABASE Minions

USE Minions --taka mu kazwam da polzwa tazi DB bez da e nujno da izbiram ot gore

CREATE TABLE Minions (
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Age TINYINT,
)

CREATE TABLE Towns (
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
)

ALTER TABLE Minions 
	ADD TownId INT NOT NULL --add new column in table

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id) -- Minions.TownId => Towns.Id

--gornite mojeha da se zapishat zaedno taka:
ALTER TABLE Minions
	ADD TownId INT NOT NULL FOREIGN KEY REFERENCES Towns(Id)

INSERT INTO Towns(Id, [Name]) --vkarvam danni v gotovata table
	VALUES
			(1, 'Sofia'),
			(2, 'Plovdiv'),
			(3, 'Varna')

SELECT Id, [Name] FROM Towns

INSERT INTO Minions(Id, [Name], Age, TownId) --vkarvam danni v gotovata table
	VALUES
			(1, 'Kevin', 22, 1),
			(2, 'Bob', 15, 3),
			(3, 'Stewand', NULL, 2)

SELECT * FROM Minions
SELECT * FROM Towns

TRUNCATE TABLE Minions -- iztrih vsichki redove ot table Minions, no tablicata si ostana

DROP TABLE Minions -- iztrih table Minions

DROP TABLE Towns

DROP DATABASE Minions --i kraj s DB-a.



-- Problem 7:
CREATE TABLE People (
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(2048),
	Height DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) CHECK (Gender = 'm' OR Gender ='f') NOT NULL,
	Birthdate DATE NOT NULL,
	Biography TEXT
)

INSERT INTO People
	VALUES 
			('Paulina', NULL, 1.58, 55, 'f', '1978-01-27', 'So hudge...'),
			('Ivan', NULL, 1.48, 55, 'm', '2020-05-18', 'The best son'),
			('Paulina2', NULL, 2.58, 55, 'f', '2978-01-27', 'Mathematic'),
			('Paulina3', NULL, 3.58, 55, 'f', '3978-01-27', 'Engineer'),
			('Paulina4', NULL, 4.58, 55, 'f', '4978-01-27', 'Programer')


-- Problem 8:
CREATE TABLE Users (
	Id BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX) CHECK (DATALENGTH(ProfilePicture) <= 900 * 1024),
	LastLonginTime DATETIME2,
	IsDeleted BIT NOT NULL
)

INSERT INTO Users
	VALUES 
			--('Paulina1', 'Pass1', NULL,'2020-05-20 16:30:24', 1),
			--('Paulina2', 'Pass1', NULL,'2020-05-20 16:30:24', 0),
			--('Paulina3', 'Pass1', NULL,'2020-05-20 16:30:24', 1),
			--('Paulina4', 'Pass1', NULL,'2020-05-20 16:30:24', 0),
			('Paulina5', 'Pass1', NULL,'2020-05-20 16:30:24', 1)

DELETE FROM Users WHERE Id = 3

SELECT * FROM Users

SET IDENTITY_INSERT Users ON

INSERT INTO Users(Id, Username, [Password], LastLonginTime, IsDeleted)
	VALUES 
			(3, 'Paulina3', 'Pass1','2020-05-20 16:30:24', 1)

SET IDENTITY_INSERT Users OFF

-- Problem 9:
ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC07F9493872] --iztrih PK na tablicata

ALTER TABLE Users
ADD CONSTRAINT PK_Users_CompositeIdUsername
PRIMARY KEY(Id, Username)

-- Problem 10:
ALTER TABLE Users
ADD CONSTRAINT CK_Users_PasswordLength
CHECK (len([Password]) >= 5)

INSERT INTO Users 
	VALUES 
			( 'Paulina321', 'Pas',NULL,'2020-05-20 16:30:24', 1)

--ALTER TABLE Users
--DROP CONSTRAINT CK_Users_PasswordLength

-- Problem 11:
ALTER TABLE Users
ADD CONSTRAINT DK_Users_LastLoginTime
DEFAULT getdate() FOR LastLonginTime;

SELECT * FROM Users

INSERT INTO Users (Username, [Password], IsDeleted)
	VALUES 
			( 'Paulina3221', 'Passss', 1)

-- Problem 12:
ALTER TABLE Users
DROP CONSTRAINT PK_Users_CompositeIdUsername

ALTER TABLE Users
ADD CONSTRAINT PK_Users_Id
PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT CH_Users_UserName
CHECK (len(UserName) >=3)

ALTER TABLE Users
ADD CONSTRAINT UC_Users_Username
UNIQUE (Username)

INSERT INTO Users (Username, [Password], IsDeleted)
	VALUES 
			( 'Paulina3221', 'Passss', 1)

-- Problem 13:

CREATE DATABASE Movies

CREATE TABLE Directors (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	DirectorName nvarchar(200) NOT NULL,
	Notes ntext
)

INSERT INTO Directors
	VALUES 
		('Director1', 'notes'),
		('Director2', 'notes'),
		('Director3', 'notes'),
		('Director4', 'notes'),
		('Director5', 'notes')

CREATE TABLE Genres (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	GenreName nvarchar(200) NOT NULL,
	Notes ntext
)

INSERT INTO Genres
	VALUES 
		('Genres1', 'notes'),
		('Genres2', 'notes'),
		('Genres3', 'notes'),
		('Genres4', 'notes'),
		('Genres5', 'notes')

CREATE TABLE Categories (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CategoryName nvarchar(200) NOT NULL,
	Notes ntext
)

INSERT INTO Categories
	VALUES 
		('Categories1', 'notes'),
		('Categories2', 'notes'),
		('Categories3', 'notes'),
		('Categories4', 'notes'),
		('Categories5', 'notes')

CREATE TABLE Movies (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Title nvarchar(200) NOT NULL,
	DirectorId int NOT NULL,
	CopyrightYear int,
	[Length] time,
	GenreId int NOT NULL,
	CategoryId int NOT NULL,
	Rating int,
	Notes ntext
)

INSERT INTO Movies
	VALUES 
		('Movies1', 4, '2024', '4:45', 4, 4, 40, 'notes'),
		('Movies2', 1, '2021', '1:45', 1, 1, 10, 'notes'),
		('Movies3', 5, '2025', '5:45', 5, 5, 50, 'notes'),
		('Movies4', 2, '2022', '2:45', 2, 2, 20, 'notes'),
		('Movies5', 3, '2023', '3:45', 3, 3, 30, 'notes')

DROP DATABASE Movies


-- Problem 14



CREATE DATABASE CarRental

CREATE TABLE Categories (
	Id int IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	CategoryName nvarchar(30) UNIQUE NOT NULL, 
	DailyRate decimal(7,2) NOT NULL, 
	WeeklyRate decimal(7,2) NOT NULL,
	MonthlyRate decimal(7,2) NOT NULL,
	WeekendRate decimal(7,2) NOT NULL
)

--ALTER TABLE Categories
--ADD CONSTRAINT UC_CategoryName
--UNIQUE (CategoryName)

INSERT INTO Categories
		VALUES
				('E1', 50, 300, 1100, 200),
				('E11', 150, 1300, 11100, 1200),
				('E111', 250, 2300, 21100, 2200)

CREATE TABLE Cars (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL, 
	PlateNumber varchar(8) UNIQUE NOT NULL, 
	Manufacturer nvarchar(30), 
	Model nvarchar(30), 
	CarYear int, 
	CategoryId int FOREIGN KEY REFERENCES Categories(Id) NOT NULL, 
	Doors int, 
	Picture varbinary(max), 
	Condition ntext, 
	Available bit NOT NULL
)

--ALTER TABLE Cars
--ADD CONSTRAINT UC_PlateNumber
--UNIQUE (PlateNumber)

INSERT INTO Cars
		VALUES
				('XV1234NM', 'NYUNDAY', 'I20', 2015, 1, 5, NULL, 'NICE AND NEW', 1),
				('XV0234NM', 'NYUNDAY', 'I20', 2015, 3, 5, NULL, 'NICE AND NEW', 1),
				('XV4234NM', 'NYUNDAY', 'I20', 2015, 2, 5, NULL, 'NICE AND NEW', 1)

CREATE TABLE Employees (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName nvarchar(50) NOT NULL, 
	MiddleName nvarchar(50), 
	LastName nvarchar(50) NOT NULL, 
	Title nvarchar(50) NOT NULL, 
	Notes ntext
)

INSERT INTO Employees
		VALUES
				('Ivan', 'Ivanov', 'Ivanov','.NET Developer', NULL),
				('Petar', 'Petrov', 'Petrov', 'Senior Engineer', NULL),
				('Maria', 'Petrova', 'Ivanova', 'Intern',  NULL)

CREATE TABLE Customers (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL, 
	DriverLicenceNumber int NOT NULL, 
	FullName nvarchar(200) NOT NULL, 
	[Address] nvarchar(100), 
	City nvarchar(50), 
	ZIPCode int, 
	Notes ntext
)
	
INSERT INTO Customers
		VALUES			
				(1234567, 'Peter Pan', 'bul. Svoboda 60', 'Sofia', 1000, 'Drinking too much'),
				(23242342, 'Georgi Terziev', 'bul. Pobeda 60', 'Plovdiv', 4000, 'Drinking too little'),
				(564564564, 'Pesho Peshev', 'bul. Moon 60', 'Sredetc', 1000, 'Driving perfect')

CREATE TABLE RentalOrders (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL, 
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id) NOT NULL, 
	CustomerId int FOREIGN KEY REFERENCES Customers(Id) NOT NULL, 
	CarId int FOREIGN KEY REFERENCES Cars(Id) NOT NULL, 
	TankLevel int NOT NULL, 
	KilometrageStart int NOT NULL, 
	KilometrageEnd int NOT NULL, 
	TotalKilometrage int NOT NULL, 
	StartDate date NOT NULL, 
	EndDate date NOT NULL, 
	TotalDays int NOT NULL, 
	RateApplied int FOREIGN KEY REFERENCES Categories(Id) NOT NULL, 
	TaxRate varchar(50) NOT NULL, 
	OrderStatus nvarchar(50) NOT NULL, 
	Notes ntext
)

--ALTER TABLE RentalOrders ALTER COLUMN TaxRate varchar(50)

INSERT INTO RentalOrders
		VALUES
				(1, 1, 1, 35, 34567, 34589, 22, '2020-05-18', '2020-05-24', 6, 1, 'DailyRate', 'finished', 'Claim to be risen'),
				(2, 2, 2, 35, 34567, 34589, 22, '2020-05-18', '2020-05-24', 6, 2, 'WeekendRate', 'open', NULL),
				(3, 3, 3, 35, 34567, 34589, 22, '2020-05-18', '2020-05-24', 6, 3, 'MonthlyRate', 'RESERVED', '')


-- Problem 15, 23, 24
CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName nvarchar(50) NOT NULL, 
	LastName nvarchar(50) NOT NULL, 
	Title nvarchar(50) NOT NULL, 
	Notes ntext
)

INSERT INTO Employees
		VALUES
				('Ivan', 'Ivanov','.NET Developer', NULL),
				('Petar', 'Petrov', 'Senior Engineer', NULL),
				('Maria', 'Ivanova', 'Intern',  NULL)

CREATE TABLE Customers (
	AccountNumber int PRIMARY KEY IDENTITY(1,1) NOT NULL, 
	FirstName nvarchar(50) NOT NULL, 
	LastName nvarchar(50) NOT NULL, 
	PhoneNumber varchar(30) NOT NULL,
	EmergencyName nvarchar(50),
	EmergencyNumber varchar(30),
	Notes ntext
)
	
INSERT INTO Customers
		VALUES			
				('Peter', 'Pan', '0888888888', 'Sofia Pavlova', '+35908812182', 'Drinking too much'),
				('Pesho', 'Peshev', '0888888888', 'Sofia Pavlova', '+35908812182', 'Drinking too much'),
				('Petkan', 'Panov', '0888888888', 'Sofia Pavlova', '+35908812182', 'Drinking too much')

CREATE TABLE RoomStatus (
	RoomStatus nvarchar(30) PRIMARY KEY NOT NULL, 
	Notes ntext
)

INSERT INTO RoomStatus
		VALUES
				('free', NULL),
				('busy', 'for 6 days'),
				('reserved', 'prepayed')

CREATE TABLE RoomTypes (
	RoomType nvarchar(30) PRIMARY KEY NOT NULL, 
	Notes ntext
)

INSERT INTO RoomTypes
		VALUES
				('Normal', 'nothing special'),
				('Lux', 'little special'),
				('VIP', 'very special')

CREATE TABLE BedTypes (
	BedType nvarchar(30) PRIMARY KEY NOT NULL, 
	Notes ntext
)

INSERT INTO BedTypes
		VALUES
				('Single', 'one person bed'),
				('Baby', 'little bed'),
				('Double', 'family bed')

CREATE TABLE Rooms (
	RoomNumber int PRIMARY KEY IDENTITY(1,1) NOT NULL, 
	RoomType nvarchar(30) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL, 
	BedType nvarchar(30) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
	Rate int, 
	RoomStatus nvarchar(30) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL, 
	Notes ntext
)

INSERT INTO Rooms
		VALUES
				('VIP', 'Double', 9, 'free', 'Sea view'),
				('Lux', 'Single', 9, 'free', 'Mountain view'),
				('Normal', 'Baby', 9, 'free', 'Sea view')

CREATE TABLE Payments (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL, 
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id) NOT NULL, 
	PaymentDate date NOT NULL, 
	AccountNumber int FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL, 
	FirstDateOccupied date NOT NULL, 
	LastDateOccupied date NOT NULL, 
	TotalDays int NOT NULL, 
	AmountCharged decimal(7,2) NOT NULL, 
	TaxRate decimal(5,2) NOT NULL, 
	TaxAmount decimal(5,2) NOT NULL, 
	PaymentTotal decimal(7,2) NOT NULL, 
	Notes ntext
)

INSERT INTO Payments
		VALUES
				(3, '2020-05-20', 2, '2020-05-18', '2020-05-20', 3, 345.67, 12.5, 45.67, 392.34, 'payed with card'),
				(2, '2020-05-20', 1, '2020-05-18', '2020-05-20', 3, 345.67, 12.5, 45.67, 392.34, 'payed with card'),
				(1, '2020-05-20', 3, '2020-05-18', '2020-05-20', 3, 345.67, 12.5, 45.67, 392.34, 'payed with card')

CREATE TABLE Occupancies (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL, 
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id) NOT NULL, 
	DateOccupied date NOT NULL, 
	AccountNumber int FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL, 
	RoomNumber int FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL,
	RateApplied decimal(7,2) NOT NULL, 
	PhoneCharge varchar(30),
	Notes ntext
)

INSERT INTO Occupancies
		VALUES
				(3, '2020-05-20', 2, 1, 45.67, NULL, 'with 2 children'),
				(2, '2020-05-20', 1, 3, 45.67, NULL, 'with 20 children'),
				(1, '2020-05-20', 3, 2, 45.67, NULL, 'with 1 child')

UPDATE Payments
SET TaxRate -= 0.03

SELECT TaxRate FROM Payments

TRUNCATE TABLE Occupancies


-- Problem 16 - 22
CREATE DATABASE SoftUni

USE SoftUni

CREATE TABLE Towns (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(200) NOT NULL,
)

CREATE TABLE Addresses (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	AddressText nvarchar(200) NOT NULL,
	TownId int FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Departments (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Name] nvarchar(200) NOT NULL,
)

CREATE TABLE Employees (
	Id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	FirstName nvarchar(50) NOT NULL, 
	MiddleName nvarchar(50), 
	LastName nvarchar(50) NOT NULL, 
	JobTitle nvarchar(50) NOT NULL, 
	DepartmentId int FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
	HireDate date NOT NULL, 
	Salary decimal(18,3) NOT NULL, 
	AddressId int FOREIGN KEY REFERENCES Addresses(Id)
)

INSERT INTO Towns 
		VALUES	
				('Sofia'),
				('Plovdiv'),
				('Varna'),
				('Burgas')

INSERT INTO Departments
		VALUES
				('Engineering'),
				('Sales'), 
				('Marketing'),
				('Software Development'), 
				('Quality Assurance')

INSERT INTO Employees
		VALUES
				('Ivan', 'Ivanov', 'Ivanov','.NET Developer', 4,'2013-02-01', 3500.00, NULL),
				('Petar', 'Petrov', 'Petrov',	'Senior Engineer', 1, '2004-03-02', 4000.00, NULL),
				('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, NULL),
				('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, NULL),
				('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, NULL)
				--Moga da si pravq vlojeni zaqwki kato vmykvam SQL code v dannite:
				--('Paulina', 'Pan', 'Pan', 'Intern', 
				--	(SELECT TOP 1 Id FROM Departments WHERE [Name] = 'Software Development'), 
				--	'2016-08-28', 599.88, NULL)

SELECT * FROM Towns

SELECT * FROM Departments

SELECT * FROM Employees

SELECT * FROM Towns
ORDER BY [Name] ASC

SELECT * FROM Departments
ORDER BY [Name] ASC

SELECT * FROM Employees
ORDER BY Salary DESC

SELECT [Name] FROM Towns
ORDER BY [Name] ASC

SELECT [Name] FROM Departments
ORDER BY [Name] ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

UPDATE Employees
SET Salary += Salary * 0.1

SELECT Salary FROM Employees