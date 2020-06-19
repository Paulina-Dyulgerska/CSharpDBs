--HOMEWORK Triggers and Transactions

--Judge tests are in the Functions and Stored Procedures Exersice.
--Problem 14. Create Table Logs
--Create a table – Logs (LogId, AccountId, OldSum, NewSum). Add a trigger to the Accounts 
--table that enters a new entry into the Logs table every time the sum on an account changes. 
--Submit only the query that creates the trigger.
--Example
--LogId	AccountId	OldSum	NewSum
--1	1	123.12	113.12


CREATE TABLE Logs (
	LogId int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	AccountId int NOT NULL FOREIGN KEY REFERENCES Accounts(Id),
	OldSum money NOT NULL,
	NewSum money NOT NULL
)

CREATE OR ALTER TRIGGER tr_AddToLogsOnAccountUpdateTask ON Accounts
FOR UPDATE
AS
	INSERT INTO Logs(AccountId, OldSum, NewSum)
		SELECT
			i.Id AS AccountId,
			d.Balance AS OldSum,
			i.Balance AS NewSum
			FROM inserted AS i
			JOIN deleted AS d ON i.Id = d.Id
GO

UPDATE Accounts SET Balance = 1111111.12 WHERE Id = 1

EXEC usp_TransferFunds 2, 1, 122.12


----Problem 15. Create Table Emails
--Create another table – NotificationEmails(Id, Recipient, Subject, Body). Add a trigger to 
--logs table and create new email whenever new record is inserted in logs table. 
--The following data is required to be filled for each email:
--•	Recipient – AccountId
--•	Subject – “ Balancechange for account: {AccountId}”
--•	Body - “On {date} your balance was changed from {old} to {new}.”
--Submit your query only for the trigger action.
--Example
--Id		Recipient		Subject							Body
--1		1				Balance change for account: 1	On Sep 12 2016 2:09PM your balance was 
--														changed from 113.12 to 103.12.

CREATE TABLE NotificationEmails
(
	Id int IDENTITY(1,1) PRIMARY KEY, 
	Recipient int NOT NULL FOREIGN KEY REFERENCES Accounts(Id), 
	Subject nvarchar(50), 
	Body nvarchar(Max)
)

CREATE OR ALTER TRIGGER tr_AddEmailForNotInLogs
ON Logs FOR INSERT
AS
DECLARE @Subject nvarchar(50) ='Balance change for account: {AccountId}';
DECLARE @Body nvarchar(Max) = 'On {date} your balance was changed from {old} to {new}.'
	INSERT INTO NotificationEmails(Recipient, Subject, Body)
	SELECT
		i.AccountId AS Recipient,
		REPLACE(@Subject, '{AccountId}', i.AccountId) AS Subject,
		CONCAT('On ', GETDATE(), ' your balance was changed from ', i.OldSum, ' to ', i.NewSum, '.')
			AS Body
		FROM inserted AS i
GO


--Problem Problem 16. Deposit Money
--Add stored procedure usp_DepositMoney (AccountId, MoneyAmount) that deposits money to an 
--existing account. Make sure to guarantee valid positive MoneyAmount with precision up to 
--fourth sign after decimal point. The procedure should produce exact results working with 
--the specified precision.
--Example
--Here is the result for AccountId = 1 and MoneyAmount = 10.
--AccountId	AccountHolderId	Balance
--1	1	133.1200

CREATE OR ALTER PROCEDURE usp_DepositMoney (@AccountId int, @MoneyAmount money) 
AS
BEGIN TRANSACTION
	IF (@MoneyAmount <  0)
		ROLLBACK;
	IF (@MoneyAmount >= 0)
		BEGIN
		UPDATE Accounts
		SET Balance = Balance + @MoneyAmount WHERE Id = @AccountId
		END
	--SELECT [Id] AS AccountId, AccountHolderId, 
	--	FORMAT(Balance, 'F4') AS Balance FROM Accounts WHERE Accounts.Id = @AccountId
COMMIT
GO

EXEC dbo.usp_DepositMoney 1, 1000.00

--DECLARE @d money = 123.12;
--DECLARE @s decimal(18,4) = 10;
--	IF (@s >= 0)
--		BEGIN
--		SET @d = @d+@s;
--		END
--SELECT @d; --taka mi vryshta s tochnost do F2, a az iskam s F4. za da imam F4 napravih towa:
--SELECT CAST(FORMAT(1.2121223231, 'F4') AS DECIMAL(18,4))


----Problem 17. Withdraw Money
--Add stored procedure usp_WithdrawMoney (AccountId, MoneyAmount) that withdraws 
--money from an existing account. Make sure to guarantee valid positive MoneyAmount 
--with precision up to fourth sign after decimal point. The procedure should produce 
--exact results working with the specified precision.
--Example
--Here is the result for AccountId = 5 and MoneyAmount = 25.
--AccountId	AccountHolderId	Balance
--5	11	36496.2000

CREATE OR ALTER PROCEDURE usp_WithdrawMoney (@AccountId int, @MoneyAmount money)
AS
BEGIN TRANSACTION
	
	IF (@MoneyAmount < 0)
		ROLLBACK;
	
	IF ((SELECT Balance FROM Accounts WHERE Id = @AccountId) < @MoneyAmount)
		ROLLBACK;
	
	BEGIN
	UPDATE Accounts
	SET Balance = Balance - @MoneyAmount WHERE Id = @AccountId
	END
	SELECT [Id] AS AccountId, AccountHolderId, 
		FORMAT(Balance, 'F4') AS Balance FROM Accounts WHERE Accounts.Id = @AccountId
COMMIT
GO

EXEC dbo.usp_WithdrawMoney 1, 1000.00


----Problem 18. Money Transfer
--Write stored procedure usp_TransferMoney(SenderId, ReceiverId, Amount) that transfers 
--money from one account to another. Make sure to guarantee valid positive MoneyAmount 
--with precision up to fourth sign after decimal point. Make sure that the whole 
--procedure passes without errors and if error occurs make no change in the database. 
--You can use both: “usp_DepositMoney”, “usp_WithdrawMoney” (look at previous two 
--problems about those procedures). 
--Example
--Here is the result for SenderId = 5, ReceiverId = 1 and MoneyAmount = 5000.
--AccountId	AccountHolderId	Balance
--1	1	5123.12
--5	11	31521.2000

CREATE OR ALTER PROCEDURE usp_TransferMoney(@SenderId int, @ReceiverId int, @Amount money)
AS
BEGIN TRANSACTION
	IF ((SELECT COUNT(*) FROM Accounts WHERE Id = @SenderId) != 1)
		ROLLBACK;

	IF ((SELECT COUNT(*) FROM Accounts WHERE Id = @ReceiverId) != 1)
		ROLLBACK;

	IF (@Amount <=0)
		ROLLBACK;

	DECLARE @SenderBalance money = (SELECT Balance FROM Accounts WHERE @SenderId = Id)
	IF (@SenderBalance < @Amount)
		ROLLBACK;

	UPDATE Accounts SET Balance = Balance + @Amount WHERE Id = @ReceiverId;
	UPDATE Accounts SET BALANCE = Balance - @Amount WHERE Id = @SenderId;
COMMIT
GO

EXEC dbo.usp_TransferMoney 1, 19, 1111110.12


