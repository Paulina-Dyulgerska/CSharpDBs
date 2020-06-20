--Database Basics MS SQL Exam – 13 October 2019

----Problem 2.	Insert
--Insert some sample data into the database. Write a query to add the following records into the corresponding tables. 
--All Ids should be auto-generated.
INSERT INTO Files([Name], Size, ParentId, CommitId)
VALUES
('Trade.idk',2598.0,1,1),
('menu.net',9238.31,2,2),
('Administrate.soshy',1246.93,3,3),
('Controller.php',7353.15,4,4),
('Find.java',9957.86,5,5),
('Controller.json',14034.87,3,6),
('Operate.xix',7662.92,7,7)

INSERT INTO Issues(Title,IssueStatus,RepositoryId,AssigneeId)
VALUES
('Critical Problem with HomeController.cs file','open',1,4),
('Typo fix in Judge.html','open',4,3),
('Implement documentation for UsersService.cs','closed',8,2),
('Unreachable code in Index.cs','open',9,8)


--Problem 3.	Update
--Make issue status 'closed' where Assignee Id is 6.
SELECT * FROM Issues WHERE AssigneeId = 6
UPDATE Issues SET IssueStatus = 'closed' WHERE AssigneeId = 6 AND IssueStatus != 'closed' 

--Problem 4.	Delete
--Delete repository "Softuni-Teamwork" in repository contributors and issues.
SELECT Id FROM Repositories r WHERE r.Name = 'Softuni-Teamwork'
SELECT * FROM RepositoriesContributors WHERE RepositoryId = (SELECT Id FROM Repositories r WHERE r.Name = 'Softuni-Teamwork')
SELECT * FROM Issues WHERE RepositoryId = (SELECT Id FROM Repositories r WHERE r.Name = 'Softuni-Teamwork')

DELETE FROM RepositoriesContributors WHERE RepositoryId = (SELECT Id FROM Repositories r WHERE r.Name = 'Softuni-Teamwork')
DELETE FROM Issues WHERE RepositoryId = (SELECT Id FROM Repositories r WHERE r.Name = 'Softuni-Teamwork')


--Problem 5.	Commits
--Select all commits from the database. Order them by id (ascending), message (ascending), repository id (ascending) 
--and contributor id (ascending).

SELECT Id, [Message], RepositoryId, ContributorId FROM Commits
ORDER BY Id, [Message], RepositoryId, ContributorId


--Problem 6.	Heavy HTML
--Select all of the files, which have size, greater than 1000, and their name contains "html". Order them by size (descending), 
--id (ascending) and by file name (ascending)

SELECT Id, [Name], Size FROM Files
WHERE Size > 1000 AND [Name] LIKE '%html%'
ORDER BY Size DESC, Id, [Name]


--Problem 7.	Issues and Users
--Select all of the issues, and the users that are assigned to them, so that they end up in the following 
--format: {username} : {issueTitle}. Order them by issue id (descending) and issue assignee (ascending).

SELECT i.Id, 
u.[Username] + ' : ' + i.Title AS IssueAssignee
FROM Issues i JOIN Users u ON i.AssigneeId = u.Id
ORDER BY Id DESC, IssueAssignee 


--Problem 8.	Non-Directory Files
--Select all of the files, which are NOT a parent to any other file. Select their size of the file and add "KB" to 
--the end of it. Order them file id (ascending), file name (ascending) and file size (descending).

--ako izpolzwam NOT IN (dadeno mnojestvo) da imam predwid, che ako v mnojestvoto ima NULL, to nishto ne e ravno na NOT IN NULL
--i nishto nqma da mi se vryshta kato rezultat ot takyv select. Za da mi vryshta koe e towa neshto, koeto e NOT IN (dadeno mnojestvo),
--trqbwa da nqmam NULL v towa mnojestvo!!!! Towa nishto ne vryshta:
SELECT * FROM Files WHERE (Id NOT IN (SELECT ParentId FROM Files))
--dokato towa vryshta tezi, koito NE sa v towa mnogojestwo:
SELECT * FROM Files WHERE (Id NOT IN (SELECT ParentId FROM Files WHERE ParentId IS NOT NULL))

SELECT 
Id,
[Name],
CONCAT(Size, 'KB') AS Size
FROM Files 
WHERE (Id NOT IN (SELECT ParentId FROM Files WHERE ParentId IS NOT NULL))


----Problem 9.	Most Contributed Repositories
--Select the top 5 repositories in terms of count of commits. Order them by commits count (descending), 
--repository id (ascending) then by repository name (ascending).

SELECT TOP(50) 
r.Id, 
r.Name, 
COUNT(*) AS Commits 
FROM Repositories r 
LEFT JOIN Commits c ON c.RepositoryId = r.Id
GROUP BY r.Id, r.Name
ORDER BY Commits DESC, r.Id, r.Name


SELECT TOP(5) 
r.Id, 
r.Name,
COUNT(*) AS Commits 
FROM Repositories r 
LEFT JOIN Commits c ON c.RepositoryId = r.Id
LEFT JOIN RepositoriesContributors rc ON rc.RepositoryId = r.Id
GROUP BY r.Id, r.Name
ORDER BY Commits DESC, r.Id, r.Name


----Problem 10.	User and Files
--Select all users which have commits. Select their username and average size of the file, which were uploaded by them. 
--Order the results by average upload size (descending) and by username (ascending).

SELECT 
u.Username,
AVG(f.Size) AS AvgSize
FROM Users u
JOIN Commits c ON c.ContributorId = u.Id
--LEFT JOIN Files f ON f.CommitId = c.Id --judge ne iskal LEFT JOIN, makar che smisyleno e po-dobre s nego.
JOIN Files f ON f.CommitId = c.Id
GROUP BY u.Id, u.Username
ORDER BY AvgSize DESC, u.Username


--Problem 11.	 User Total Commits
--Create a user defined function, named udf_UserTotalCommits(@username) that receives a username.
--The function must return count of all commits for the user:
GO
CREATE OR ALTER FUNCTION udf_UserTotalCommits(@username nvarchar(30))
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) 
			FROM Users u
			--LEFT JOIN Commits c ON c.ContributorId = u.Id --Judge ne iska s LEFT JOIN vypreki, che e po-logichen!
			LEFT JOIN Commits c ON c.ContributorId = u.Id
			where u.Username = @username);
END

SELECT dbo.udf_UserTotalCommits('ss')

SELECT dbo.udf_UserTotalCommits('UnderSinduxrein') --6


----Problem 12. Find by Extensions
--Create a user defined stored procedure, named usp_FindByExtension(@extension), that receives a files extensions.
--The procedure must print the id, name and size of the file. Add "KB" in the end of the size. Order them by id (ascending), 
--file name (ascending) and file size (descending)
GO
CREATE OR ALTER PROCEDURE usp_FindByExtension(@extension NVARCHAR(100))
AS
BEGIN TRANSACTION
	SELECT Id, [Name], CONCAT(Size, 'KB') AS Size 
		FROM Files
		WHERE RIGHT([Name], LEN(@extension)) = @extension
		ORDER BY Id, [Name], Size DESC
COMMIT

EXEC usp_FindByExtension 'txt'

