SELECT * FROM Games g
WHERE g.[Name] = 'Safflower' --87

SELECT * FROM Users u
WHERE u.[FirstName] = 'Stamat' --9

GO
CREATE OR ALTER PROCEDURE usp_BuyItems
AS
BEGIN
DECLARE @i int = 10;
WHILE (@i<21)
BEGIN
	SET @i = @i + 1;
	
	IF (@i > 12 AND @i < 19)
		CONTINUE;
	
	BEGIN TRANSACTION --11

	DECLARE @CurrentCash money = (SELECT [Cash]
	  FROM [UsersGames]
	  WHERE GameId = 87)

	DECLARE @TotalSumForItems money = (SELECT 
	SUM(d.Price)
	FROM (SELECT Id
		  ,[Price]
		  ,[MinLevel]
			FROM  [Items]
			WHERE MinLevel in (@i)) AS d)


	IF (@TotalSumForItems > @CurrentCash)
	BEGIN
		ROLLBACK;
		THROW 50001, 'Not enought money!', 1;
	END

	UPDATE UsersGames
	SET Cash = Cash - @TotalSumForItems
	WHERE GameId = 87

	INSERT 
	INTO UserGameItems(ItemId, UserGameId) 
	SELECT Id, 87
	FROM  [Items]
	WHERE MinLevel in (@i)

	COMMIT
END;

SELECT i.[Name], i.Id AS [Item Name]
  FROM [UserGameItems] ugi
  JOIN Items i ON i.Id = ugi.ItemId
  WHERE UserGameId = 87
  ORDER BY i.[Name]
END

EXEC dbo.usp_BuyItems;

UPDATE UsersGames SET [Cash] = 11111111111 WHERE GameId = 87

DELETE FROM UserGameItems WHERE UserGameId = 87

SELECT *
	FROM  [Items]
	WHERE MinLevel in (11,12,19,20,21)
ORDER BY na