SELECT * FROM Applications
SELECT * FROM ApplicationDetails

GO
CREATE PROCEDURE stp_InsertApplication
@Department INT, @Title NVARCHAR(500),
@StudentId INT, @Content NVARCHAR(MAX), @FileName NVARCHAR(300), @FileBytes VARBINARY(MAX)
AS
BEGIN
     DECLARE @DetailId INT;
     DECLARE @FileId INT;
     IF @FileName IS NOT NULL AND @FileBytes IS NOT NULL
          BEGIN
               INSERT INTO Files VALUES(@FileName,@FileBytes)
               SET @FileId = @@IDENTITY
          END
     ELSE
          BEGIN
               SET @FileId = NULL
          END

     INSERT INTO ApplicationDetails VALUES(@StudentId,@Content,@FileId,NULL)
     SET @DetailId = @@IDENTITY

     INSERT INTO Applications VALUES(@Department,@Title,GETDATE(),NULL,NULL,NULL,@DetailId)
END