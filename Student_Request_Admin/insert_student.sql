USE [FPT_EducationSystem]
GO

DECLARE @RC int
DECLARE @UserName varchar(50)      = 'NacyJM'
DECLARE @Password varchar(100)     = '$19$19$xZxvoN6lOyz4xovqOUSIX6do9OEFM_v_xP5D9cjtfg4'
DECLARE @FirstName nvarchar(20)    = 'Nancy'
DECLARE @MidleName nvarchar(20)    = 'Jewel'
DECLARE @LastName nvarchar(20)     = 'McDonie'
DECLARE @Gender bit                = 0
DECLARE @DOB varchar(20)           = '2000/04/13'
DECLARE @AvatarName nvarchar(200)  = null
DECLARE @AvatarByte varbinary(max) = null
DECLARE @Phone varchar(20)         = '0834 325 114'
DECLARE @Email varchar(50)         = 'nacy.mcdonie@gmail.com'
DECLARE @Address nvarchar(300)     = N'Daegu, South Korea'
DECLARE @Major int                 = 100
DECLARE @Father nvarchar(100)      = 'Richard Jowel McDonie'
DECLARE @FPhone varchar(20)        = null
DECLARE @FEmail varchar(50)        = null
DECLARE @FAddress nvarchar(300)    = 'Columbus, Ohio, United States'
DECLARE @Mother nvarchar(100)      = 'Lee Myeong-ju'
DECLARE @MPhone varchar(20)        = null
DECLARE @MEmail varchar(50)        = null
DECLARE @MAddress nvarchar(300)    = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertStudent] 
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
  ,@Major
  ,@Father
  ,@FPhone
  ,@FEmail
  ,@FAddress
  ,@Mother
  ,@MPhone
  ,@MEmail
  ,@MAddress
GO


DECLARE @RC int
DECLARE @UserName varchar(50)      = 'Lisa'
DECLARE @Password varchar(100)     = '$17$19$dqiCvL_u4YXGARGnCx69rpYkdjLj1YLKlY95BAJFO3E'
DECLARE @FirstName nvarchar(20)    = 'Lalisa'
DECLARE @MidleName nvarchar(20)    =  null
DECLARE @LastName nvarchar(20)     = 'Manoban'
DECLARE @Gender bit                = 0
DECLARE @DOB varchar(20)           = '1997/03/27'
DECLARE @AvatarName nvarchar(200)  = null
DECLARE @AvatarByte varbinary(max) = null
DECLARE @Phone varchar(20)         = '0972 342 345'
DECLARE @Email varchar(50)         = 'lisa.manoban@gmail.com'
DECLARE @Address nvarchar(300)     = N'Buri Ram, Thailand'
DECLARE @Major int                 = 101
DECLARE @Father nvarchar(100)      = null
DECLARE @FPhone varchar(20)        = null
DECLARE @FEmail varchar(50)        = null
DECLARE @FAddress nvarchar(300)    = null
DECLARE @Mother nvarchar(100)      = null
DECLARE @MPhone varchar(20)        = null
DECLARE @MEmail varchar(50)        = null
DECLARE @MAddress nvarchar(300)    = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertStudent] 
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
  ,@Major
  ,@Father
  ,@FPhone
  ,@FEmail
  ,@FAddress
  ,@Mother
  ,@MPhone
  ,@MEmail
  ,@MAddress
GO


DECLARE @RC int
DECLARE @UserName varchar(50)      = 'Tzuyu'
DECLARE @Password varchar(100)     = '$17$16$RMF5eFOTcLm-R1l2cyuv6_igVKuQMlOdLGvqFtWHzBc'
DECLARE @FirstName nvarchar(20)    = 'Chou'
DECLARE @MidleName nvarchar(20)    =  null
DECLARE @LastName nvarchar(20)     = 'Tzu-yu'
DECLARE @Gender bit                = 0
DECLARE @DOB varchar(20)           = '1999/06/14'
DECLARE @AvatarName nvarchar(200)  = null
DECLARE @AvatarByte varbinary(max) = null
DECLARE @Phone varchar(20)         = '0972 123 123'
DECLARE @Email varchar(50)         = 'tzuyo.chouchou@gmail.com'
DECLARE @Address nvarchar(300)     = N'East District, Taiwan'
DECLARE @Major int                 = 102
DECLARE @Father nvarchar(100)      = null
DECLARE @FPhone varchar(20)        = 'Chou Yu-cheng'
DECLARE @FEmail varchar(50)        = null
DECLARE @FAddress nvarchar(300)    = null
DECLARE @Mother nvarchar(100)      = 'Huang Yi-ling'
DECLARE @MPhone varchar(20)        = null
DECLARE @MEmail varchar(50)        = null
DECLARE @MAddress nvarchar(300)    = null

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[stp_InsertStudent] 
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
  ,@Major
  ,@Father
  ,@FPhone
  ,@FEmail
  ,@FAddress
  ,@Mother
  ,@MPhone
  ,@MEmail
  ,@MAddress
GO
