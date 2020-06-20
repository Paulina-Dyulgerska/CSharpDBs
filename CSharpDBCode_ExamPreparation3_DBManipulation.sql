--Database Basics MS SQL Exam – 16 Apr 2019

-- Problem 2 Insert
--Insert some sample data into the database. Write a query to add the following records into the corresponding tables. 
--All Ids should be auto-generated.

INSERT INTO Planes([Name], Seats, [Range])
VALUES
('Airbus 336', 112, 5132),
('Airbus 330', 432, 5325),
('Boeing 369', 231, 2355),
('Stelt 297', 254, 2143),
('Boeing 338', 165, 5111),
('Airbus 558', 387, 1342),
('Boeing 128', 345, 5541)


INSERT INTO LuggageTypes([Type])
VALUES
('Crossbody Bag'),
('School Backpack'),
('Shoulder Bag')


--Problem 3.	Update
--Make all flights to "Carlsbad" 13% more expensive.

UPDATE Tickets SET Price = Price * 1.13 
WHERE FlightId = (SELECT Id FROM Flights WHERE Destination = 'Carlsbad')

SELECT Price FROM Flights f JOIN Tickets t ON f.Id = t.FlightId WHERE Destination = 'Carlsbad'


--Problem 4. Delete
--Delete all flights to "Ayn Halagim".

SELECT * FROM Flights WHERE Destination = 'Ayn Halagim'

SELECT * FROM Tickets t JOIN Flights f ON t.FlightId = f.Id WHERE Destination = 'Ayn Halagim'

DELETE FROM Tickets WHERE FlightId = (SELECT Id FROM Flights WHERE Destination = 'Ayn Halagim')

DELETE FROM Flights WHERE Destination = 'Ayn Halagim'


--Problem 5.	The "Tr" Planes
--Select all of the planes, which name contains "tr". Order them by id (ascending), name (ascending), 
--seats (ascending) and range (ascending)

SELECT *
FROM Planes
WHERE Planes.[Name] LIKE '%tr%'
ORDER BY Id ASC, [Name] ASC, Seats ASC, [Range] ASC


--Problem 6.	Flight Profits
--Select the total profit for each flight from database. Order them by total price (descending), flight id (ascending).

SELECT
f.Id, SUM(Price) AS TotalPrice
FROM Flights f
JOIN Tickets t ON f.Id = t.FlightId
GROUP BY f.Id
ORDER BY TotalPrice DESC, f.Id ASC


--Problem 7.	Passenger Trips
--Select the full name of the passengers with their trips (origin - destination). Order them by full name (ascending), 
--origin (ascending) and destination (ascending).

SELECT 
p.FirstName + ' ' + p.LastName AS FullName
,f.Origin
,f.Destination
FROM Tickets t
LEFT JOIN Passengers p ON t.PassengerId = p.Id
JOIN Flights f ON t.FlightId = f.Id
ORDER BY FullName ASC, Origin ASC, Destination ASC


--Problem 8.	Non Adventures People
--Select all people who don't have tickets. Select their first name, last name and age .Order them by age (descending), 
--first name (ascending) and last name (ascending).

SELECT 
p.FirstName, p.LastName, p.Age
FROM Passengers p
LEFT JOIN Tickets t ON p.Id = t.PassengerId
WHERE t.PassengerId IS NULL
ORDER BY Age DESC, FirstName ASC, LastName ASC


----Problem 9.	Full Info
--Select all passengers who have trips. Select their full name (first name – last name), plane name, 
--trip (in format {origin} - {destination}) and luggage type. Order the results by full name (ascending),
--name (ascending), origin (ascending), destination (ascending) and luggage type (ascending).

SELECT
p.FirstName + ' ' + p.LastName AS FullName
,pl.[Name]
,f.Origin + ' - ' + f.Destination
,lt.[Type]
FROM Passengers p 
JOIN Tickets t ON p.Id = t.PassengerId
LEFT JOIN Luggages l ON t.LuggageId = l.Id
LEFT JOIN LuggageTypes lt ON lt.Id = l.LuggageTypeId
JOIN Flights f ON t.FlightId = f.Id
JOIN Planes pl ON pl.Id = f.PlaneId
ORDER BY FullName, pl.[Name], Origin, Destination, lt.[Type]


--Problem 10.	PSP
--Select all planes with their name, seats count and passengers count. Order the results by passengers count (descending), 
--plane name (ascending) and seats (ascending) 

SELECT 
pl.[Name]
,pl.Seats
,COUNT(PassengerId) AS PassengersCount
FROM Planes pl
LEFT JOIN Flights f ON f.PlaneId = pl.Id
LEFT JOIN Tickets t ON t.FlightId = f.Id
LEFT JOIN Passengers p ON t.PassengerId = p.Id
GROUP BY pl.Id, pl.Name, pl.Seats
ORDER BY PassengersCount DESC, pl.[Name], pl.Seats


----Problem  11.	Vacation
--Create a user defined function, named udf_CalculateTickets(@origin, @destination, @peopleCount) that receives an 
--origin (town name), destination (town name) and people count.
--The function must return the total price in format "Total price {price}"
--•	If people count is less or equal to zero return – "Invalid people count!"
--•	If flight is invalid return – "Invalid flight!"
GO
CREATE OR ALTER FUNCTION udf_CalculateTickets(@origin NVARCHAR(50), @destination NVARCHAR(50), @peopleCount INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
DECLARE @r NVARCHAR(MAX);
	IF @peopleCount <= 0
		SET @r = 'Invalid people count!';
	ELSE IF ((SELECT COUNT(Id) FROM Flights WHERE (Origin = @origin AND Destination = @destination)) = 0)
		SET @r = 'Invalid flight!';
	ELSE 
	BEGIN
		DECLARE @flightId INT = (SELECT Id FROM Flights WHERE Origin = @origin AND Destination = @destination);
		DECLARE @flightPrice DECIMAL(10,2) = (SELECT Price FROM Tickets WHERE FlightId = @flightId);
		DECLARE @totalPrice DECIMAL(10,2) = @flightPrice * @peopleCount;
		SET @r = CONCAT('Total price ', @totalPrice);
	END
	RETURN @r;
END
GO

SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', 33)
SELECT dbo.udf_CalculateTickets('Invalid','Rancabolang', 33)
SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', 0)
SELECT COUNT(Id) FROM Flights WHERE Origin = 'Invalid' AND Destination = 'Rancabolang'
SELECT Price FROM Tickets WHERE FlightId = 17


----Problem 12.	Wrong Data
--Create a user defined stored procedure, named usp_CancelFlights
--The procedure must cancel all flights on which the arrival time is before the departure time. Cancel means you 
--need to leave the departure and arrival time empty.
GO
CREATE OR ALTER PROCEDURE usp_CancelFlights
AS
BEGIN TRANSACTION
UPDATE Flights
SET ArrivalTime = NULL, DepartureTime = NULL
--WHERE ArrivalTime < DepartureTime --tova se iska po uslovie, no v JUDGE e zalojeno dolnoto, t.e. greshka ima v Judge.
WHERE ArrivalTime > DepartureTime
COMMIT

SELECT * FROM Flights WHERE ArrivalTime < DepartureTime

EXEC dbo.usp_CancelFlights;