USE [FPT_EducationSystem]
GO

DECLARE @RC int
DECLARE @Department int = 100
DECLARE @Title nvarchar(500) = 'inquery for FE result'
DECLARE @StudentId int = 0
DECLARE @Content nvarchar(max) = 'In query for the result of PRJ321 - FE (1st time). I wanna check my solution again'
DECLARE @FileName nvarchar(300) = null
DECLARE @FileBytes varbinary(max) = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertApplication] 
   @Department
  ,@Title
  ,@StudentId
  ,@Content
  ,@FileName
  ,@FileBytes
GO

DECLARE @RC int
DECLARE @Department int = 100
DECLARE @Title nvarchar(500) = N'Xin miễn điểm danh'
DECLARE @StudentId int = 1
DECLARE @Content nvarchar(max) = N'Vì kỳ sau em tham gia thực tập nên muốn xin miễn điểm danh môn PRN292 ạ'
DECLARE @FileName nvarchar(300) = null
DECLARE @FileBytes varbinary(max) = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertApplication] 
   @Department
  ,@Title
  ,@StudentId
  ,@Content
  ,@FileName
  ,@FileBytes
GO

DECLARE @RC int
DECLARE @Department int = 100
DECLARE @Title nvarchar(500) = N'Attendences'
DECLARE @StudentId int = 2
DECLARE @Content nvarchar(max) = N'To day(16/7/2021) I attended in class SWT 301, but in my FAP show absent for me. I wanna check again'
DECLARE @FileName nvarchar(300) = null
DECLARE @FileBytes varbinary(max) = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertApplication] 
   @Department
  ,@Title
  ,@StudentId
  ,@Content
  ,@FileName
  ,@FileBytes
GO


DECLARE @RC int
DECLARE @Department int = 101
DECLARE @Title nvarchar(500) = N'Book a bed in Summer 2021'
DECLARE @StudentId int = 2
DECLARE @Content nvarchar(max) = N'I wanna book a bed 06 room C402L in summer 2021, how i can do? '
DECLARE @FileName nvarchar(300) = null
DECLARE @FileBytes varbinary(max) = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertApplication] 
   @Department
  ,@Title
  ,@StudentId
  ,@Content
  ,@FileName
  ,@FileBytes
GO


DECLARE @RC int
DECLARE @Department int = 101
DECLARE @Title nvarchar(500) = N'Check out my bed'
DECLARE @StudentId int = 2
DECLARE @Content nvarchar(max) = N'I wanna check out a bed 06 room C402L in summer 2021, how i can do? '
DECLARE @FileName nvarchar(300) = null
DECLARE @FileBytes varbinary(max) = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertApplication] 
   @Department
  ,@Title
  ,@StudentId
  ,@Content
  ,@FileName
  ,@FileBytes
GO
