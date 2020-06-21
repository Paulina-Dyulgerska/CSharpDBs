--Database Basics MS SQL Exam – 13 October 2019 -- Final Exam

--2. Insert
--Insert some sample data into the database. Write a query to add the following records 
--into the corresponding tables. All Ids should be auto-generated.

INSERT INTO Accounts(FirstName,MiddleName,LastName,CityId,BirthDate,Email)
VALUES
('John','Smith','Smith',34,'1975-07-21','j_smith@gmail.com'),
('Gosho',NULL,'Petrov',11,'1978-05-16','g_petrov@gmail.com'),
('Ivan','Petrovich','Pavlov',59,'1849-09-26','i_pavlov@softuni.bg'),
('Friedrich','Wilhelm','Nietzsche',2,'1844-10-15','f_nietzsche@softuni.bg')

INSERT INTO Trips(RoomId,BookDate,ArrivalDate,ReturnDate,CancelDate)
VALUES
(101,'2015-04-12','2015-04-14','2015-04-20','2015-02-02'),
(102,'2015-07-07','2015-07-15','2015-07-22','2015-04-29'),
(103,'2013-07-17','2013-07-23','2013-07-24',NULL),
(104,'2012-03-17','2012-03-31','2012-04-01','2012-01-10'),
(109,'2017-08-07','2017-08-28','2017-08-29',NULL)


--3. Update
--Make all rooms’ prices 14% more expensive where the hotel ID is either 5, 7 or 9.
select * from Rooms where HotelId IN (5,7,9)
UPDATE Rooms SET Price = Price * 1.14
WHERE HotelId IN (5,7,9)


--4. Delete
--Delete all of Account ID 47’s account’s trips from the mapping table.

select * from AccountsTrips where AccountId = 47
DELETE FROM AccountsTrips WHERE AccountId = 47


--5. EEE-Mails
--Select accounts whose emails start with the letter “e”. Select their first and last name, 
--their birthdate in the format "MM-dd-yyyy", and their city name.
--Order them by city name (ascending)

SELECT
FirstName,
LastName,
FORMAT(BirthDate, 'MM-dd-yyyy') AS BirthDate,
c.[Name] AS Hometown,
Email
FROM Accounts a
LEFT JOIN Cities c ON a.CityId = c.Id
WHERE Email LIKE 'e%'
ORDER BY Hometown


----6. City Statistics
--Select all cities with the count of hotels in them. Order them by the hotel count (descending), 
--then by city name. Do not include cities, which have no hotels in them.

SELECT
c.[Name] AS City,
COUNT(*) AS Hotels
FROM Cities c
JOIN Hotels h ON h.CityId = c.Id
GROUP BY c.[Name]
ORDER BY Hotels DESC, c.[Name]


--7. Longest and Shortest Trips
--Find the longest and shortest trip for each account, in days. Filter the results to accounts 
--with no middle name and trips, which are not cancelled (CancelDate is null).
--Order the results by Longest Trip days (descending), then by Shortest Trip (ascending).

SELECT 
d.AccountId AS AccountId,
(SELECT a2.FirstName + ' ' + a2.LastName FROM Accounts as a2 WHERE d.AccountId = a2.Id) AS FullName,
MAX(d.TripDuration) AS LongestTrip,
MIN(d.TripDuration) AS ShortestTrip
FROM (
SELECT 
AccountId,
DATEDIFF(day, ArrivalDate, ReturnDate) AS TripDuration
FROM AccountsTrips at
JOIN Trips t ON at.TripId = t.Id
JOIN Accounts a ON at.AccountId = a.Id
WHERE MiddleName IS NULL AND CancelDate IS NULL
) AS d
GROUP BY d.AccountId 
ORDER BY LongestTrip DESC, ShortestTrip


--8. Metropolis
--Find the top 10 cities, which have the most registered accounts in them. 
--Order them by the count of accounts (descending).

SELECT TOP(10)
c.Id,
c.[Name] AS City,
c.CountryCode AS Country,
COUNT(a.Id) AS Accounts
FROM Cities c
JOIN Accounts a ON a.CityId = c.Id
GROUP BY c.Id, c.Name, c.CountryCode
ORDER BY Accounts DESC


--9. Romantic Getaways
--Find all accounts, which have had one or more trips to a hotel in their hometown.
--Order them by the trips count (descending), then by Account ID.

SELECT 
a.Id,
a.Email,
c.[Name] AS City,
COUNT(*) AS Trips
FROM Accounts a
JOIN AccountsTrips at ON at.AccountId = a.Id
JOIN Trips t ON t.Id = at.TripId
JOIN Rooms r ON t.RoomId = r.Id
JOIN Hotels h ON r.HotelId = h.Id
JOIN Cities c ON c.Id = a.CityId
WHERE a.CityId = h.CityId
GROUP BY a.Id, a.Email, c.[Name]
ORDER BY Trips DESC, a.Id


----10. GDPR Violation
--Retrieve the following information about each trip:
--•	Trip ID
--•	Account Full Name
--•	From – Account hometown
--•	To – Hotel city
--•	Duration – the duration between the arrival date and return date in days.
--If a trip is cancelled, the value is “Canceled”
--Order the results by full name, then by Trip ID.

SELECT 
t.Id,
CONCAT(a.FirstName,' ', (a.MiddleName + ' '), a.LastName) AS [Full Name],
c.[Name] AS [From],
cc.[Name] AS [To],
CASE
	WHEN CancelDate IS NOT NULL THEN 'Canceled'
	ELSE
		CAST(DATEDIFF(day, ArrivalDate, ReturnDate) AS nvarchar(MAX)) + ' days'
	END AS Duration
FROM Trips t 
LEFT JOIN AccountsTrips act ON act.TripId = t.Id
LEFT JOIN Accounts a ON act.AccountId = a.Id
JOIN Cities c ON a.CityId = c.Id
JOIN Rooms r ON r.id = t.RoomId
JOIN Hotels h ON r.HotelId = h.Id
JOIN Cities cc ON cc.Id = h.CityId
ORDER BY [Full Name], t.Id


----11. Available Room
--Create a user defined function, named udf_GetAvailableRoom(@HotelId, @Date, @People), 
--that receives a hotel ID, a desired date, and the count of people that are going to be signing up.
--The total price of the room can be calculated by using this formula:
--•	(HotelBaseRate + RoomPrice) * PeopleCount
--The function should find a suitable room in the provided hotel, based on these conditions:
--•	The room must not be already occupied. A room is occupied if the date the customers want to 
--book is between the arrival and return dates of a trip to that room and the trip is not canceled.
--•	The room must be in the provided hotel.
--•	The room must have enough beds for all the people.
--If any rooms in the desired hotel satisfy the customers’ conditions, find the highest priced room 
--(by total price) of all of them and provide them with that room.
--The function must return a message in the format:
--•	“Room {Room Id}: {Room Type} ({Beds} beds) - ${Total Price}”
--If no room could be found, the function should return “No rooms available”.

GO 
CREATE OR ALTER FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATE, @People INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
IF (((SELECT TOP(1) Price
		FROM Rooms r
		JOIN Trips t ON t.RoomId = r.Id
		WHERE HotelId = @HotelId AND Beds >= @People AND (@Date BETWEEN ArrivalDate AND ReturnDate)) IS NOT NULL)
		OR
		((SELECT TOP(1) Price 
		FROM Rooms r
		WHERE HotelId = @HotelId) IS NULL))
		BEGIN
			RETURN 'No rooms available';
		END

DECLARE @RoomPrice DECIMAL(15,2) = (SELECT TOP(1)
		Price
		FROM Rooms r
		JOIN Trips t ON t.RoomId = r.Id
		WHERE HotelId = @HotelId AND Beds >= @People AND (@Date NOT BETWEEN ArrivalDate AND ReturnDate)
		ORDER BY Price DESC)

DECLARE @RoomBeds INT = (SELECT TOP(1)
		Beds
		FROM Rooms r
		JOIN Trips t ON t.RoomId = r.Id
		WHERE HotelId = @HotelId AND Beds >= @People AND (@Date NOT BETWEEN ArrivalDate AND ReturnDate)
		ORDER BY Price DESC)

DECLARE @RoomType NVARCHAR(20) = (SELECT TOP(1)
		r.[Type]
		FROM Rooms r
		JOIN Trips t ON t.RoomId = r.Id
		WHERE HotelId = @HotelId AND Beds >= @People AND (@Date NOT BETWEEN ArrivalDate AND ReturnDate)
		ORDER BY Price DESC)

DECLARE @RoomId INT = (SELECT TOP(1)
		r.Id
		FROM Rooms r
		JOIN Trips t ON t.RoomId = r.Id
		WHERE HotelId = @HotelId AND Beds >= @People AND (@Date NOT BETWEEN ArrivalDate AND ReturnDate)
		ORDER BY Price DESC)

DECLARE @HotelBaseRate DECIMAL(15,2) = (SELECT TOP(1) BaseRate
		FROM Rooms r
		JOIN Hotels h ON r.HotelId = h.Id
		WHERE HotelId = @HotelId)

DECLARE @TotalPrice DECIMAL(15,2) = (@HotelBaseRate + @RoomPrice) * 2

	RETURN 
	'Room ' 
	+ CAST(@RoomId AS NVARCHAR(MAX))
	+ ': ' 
	+ CAST(@RoomType AS NVARCHAR(MAX))
	+ ' (' 
	+ CAST(@RoomBeds AS NVARCHAR(MAX))
	+ ' beds) - $' 
	+ CAST(@TotalPrice AS NVARCHAR(MAX));
END
GO

SELECT dbo.udf_GetAvailableRoom(112, '2011-12-17', 2)

SELECT dbo.udf_GetAvailableRoom(94, '2015-07-26', 3)

SELECT dbo.udf_GetAvailableRoom(1, '2015-07-26', 3)

SELECT TOP(1111) *,
		Price
		FROM Rooms r
		JOIN Trips t ON t.RoomId = r.Id
		WHERE HotelId = 1 AND Beds >= 3 AND ('2015-07-26' BETWEEN ArrivalDate AND ReturnDate)

SELECT TOP(1111) *,
		Price
		FROM Rooms r
		JOIN Trips t ON t.RoomId = r.Id
		WHERE '2015-07-26' BETWEEN ArrivalDate AND ReturnDate


----12. Switch Room
--Create a user defined stored procedure, named usp_SwitchRoom(@TripId, @TargetRoomId), 
--that receives a trip and a target room, and attempts to move the trip to the target room. 
--A room will only be switched if all of these conditions are true:
--•	If the target room ID is in a different hotel, than the trip is in, 
--raise an exception with the message “Target room is in another hotel!”.
--•	If the target room doesn’t have enough beds for all the trip’s accounts, 
--raise an exception with the message “Not enough beds in target room!”.
--If all the above conditions pass, change the trip’s room ID to the target room ID.

GO
CREATE OR ALTER PROCEDURE usp_SwitchRoom(@TripId int, @TargetRoomId int)
AS
BEGIN TRANSACTION

DECLARE @TargetRoomHotel int = (SELECT 
h.Id
FROM Rooms r
JOIN Hotels h ON h.Id = r.HotelId
WHERE r.Id = @TargetRoomId)

DECLARE @TripHotel int = (SELECT 
HotelId
FROM Trips t
JOIN Rooms r ON t.RoomId = r.Id
WHERE t.Id = @TripId)

DECLARE @BedsInTheTargetRoom INT = (SELECT 
Beds
FROM Rooms r
JOIN Hotels h ON h.Id = r.HotelId
WHERE r.Id = @TargetRoomId)

DECLARE @AccountsInTheTargetTrip INT = (SELECT COUNT(*)
FROM Trips t
JOIN Rooms r ON t.RoomId = r.Id
JOIN AccountsTrips act ON act.TripId = t.Id
WHERE t.Id = @TripId)

IF (@TargetRoomHotel != @TripHotel)
BEGIN
	ROLLBACK;
	THROW 50001, 'Target room is in another hotel!', 1;
END
ELSE IF (@BedsInTheTargetRoom < @AccountsInTheTargetTrip)
BEGIN
	ROLLBACK;
	THROW 50001, 'Not enough beds in target room!', 1;
END
ELSE
BEGIN
	UPDATE Trips SET RoomId = @TargetRoomId WHERE Trips.Id = @TripId;
END
COMMIT

EXEC usp_SwitchRoom 10, 11

SELECT RoomId FROM Trips WHERE Id = 10

UPDATE Trips SET RoomId = 10 WHERE Trips.Id = 10;

EXEC usp_SwitchRoom 10, 7

EXEC usp_SwitchRoom 10, 8