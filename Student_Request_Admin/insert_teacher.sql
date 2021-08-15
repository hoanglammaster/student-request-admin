USE [FPT_EducationSystem]
GO

DECLARE @RC int
DECLARE @UserName varchar(50)      = 'LamHV'
DECLARE @Password varchar(100)     = '$19$25$k22UeVHbPJ_RjmdoDmYJtZFdiq0wMzTuQfcwFlxQye4'
DECLARE @FirstName nvarchar(20)    = N'Hoàng'
DECLARE @MidleName nvarchar(20)    = N'Văn'
DECLARE @LastName nvarchar(20)     = N'Lâm'
DECLARE @Gender bit                =  1
DECLARE @DOB varchar(20)           = '1999/11/10'
DECLARE @AvatarName nvarchar(200)  = null
DECLARE @AvatarByte varbinary(max) = null
DECLARE @Phone varchar(20)         = '0834 481 768'
DECLARE @Email varchar(50)         = 'hoanglammaster@gmail.com'
DECLARE @Address nvarchar(300)     = N'Thanh Chương - Nghệ An'
DECLARE @Department int            = 100

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertTeacher] 
   @UserName
  ,@Password
  ,@FirstName
  ,@MidleName
  ,@LastName
  ,@Gender
  ,@DOB
  ,@AvatarName
  ,@AvatarByte
  ,@Phone
  ,@Email
  ,@Address
  ,@Department
GO


DECLARE @RC int
DECLARE @UserName varchar(50)      = 'HuyenHTM'
DECLARE @Password varchar(100)     = '$19$25$k22UeVHbPJ_RjmdoDmYJtZFdiq0wMzTuQfcwFlxQye4'
DECLARE @FirstName nvarchar(20)    = N'Hoàng'
DECLARE @MidleName nvarchar(20)    = N'Thị Minh'
DECLARE @LastName nvarchar(20)     = N'Huyền'
DECLARE @Gender bit                =  0
DECLARE @DOB varchar(20)           = '1999/03/18'
DECLARE @AvatarName nvarchar(200)  = null
DECLARE @AvatarByte varbinary(max) = null
DECLARE @Phone varchar(20)         = '0834 123 123'
DECLARE @Email varchar(50)         = 'huyenpeo123@gmail.com'
DECLARE @Address nvarchar(300)     = N'Vinh - Nghệ An'
DECLARE @Department int            = 101

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertTeacher] 
   @UserName
  ,@Password
  ,@FirstName
  ,@MidleName
  ,@LastName
  ,@Gender
  ,@DOB
  ,@AvatarName
  ,@AvatarByte
  ,@Phone
  ,@Email
  ,@Address
  ,@Department
GO

