USE master
GO
CREATE DATABASE FPT_EducationSystem
GO
USE FPT_EducationSystem

GO
CREATE TABLE Roles(
	RoleId INT IDENTITY(1,1),
	RoleName VARCHAR(20) NOT NULL UNIQUE,
	CONSTRAINT "PK_Roles" PRIMARY KEY
	(
		"RoleId"
	)
)
CREATE TABLE Users(
	UserId INT IDENTITY(10000,1),
	UserName VARCHAR(50) NOT NULL UNIQUE,
	UserPassword VARCHAR(100) NOT NULL,
	RoleId INT NOT NULL,
	CONSTRAINT "PK_Users" PRIMARY KEY 
	(
		"UserId"
	),
	CONSTRAINT "FK_Users_Role" FOREIGN KEY
	(
		"RoleId"
	) REFERENCES "dbo"."Roles" 
	(
		"RoleId"
	) 
)

GO
CREATE FUNCTION GET_ROLE(@UserId INT)
RETURNS INT
AS
BEGIN
RETURN (SELECT RoleId FROM Users WHERE UserId = @UserId)
END;
GO

CREATE TABLE Permission(
	PermissionId INT IDENTITY(1000,1),
	PermissionName VARCHAR(100) NOT NULL,
	PermissionDetail VARCHAR(300) NULL,
	CONSTRAINT "PK_Permission" PRIMARY KEY
	(
		"PermissionId"
	)
)

CREATE TABLE Role_Permission(
	Id INT IDENTITY(1000,1),
	RoleId INT NOT NULL,
	PermissionId INT NOT NULL,
	CONSTRAINT "PK_Role_Permission" PRIMARY KEY
	(
		"Id"
	),
	CONSTRAINT "FK_RP_Roles" FOREIGN KEY
	(
		"RoleId"
	) REFERENCES "dbo"."Roles" 
	(
		"RoleId"
	),
	CONSTRAINT "FK_RP_Permission" FOREIGN KEY
	(
		"PermissionId"
	) REFERENCES "dbo"."Permission" 
	(
		"PermissionId"
	)
)

CREATE TABLE Contacts(
	ContactId INT IDENTITY(10000,1),
	Phone VARCHAR(20) NULL,
	Email VARCHAR(50) NULL,
	[Address] NVARCHAR(300) NULL,
	CONSTRAINT "PK_Contacts" PRIMARY KEY
	(
		"ContactId"
	)
)

CREATE TABLE Schools(
	SchoolId INT IDENTITY(10,1),
	SchoolName NVARCHAR(30) NOT NULL,
	SchoolContact INT NOT NULL,
	CONSTRAINT "PK_Schools" PRIMARY KEY
	(
		"SchoolId"
	),
	CONSTRAINT "FK_Schools_Contacts" FOREIGN KEY
	(
		"SchoolContact"
	) REFERENCES "dbo"."Contacts" 
	(
		"ContactId"
	)
)

--------------------------------START-DEPARTMENT--------------------------------
CREATE TABLE Departments(
	DepartmentId INT IDENTITY(100,1),
	DepartmentName VARCHAR(100) NOT NULL,
	School INT NOT NULL,
	CONSTRAINT "PK_Departments" PRIMARY KEY
	(
		"DepartmentId"
	),
	CONSTRAINT "FK_Departments_Schools" FOREIGN KEY
	(
		"School"
	) REFERENCES "dbo"."Schools" 
	(
		"SchoolId"
	)
)
--------------------------------END-DEPARTMENT--------------------------------

--------------------------------START-MAJOR--------------------------------
CREATE TABLE Majors(
	MajorId INT IDENTITY(100,1),
	MajorName VARCHAR(100) NOT NULL,
	MajorCode VARCHAR(10) NOT NULL,
	School INT NOT NULL,
	CONSTRAINT "PK_Majors" PRIMARY KEY
	(
		"MajorId"
	),
	CONSTRAINT "FK_Majors_Schools" FOREIGN KEY
	(
		"School"
	) REFERENCES "dbo"."Schools" 
	(
		"SchoolId"
	)
)


CREATE TABLE Subjects(
	SubjectId INT IDENTITY(1000,1),
	SubjectCode VARCHAR(20) NOT NULL,
	SubjectName NVARCHAR(100) NOT NULL,
	NumberCredits INT NOT NULL,
	Fee MONEY NULL,
	FeeInternational MONEY NULL,
	CONSTRAINT "PK_Subjects" PRIMARY KEY
	(
		"SubjectId"
	)
)

CREATE TABLE Curiculums(
	CuriculumId INT IDENTITY(1000,1),
	MajorId INT NOT NULL,
	SubjectId INT NOT NULL,
	CONSTRAINT "PK_Curiculums" PRIMARY KEY
	(
		"CuriculumId"
	),
	CONSTRAINT "FK_Curiculums_Majors" FOREIGN KEY
	(
		"MajorId"
	) REFERENCES "dbo"."Majors" 
	(
		"MajorId"
	),
	CONSTRAINT "FK_Curiculums_Subjects" FOREIGN KEY
	(
		"SubjectId"
	) REFERENCES "dbo"."Subjects" 
	(
		"SubjectId"
	)
)

CREATE TABLE Semesters(
	SemesterId INT IDENTITY(10,1),
	SemesterName VARCHAR(20) NOT NULL,
	StartDate DATE DEFAULT GETDATE(),
	EndDate DATE DEFAULT DATEADD(WEEK,11,GETDATE()),
	CONSTRAINT "PK_Semesters" PRIMARY KEY
	(
		"SemesterId"
	)
)

--------------------------------END-MAJOR--------------------------------
--------------------------------START-PERSON--------------------------------

CREATE TABLE Images(
	ImageId INT IDENTITY(10000,1),
	ImageName VARCHAR(100) NULL,
	ImageData VARBINARY(MAX) NOT NULL,
	CONSTRAINT "PK_Images" PRIMARY KEY
	(
		"ImageId"
	)
)

CREATE TABLE UserInformations(
	UserId INT NOT NULL,
	FirstName NVARCHAR(20) NULL,
	MidleName NVARCHAR(20) NULL,
	LastName NVARCHAR(20) NOT NULL,
	Gender BIT NOT NULL,
	DOB DATE NULL,
	Avatar INT NULL,
	Contact INT NULL,
	CONSTRAINT "PK_UserInformations" PRIMARY KEY
	(
		"UserId"
	),
	CONSTRAINT "FK_UserInformations_Users" FOREIGN KEY
	(
		"UserId"
	) REFERENCES "dbo"."Users"
	(
		"UserId"
	),
	CONSTRAINT "FK_UserInformations_Images" FOREIGN KEY
	(
		"Avatar"
	) REFERENCES "dbo"."Images" 
	(
		"ImageId"
	),
	CONSTRAINT "FK_UserInformations_Contact" FOREIGN KEY
	(
		"Contact"
	) REFERENCES "dbo"."Contacts" 
	(
		"ContactId"
	)
)



CREATE TABLE Admins(
	AdminId INT IDENTITY(10,1),
	UserId INT UNIQUE NOT NULL,
	CONSTRAINT "PK_Admins" PRIMARY KEY
	(
		"AdminId"
	),
	CONSTRAINT "FK_Admins_Users" FOREIGN KEY
	(
		"UserId"
	) REFERENCES "dbo"."Users" 
	(
		"UserId"
	),
	CONSTRAINT "Check_Role" CHECK
	(
		"dbo".GET_ROLE(UserId) = 1
	)
)

CREATE TABLE Teachers(
	TeacherId INT IDENTITY(1000,1),
	UserId INT UNIQUE NOT NULL,
	Department INT NOT NULL,
	CONSTRAINT "PK_Teachers" PRIMARY KEY
	(
		"TeacherId"
	),
	CONSTRAINT "FK_Teachers_Users" FOREIGN KEY
	(
		"UserId"
	) REFERENCES "dbo"."Users" 
	(
		"UserId"
	),
	CONSTRAINT "FK_Teachers_Departments" FOREIGN KEY
	(
		"Department"
	) REFERENCES "dbo"."Departments" 
	(
		"DepartmentId"
	),
	CONSTRAINT "Check_Role_Teacher" CHECK
	(
		"dbo".GET_ROLE(UserId) = 2
	)
)

CREATE TABLE Parents(
	ParentId INT IDENTITY(10000,1),
	FatherName NVARCHAR(100) NULL,
	FatherContact INT NULL,
	MotherName NVARCHAR(100) NULL,
	MotherContact INT NULL,
	CONSTRAINT "PK_Parents" PRIMARY KEY
	(
		"ParentId"
	),
	CONSTRAINT "FK_FParents_Contacts" FOREIGN KEY
	(
		"FatherContact"
	) REFERENCES "dbo"."Contacts" 
	(
		"ContactId"
	),
	CONSTRAINT "FK_MParents_Contacts" FOREIGN KEY
	(
		"MotherContact"
	) REFERENCES "dbo"."Contacts" 
	(
		"ContactId"
	)
)

CREATE TABLE Students(
	StudentId INT IDENTITY(0,1),
	StudentCode VARCHAR(10) NULL,
	UserId INT UNIQUE NOT NULL,
	Major INT NOT NULL,
	EnrollmentDate DATE NOT NULL DEFAULT GETDATE(),
	Parent INT NULL,
	CONSTRAINT "PK_Students" PRIMARY KEY
	(
		"StudentId"
	),
	CONSTRAINT "FK_Students_Users" FOREIGN KEY
	(
		"UserId"
	) REFERENCES "dbo"."Users" 
	(
		"UserId"
	),
	CONSTRAINT "FK_Students_Majors" FOREIGN KEY
	(
		"Major"
	) REFERENCES "dbo"."Majors" 
	(
		"MajorId"
	),
	CONSTRAINT "FK_Students_Parents" FOREIGN KEY
	(
		"Parent"
	) REFERENCES "dbo"."Parents" 
	(
		"ParentId"
	),
	CONSTRAINT "Check_Role_Student" CHECK
	(
		"dbo".GET_ROLE(UserId) = 4
	)
)

CREATE TABLE Staffs(
	StaffId INT IDENTITY(1000,1),
	UserId INT UNIQUE NOT NULL,
	Department INT NULL,
	CONSTRAINT "PK_Staffs" PRIMARY KEY
	(
		"StaffId"
	),
	CONSTRAINT "FK_Staffs_Users" FOREIGN KEY
	(
		"UserId"
	) REFERENCES "dbo"."Users" 
	(
		"UserId"
	),
	CONSTRAINT "FK_Staffs_Departments" FOREIGN KEY
	(
		"Department"
	) REFERENCES "dbo"."Departments" 
	(
		"DepartmentId"
	),
	CONSTRAINT "Check_Role_Staff" CHECK
	(
		"dbo".GET_ROLE(UserId) = 3
	)
)
--------------------------------END-PERSON--------------------------------

--------------------------------START-CLASS--------------------------------
CREATE TABLE Classes(
	ClassId INT IDENTITY(100,1),
	ClassName VARCHAR(20) NOT NULL,
	CONSTRAINT "PK_Classes" PRIMARY KEY
	(
		"ClassId"
	)
)
--class in semester
CREATE TABLE Semester_Students(
	Id INT IDENTITY(1000,1),
	Semester INT NOT NULL,
	StudentId INT NOT NULL,
	CONSTRAINT "PK_Semester_Students" PRIMARY KEY
	(
		"Id"
	),
	CONSTRAINT "FK_SemesterStudents_Semester" FOREIGN KEY
	(
		"Semester"
	) REFERENCES "dbo"."Semesters" 
	(
		"SemesterId"
	),
	CONSTRAINT "FK_SemesterStudents_Students" FOREIGN KEY
	(
		"StudentId"
	) REFERENCES "dbo"."Students" 
	(
		"StudentId"
	)
)
CREATE TABLE Class_Students(
	Id INT IDENTITY(1000,1),
	ClassId INT NOT NULL,
	Semester_Students INT NOT NULL,
	SubjectId INT NOT NULL,
	StartDate DATE DEFAULT GETDATE(),
	CONSTRAINT "PK_Class_Students" PRIMARY KEY
	(
		"Id"
	),
	CONSTRAINT "FK_ClassStudents_SemesterStudents" FOREIGN KEY
	(
		"Semester_Students"
	) REFERENCES "dbo"."Semester_Students" 
	(
		"Id"
	),
	CONSTRAINT "FK_ClassStudents_Subjects" FOREIGN KEY
	(
		"SubjectId"
	) REFERENCES "dbo"."Subjects" 
	(
		"SubjectId"
	),
	CONSTRAINT "FK_ClassStudents_Classes" FOREIGN KEY
	(
		"ClassId"
	) REFERENCES "dbo"."Classes" 
	(
		"ClassId"
	)
)


--------------------------------END-CLASS--------------------------------
--------------------------------START-NEWS--------------------------------
CREATE TABLE Files(
	FileId INT IDENTITY(10000,1),
	FilesName NVARCHAR(200) NOT NULL,
	ByteArrays VARBINARY(MAX) NOT NULL,
	CONSTRAINT "PK_Files" PRIMARY KEY
	(
		"FileId" 
	)
)

CREATE TABLE News(
	NewsId INT IDENTITY(10000,1),
	NewsTitle NVARCHAR(200) NOT NULL,
	NewsContent NVARCHAR(200) NOT NULL,
	Poster INT NOT NULL,
	CreatedDate DATETIME DEFAULT GETDATE(),
	FileAttached INT NULL,
	School INT NOT NULL,
	CONSTRAINT "PK_News" PRIMARY KEY
	(
		"NewsId" 
	),
	CONSTRAINT "FK_News_Staffs" FOREIGN KEY
	(
		"Poster"
	) REFERENCES "dbo"."Staffs" 
	(
		"StaffId"
	),
	CONSTRAINT "FK_News_Files" FOREIGN KEY
	(
		"FileAttached"
	) REFERENCES "dbo"."Files" 
	(
		"FileId"
	),
	CONSTRAINT "FK_News_Schools" FOREIGN KEY
	(
		"School"
	) REFERENCES "dbo"."Schools" 
	(
		"SchoolId"
	)
)

---------------------------------END-NEWS---------------------------------
--------------------------------START-APPLICATION--------------------------------
CREATE TABLE Applications(
	AppId INT IDENTITY(10000,1),
	Department INT NOT NULL,
	Title NVARCHAR(500) NOT NULL,
	DateCreated DATE NOT NULL DEFAULT GETDATE(),
	DateClose DATE NULL DEFAULT NULL,
	AppStatus BIT NULL DEFAULT NULL,
	Solved INT NULL DEFAULT NULL,
	CONSTRAINT "PK_Applications" PRIMARY KEY
	(
		"AppId" 
	),
	CONSTRAINT "FK_Applications_Departments" FOREIGN KEY
	(
		"Department"
	) REFERENCES "dbo"."Departments" 
	(
		"DepartmentId"
	),
	CONSTRAINT "FK_Applications_Teachers" FOREIGN KEY
	(
		"Solved"
	) REFERENCES "dbo"."Teachers" 
	(
		"TeacherId"
	)
)




CREATE TABLE ApplicationDetails(
	Id INT NOT NULL,
	Student INT NOT NULL,
	Content NVARCHAR(MAX) NOT NULL,
	FileAttached INT NULL,
	Solution NVARCHAR(MAX) NULL,
	CONSTRAINT "PK_ApplicationDetails" PRIMARY KEY
	(
		"Id" 
	),
	CONSTRAINT "FK_ApplicationDetails_Students" FOREIGN KEY
	(
		"Student"
	) REFERENCES "dbo"."Students" 
	(
		"StudentId"
	),
	CONSTRAINT "FK_ApplicationDetails_Files" FOREIGN KEY
	(
		"FileAttached"
	) REFERENCES "dbo"."Files" 
	(
		"FileId"
	),
     CONSTRAINT FK_ApplicationDetails_Applications FOREIGN KEY
	(
		"Id"
	) REFERENCES "dbo"."Applications" 
	(
		"AppId"
	)
     ON DELETE CASCADE
)


---------------------------------END-APPLICATION---------------------------------
--------------------------------START-GRADE--------------------------------
CREATE TABLE GradeCategorys(
	Id INT IDENTITY(10000,1),
	SubjectId INT NOT NULL,
	CategoryName VARCHAR(100) NOT NULL,
	Percents NUMERIC(4,1) NOT NULL,
	CONSTRAINT "PK_GradeCategorys" PRIMARY KEY
	(
		"Id"
	),
	CONSTRAINT "FK_GradeCategorys_Subjects" FOREIGN KEY
	(
		"SubjectId"
	) REFERENCES "dbo"."Subjects" 
	(
		"SubjectId"
	)
)
CREATE TABLE GradeItems(
	Id INT IDENTITY(10000,1),
	CategoryId INT NOT NULL,
	ItemName VARCHAR(100) NOT NULL,
	Persents NUMERIC(4,1) NOT NULL,
	CONSTRAINT "PK_GradeItems" PRIMARY KEY
	(
		"Id"
	),
	CONSTRAINT "FK_GradeItems_GradeCategorys" FOREIGN KEY
	(
		"CategoryId"
	) REFERENCES "dbo"."GradeCategorys" 
	(
		"Id"
	)
)

CREATE TABLE Grades(
	GradeId INT IDENTITY(10000,1),
	GradeItems INT NOT NULL, 
	Class_Student INT NOT NULL,
	Score NUMERIC(4,2)  NULL,
	CONSTRAINT "PK_Grades" PRIMARY KEY
	(
		"GradeId"
	),
	CONSTRAINT "FK_Grades_GradeItems" FOREIGN KEY
	(
		"GradeItems"
	) REFERENCES "dbo"."GradeItems" 
	(
		"Id"
	),
	CONSTRAINT "FK_Grades_ClassStudent" FOREIGN KEY
	(
		"Class_Student"
	) REFERENCES "dbo"."Class_Students" 
	(
		"Id"
	)
)

---------------------------------END-GRADE---------------------------------
--------------------------------START-CONSTRAINT--------------------------------


--------------------------------END-CONSTRAINT--------------------------------

--------------------------------START-INSERT--------------------------------
GO
----------Contact----------
--ContactId	Phone	Email	Address
INSERT INTO Contacts VALUES('(024) 7300 5588','tuyensinh.hanoi@fpt.edu.vn',N'Khu Giáo dục và Đào tạo – Khu Công nghệ cao Hòa Lạc – Km29 Đại lộ Thăng Long, Thạch Thất, TP. Hà Nội') 

GO
----------School----------
--SchoolId	SchoolName	SchoolContact
INSERT INTO Schools VALUES(N'FU-HN',10000)

GO
----------Major----------
--MajorId	MajorName	MajorCode	School
INSERT INTO Majors VALUES('Software Engineering','SE',10)
INSERT INTO Majors VALUES('Artificial Intelligence','AI',10)
INSERT INTO Majors VALUES('Japanese Language','AI',10)
INSERT INTO Majors VALUES('Digital Marketing','DM',10)

GO
----------Departments----------
--DepartmentId	DepartmentName	School
INSERT INTO Departments VALUES('Academic Department',10)
INSERT INTO Departments VALUES('Service Department',10)
INSERT INTO Departments VALUES('Technical Department',10)
INSERT INTO Departments VALUES('Accounting Department',10)
INSERT INTO Departments VALUES('Foreign Language Department',10)
INSERT INTO Departments VALUES('Economics Department',10)

GO
----------Subjects----------
--SubjectId	SubjectCode	SubjectName	NumberCredits	Fee FeeInternational
INSERT INTO Subjects VALUES( 'AAD305b' , 'Final Project - Automotive Application Development' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'ACC101' , 'Principles of Accounting' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ACC191' , 'Principles of Accounting and Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ACC302' , 'Managerial Accounting' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ACC305' , 'Financial Statement Analysis' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ADG201' , 'Brand Identity Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ADG301' , 'Book and Packaging Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ADH301' , 'Mobility Applications Design 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ADI201' , 'Brand Identity Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ADP201' , 'Audio Production' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ADT401' , 'Mobility Applications Design 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AET101' , 'Aesthetic' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'AET102' , 'Aesthetic' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AFA201' , 'Human Anatomy for Artis' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AGD301' , 'Information Graphic Design' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'AI-000001' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'AI-000002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'AI-000003c' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'AI-000004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'AI-000005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'AIG201' , 'Artificial Intelligence' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIG201c' , 'Artificial Intelligence' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIG201m' , 'Artificial Intelligence' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIL301' , 'Machine Learning' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIL301b' , 'Machine Learning' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIL301b' , 'Machine Learning' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIL302' , 'Machine Learning' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIL302m' , 'Machine Learning' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIP391' , 'AI programming project' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AIP490' , 'AI Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'ANA401' , '3D Character Animation' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANB401' , 'Background Painting for Animation' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANC301' , 'Character Development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANM301' , '3D Modeling & Texturing (Maya)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANM312' , 'Visual tool 3D' , 3 , null , null )
INSERT INTO Subjects VALUES( 'ANM322' , '3D Modeling & Shading' , 3 , null , null )
INSERT INTO Subjects VALUES( 'ANR401' , 'Introduction to Rigging' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANS201' , 'Idea & Script Development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANS301' , 'Storyboarding' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANS391' , 'Idea & Script Development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANT401' , 'Traditional Animation Principles' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ANV301' , 'Visual Development for Computer Animation' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ATC201' , 'Automata Theory and Computational Complexity' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'AVC101' , 'Asian Culture' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BD201' , 'Football' , 3 , null , null )
INSERT INTO Subjects VALUES( 'BDM201' , 'Business Decision Making' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BDP301b' , 'Blockchain Basics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BDP301c' , 'Blockchain Basics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BDP302b' , 'Smart Contract' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BDP303b' , 'Decentralized Application Development (Dapps)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BDP304b' , 'Blockchain Platforms' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'BDP306b' , 'Final Project - Blockchain Development in Finance' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'BKG201' , 'Principles of Banking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BKG201' , 'Principles of Banking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BKG201' , 'Principles of Banking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BKG301' , 'Bank Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BKG301' , 'Bank Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BKG302' , 'Investment Project Appraisal' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BKG304' , 'Bank Lending' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BKG304' , 'Bank Lending' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BRA301' , 'Brand Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BSI201' , 'Business Statistics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BUE201' , 'Business ethics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'BUSI1317.1' , 'Strategic Management 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'BUSI1317.2' , 'Strategic Management 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'BUSI1323' , 'Leadership' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CAA201' , 'Communications and advertising' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CAD201' , 'Water Color' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CCC101' , 'Cross Culture Communications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CCM201' , 'Communication crisis management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CCO201' , 'Corporate Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CEA201' , 'Computer Organization and Architecture' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CEA201' , 'Computer Organization and Architecture' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CEC201' , 'Circuits and Signals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CEC201' , 'Circuits and Signals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CES201' , 'System Support and Trouble Shooting for Windows Server 2012' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CES202' , 'System Support and Trouble Shooting' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CF001' , 'Programming with Alice' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'CF100' , 'Introduction to Computing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CF101' , 'Programming Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CF102' , 'Object-Oriented Paradigm' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CF103' , 'Data Structures and Algorithms' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CF104' , 'Operating Systems and Network' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'CF104-1' , 'Operating Systems' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'CF104-2' , 'Networking' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'CF105' , 'Introduction to Databases' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'CF110' , 'Core Java' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'CF111' , 'Advanced Java' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'CF112' , '.NET and C#' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'CF201' , 'Object-Oriented Paradigm' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'CF205' , 'Java Application Development' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'CF206' , '.NET and C#' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'CGG201' , 'Computer Graphics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN111' , 'Chinese Elementary 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN111' , 'Chinese Elementary 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN111' , 'Chinese Elementary 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN113' , 'Chinese Elementary 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN122' , 'Chinese Elementary 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN122' , 'Chinese Elementary 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN122' , 'Chinese Elementary 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN132' , 'Chinese Elementary 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN132' , 'Chinese Elementary 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CHN141' , 'Chinese Elementary 4' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CIH201' , 'Contemporary issues in hotel and tourism management' , 3 , 0, 0 )
INSERT INTO Subjects VALUES( 'CMC201c' , 'Creative Writing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CO-000004' , 'English 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000005' , 'Business English' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000006' , 'English for Information and Communication Technology (ICT)' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000007' , 'Sounds and Words (phonetics, phonology and morphology)' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000008' , 'British Cultures and Literature' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000009' , 'Sociolinguistics' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000010' , 'English Language and Communication Project' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000011' , 'American Cultures and Literature' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000012' , 'Translation' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000013' , 'Structures and Meanings (Syntax, Semantics and Pragmatics)' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000014' , 'Intercultural communication' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000015' , 'Interpretation' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000016' , 'Software Development Process' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000017' , 'Introduction to International Business' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000018' , 'Second foreign language 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000019' , 'Business Project' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000020' , 'Cross cultural management' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000021' , 'Information Systems' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000022' , 'Global Business Environment' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000023' , 'Second foreign language (2)' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000024' , 'Vietnamese cultural base' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000025' , 'Introduction to International Business' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000030' , 'English 4.1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000031' , 'English 4.1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000032' , 'English 4.1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000033' , 'English 4.1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000034' , 'Business writing' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000035' , 'Translation 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000036' , 'Interpretation 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000037' , 'Foreign language 2_1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000038' , 'Effective Presentation Skills' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000039' , 'Translation 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000040' , 'Interpretation 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000041' , 'Foreign language 2_2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000042' , 'Foreign language 2_3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CO-000043' , 'English for international standardized tests' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'COM201' , 'Communication Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'COMP101' , 'CompTIA A+' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'COV111' , 'Chess 1' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'COV111' , 'Chess 1' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'COV121' , 'Chess 2' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'COV121' , 'Chess 2' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'COV131' , 'Chess 3' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'COV131' , 'Chess 3' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'CPP101b' , 'Basic C++ Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CPP201b' , 'Advanced C++ Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CQT201b' , 'Create UI in C++ using Qt/QML' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CRY301' , 'Cryptography and Applications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CRY302' , 'Introduction to Applied Cryptography' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CRY302c' , 'Applied Cryptography' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CRY303c' , 'Introduction to Applied Cryptography' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CS-000001' , 'Automata Theory and Computational Complexity' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CS-000002' , 'Python Programming' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CS-000003' , 'Systems Programming' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CS-000004' , 'IT elective 2 (Machine Learning)' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CS-00002' , 'Free Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'CSD201' , 'Data Structures and Algorithms' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSD202' , 'Data structures and algorithms (In C++)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSD301' , 'Advanced Algorithms' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSD301' , 'Advanced Algorithms' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSI101' , 'Connecting to Computer Science' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSI102' , 'Introduction to Informatics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSI102' , 'Introduction to Informatics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSI102' , 'Introduction to Informatics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSI103' , 'Computer science fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSI103' , 'Computer science fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSI104' , 'Introduction to Computer Science' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CSL201' , 'Programming languages' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'CST491' , 'Graduation Assignment for CS' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'DBD301' , 'Advanced Database' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DBI201' , 'Introduction to Databases' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'DBI202' , 'Introduction to Databases' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DBM301' , 'Data mining' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DBS401' , 'Database Security' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DBW301' , 'Data warehouse' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DGT201' , 'Digital Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DGT201' , 'Digital Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DGT202' , 'Digital Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DGT301' , 'Digital Signal Processing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DGT302' , 'Visual Effects - Principles of Compositing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DM-0001c' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'DM-0002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'DM-0003' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'DM-0004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'DM-0005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'DM101' , 'Discrete Mathematics 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DM102' , 'Discrete Mathematics 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DMS401' , 'Applied Data Mining for Information assurance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRA301' , 'Character Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRD201' , 'Drawing - Speed drawing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRD201' , 'Drawing - Speed drawing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRD202' , 'Drawing - Speed drawing' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'DRD203' , 'Drawing - Speed drawing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRD204' , 'Drawing - Speed drawing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRF201' , 'Drawing - Figure drawing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRP101' , 'Drawing - Plaster Statue, Portrait' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRS101' , 'Drawing - Form, Still-life' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRS102' , 'Drawing - Form, Still-life' , 3 , null , null)
INSERT INTO Subjects VALUES( 'DRW101' , 'Hình họa cơ bản' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DRW201' , 'Interediate Drawing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG101' , 'Digital Tool - 2D' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG102' , 'Visual Design Tools' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG111' , 'Visual Design Tools 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG121' , 'Visual Design Tools 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG201' , '3D Digital Tool' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG301' , 'Digital Tool - Interactive' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG302' , 'Visual Effects - Principles of Compositing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'DTG303' , 'Principles of Animation' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'E-AE1' , 'Advanced English 1' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'E-AE2' , 'Advanced English 2' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EAL201' , 'Academic Listening' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EAW211' , 'Academic Paper 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EAW221' , 'Academic Writing 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EB111' , 'Elementary Business English' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB112' , 'Elementary Business English' , 3 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB121' , 'Pre-intermediate Business English' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB131' , 'Intermediate Business English' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB141' , 'Upper-intermediate Business English' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB211' , 'Pre-intermediate Business English' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB221' , 'Intermediate Business English' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB231' , 'Upper Intermediate Business English' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB241' , 'Upper Intermediate Business English 2' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'EB331' , 'MKL Intermediate Business English 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EBC301' , 'Business English Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EBC301c' , 'Business English Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECB101' , 'Culture of English-Speaking Countries' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECC301' , 'Cross-cultural Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECC301c' , 'Cross-cultural communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECM301' , 'Mobile Communications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECM391' , 'Wireless and Mobile Systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECM392' , 'Wireless and Mobile Communication Security' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO101' , 'Business environment' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO102' , 'Business Environment' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO111' , 'Microeconomics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO111' , 'Microeconomics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO121' , 'Basic Macro Economics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO201' , 'International Economics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO201' , 'International Economics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO202' , 'Macroeconomics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECO301' , 'Optical Communications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECP491' , 'Capstone Project for EC' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'ECR201' , 'Critical Reading' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECR211' , 'Critical Reading 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECR221' , 'Critical Reading 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECS211' , 'Communications Systems 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ECS211' , 'Communications Systems 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EDT202c' , 'Công nghệ số mới nổi' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EEA211' , 'Electronics 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EEA221' , 'Electronics 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EIT201' , 'Ethics in Information Technology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EIT491' , 'English for Standardized Tests' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EL-000001' , 'English 1' , 12 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-000002' , 'English 2' , 12 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-000003' , 'English 3' , 12 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-000004' , 'English 4' , 12 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-0001' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-0002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-0003' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-0004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'EL-0005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'ELI301' , 'Interpretation 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ELI301' , 'Interpretation 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ELI401' , 'Interpretation 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ELR301' , 'Research Methods' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ELS401c' , 'Academic Listening and Speaking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ELT301' , 'Translation 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ELT401' , 'Translation 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ELT491' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'ELT492' , 'Graduation Thesis - English studies' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'EN011' , 'Top Notch Fundamental' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'EN021' , 'Top Notch 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'EN031' , 'Top Notch 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'EN041' , 'Top Notch 3' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'EN051' , 'Summit 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'EN062' , 'Summit 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'EN151' , 'Academic English' , 3 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'EN161' , 'Advanced Academic English' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'EN162' , 'Advanced Practical English' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'ENB101' , 'Business writing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENB102' , 'Business Writing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENB301' , 'Business Writing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENG301' , 'Advanced English Grammar' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENG302c' , 'Advanced English Grammar' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENH301' , 'BUSINESS ENGLISH FOR HOSPITALITY - Intermediate' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENH401' , 'Business English for Hospitality - Upper Intermediate' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI101' , 'Elementary Business English' , 2 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI101' , 'Elementary Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI201' , 'Pre-intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI201' , 'Pre-intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI201' , 'Pre-intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI301' , 'Intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI401' , 'Upper-intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI401' , 'Upper-intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI511' , 'Listening Speaking 5 (Part 1/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI512' , 'Listening Speaking 5 (Part 2/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENI521' , 'Listening Speaking 5 (Part 2/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL101' , 'Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL111' , 'Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL111' , 'Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL111' , 'Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL111' , 'Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL112' , 'Advanced Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL112' , 'Advanced Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENL201' , 'Advanced Academic English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM101' , 'Elementary Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM101' , 'Elementary Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM101' , 'Elementary Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM101c' , 'Business English 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM111' , 'Elementary Business English 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM112' , 'Elementary Business English 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM112c' , 'Business English 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM121' , 'Elementary Business English 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM201' , 'Pre-intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM211' , 'Pre-Intermediate Business English 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM211c' , 'Business English Communication 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM212' , 'Pre-Intermediate Business English 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM212' , 'Pre-Intermediate Business English 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM221' , 'Pre-intermediate Business English 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM221c' , 'Business English Communication 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM301' , 'Intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM401' , 'Upper Intermediate Business English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM411' , 'MKL Upper Intermediate Business English 4' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM421' , 'Upper Intermediate Business English 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENM511' , 'Business English 6 - Advanced' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENO201' , 'Advanced Practical English' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENP101' , 'Phonetics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENP102' , 'Phonetics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENR101' , 'Reading 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENR201' , 'Reading 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENR301' , 'Skillfull 3 - Reading 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENR401' , 'Skillful 4: Reading' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENR501' , 'Reading 5' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS111' , 'Skillfull 1 - Listening Speaking 1 (Part 1/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS121' , 'Skillfull 1- Listening Speaking 1 (Part 2/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS211' , 'Skillfull 2 - Listening & Speaking 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS212' , 'Skillfull 2 - Reading & Writing 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS221' , 'Skillfull 2 - Listening & Speaking 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS222' , 'Skillfull 2 - Reading & Writing 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS311' , 'Skillfull 3 - Listening & Speaking 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS311' , 'Skillfull 3 - Listening & Speaking 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS312' , 'Skillfull 3 - Reading & Writing 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS321' , 'Skillfull 3 - Listening & Speaking 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS321' , 'Skillfull 3 - Listening & Speaking 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS322' , 'Skillfull 3 - Reading & Writing 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS403' , 'Skillfull 4: Reading' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS411' , 'Skillfull 4: Listening & Speaking (Part 1/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS412' , 'Skillfull 4: Reading & Writing (Part 1/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS421' , 'Skillfull 4: Listening & Speaking (Part 2/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENS422' , 'Skillfull 4: Reading & Writing (Part 2/2)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENT001' , 'Top Notch Fundamental' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT101' , 'Top Notch 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT102' , 'Top Notch 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT102-ST07' , 'Top Notch 1' , 3 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT103' , 'Topnotch 1 - Fundamentals' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT104' , 'Top Notch 1' , 0 , 10350000, 13455000)
INSERT INTO Subjects VALUES( 'ENT201' , 'Top Notch 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT202' , 'Top Notch 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT203' , 'Top Notch 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT203c' , 'Top Notch 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT301' , 'Top Notch 3' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT301-K7' , 'Top Notch 3' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT302' , 'Top Notch 3' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT303' , 'Top Notch 3' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT401' , 'Summit 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT401-K7' , 'Summit 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT401-ST08' , 'Summit 1' , 3 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT403' , 'Summit 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT501' , 'Summit 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENT503' , 'Summit 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'ENW101' , 'Writing 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENW201' , 'Writing 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENW301' , 'Skillfull 3 - Writing 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENW401' , 'Writing 4' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENW491' , 'Writing Skill' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENW492' , 'Writing Research Papers' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ENW501' , 'Writing 5' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EPC301' , 'Persuasive Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EPE101' , 'Professional Ethics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EPE101c' , 'Professional Ethics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ERW411' , 'Read Think Write 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ERW421' , 'Read Think Write 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ES301' , 'Digital Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ES311' , 'Embedded System Hardware' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ES312' , 'Embedded Software Development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ES313' , 'Digital Signal Processing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ES321' , 'Smart Cards' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ES322' , 'Wireless & Mobile Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ESH201' , 'Embedded system hardware' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ESH391' , 'Smart Cards' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ESL101' , 'Sociolinguistics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ESP301' , 'Embedded system programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ESS301' , 'Embedded software development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EST401' , 'English for Standardized Tests' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ETR401' , 'Entrepreneurship' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ETR401' , 'Entrepreneurship' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ETR402' , 'software entrepreneurship' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EVN201' , 'Event planning' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EVN202' , 'Conventions and Tradeshows' , 3 , null , null )
INSERT INTO Subjects VALUES( 'EVN203' , 'Special Events and Wedding Production' , 3 , null , null )
INSERT INTO Subjects VALUES( 'EWR101' , 'Academic English (Writing)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'EXO401' , 'Training Eos_Client' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'FBM201' , 'Food and Beverage Operations Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FE-000001' , 'Free Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'FE-000002' , 'Free Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'FE-000003' , 'Free Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'FE-000004' , 'Free Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'FIM301' , 'Valuation and financial modeling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIM301' , 'Valuation and financial modeling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIM301' , 'Valuation and financial modeling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN201' , 'Monetary Economics and Global Economy' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN201' , 'Monetary Economics and Global Economy' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN202' , 'Principles of Corporate Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN202' , 'Principles of Corporate Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN301' , 'Financial Markets and Institutions' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN301' , 'Financial Markets and Institutions' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN303' , 'Advanced Corporate Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN303' , 'Advanced Corporate Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN303' , 'Advanced Corporate Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN391' , 'Applied Corporate Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN402' , 'Derivatives' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIN402' , 'Derivatives' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FIT391' , 'Financial Technology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FMM101' , 'Fundamentals of Multimedia' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FRS301' , 'Digital Forensics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FRS401' , 'Network Forensics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'FUN131b' , 'Becoming a Digital Citizen' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'GBE101' , 'International Business Environment' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'GD-000001c' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'GD-000002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'GD-000003' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'GD-000004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'GD-000005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'GDA401' , 'Mobility Applications Design' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'GDF101' , 'Fundamental of Graphic Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'GDF102' , 'Fundamental of Graphic Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'GDG401' , 'Design 2: 3D Animation' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'GDP101' , 'Applied Graphic Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'GDP491' , 'Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GDQP' , 'Military training' , 0 , 3450000, 4485000)
INSERT INTO Subjects VALUES( 'GDS301' , 'Design 1: Scenario Design & Animation' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'GDW401' , 'Web Design' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'Global Citizen' , '.' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'Global Citizen LUK5' , '.' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'GRA491' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'GRA492' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'GRA493' , 'Graduation Assignment' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'GRA494' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'GRA495' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'GRA496' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'GRA497' , 'Capstone Project - Multimedia and Communication-' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GRA497' , 'Capstone Project - Multimedia and Communication-' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GRA498' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'GRB491' , 'Graduation Thesis - Finance Banking' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GRF491' , 'Graduation Thesis - Finance' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GRH491' , 'Graduation Thesis - Hotel Management' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GRI491' , 'Graduation Thesis - International Business' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GRM491' , 'Graduation Thesis - Marketing' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'GRP490' , 'Graduation thesis (Business plan)' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'HCI201' , 'Human-Computer Interaction' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HCI201' , 'Human-Computer Interaction' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HCI202' , 'UI/UX' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HCM201' , 'Ho Chi Minh Ideology' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'HCM202' , 'HCM Ideology' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'HM-0001' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'HM-0002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'HM-0003' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'HM-0004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'HM-0005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'HMO102' , 'Introduction to Tourism & Hospitality industry' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOA101' , 'Art History' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOA102' , 'Art History' , 3 , null , null )
INSERT INTO Subjects VALUES( 'HOD101' , 'Design History' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'HOD102' , 'Design History' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'HOD401' , 'Ethical Hacking and Offensive Security' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOM201' , 'Hotel Operations Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOM202' , 'Hotel Operations Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOM202' , 'Hotel Operations Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOM203' , 'Managing Guest Experience' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOM301c' , 'Hotel Revenue Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HOM302' , 'Service Operation Management' , 3 , null , null )
INSERT INTO Subjects VALUES( 'HRM201' , 'Human Resource Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HRM201c' , 'Human Resource Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HS111' , 'Principles of Marxism - Leninism' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HS112' , 'Principles of Marxism Leninism' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'HS121' , 'Hochiminh Ideology' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'HS131' , 'Revolutionary Line of CPV' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IA-000001c' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IA-000002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IA-000003c' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IA-000004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IA-000005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IAA201' , 'Risk-Vulnerability Analysis' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAA202' , 'Risk Management in Information Systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAA301' , 'Intelligence Analysics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAD101b' , 'Intro to Automotive Application Development' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'IAM301' , 'Malware Analysis' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAM302' , 'Malware Analysis and Reverse Engineering' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAO101' , 'Information Assurance Overview' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAO201c' , 'Introduction to Information Assurance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAP201' , 'Privacy and IT Ethics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAP301' , 'Policy Development in Information Assurance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAP491' , 'CAPSTONE PROJECT (For IA Specializations)' , 3 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'IAP491' , 'CAPSTONE PROJECT (For IA Specializations)' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'IAR301' , 'Incident Response' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAR401' , 'Incident Response' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IAT491' , 'Graduate Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'IAW301' , 'Web security' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IB-0001c' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IB-0002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IB-0003' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IB-0004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IB-0005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IBC201' , 'Cross Cultural Management and Negotiation' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IBF301' , 'International Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IBI101' , 'Introduction to International business' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IBS301' , 'International Business Strategy' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IBS301m' , 'International Business Strategy' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IEI301' , 'Import and Export' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IHM101' , 'Introduction to Hospitality industry' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IIP301' , 'International payment' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IM1102' , 'Internet Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IMP301' , 'Image Processing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IMP301c' , 'Image processing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'INDU1130.1' , 'International Human resource management 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'INDU1130.2' , 'International Human resource management 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IOP391' , 'IoT application development project' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IOP490' , 'IoT Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'IoT-000001' , 'Free Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IoT-000002' , 'Free Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IoT-000003c' , 'Free Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IoT-000004' , 'Free Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IoT-000005' , 'Free Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IOT101' , 'Internet of Things' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IOT102' , 'Internet of Things' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IPR102' , 'Intellectual Property Rights' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IPR121' , 'Intellectual Property Rights' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'IPR121c' , 'Intellectual Property Rights' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IS-000001' , 'Free Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IS-000002' , 'Free Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IS-000002c' , 'Free Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IS-000004' , 'Free Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IS-000005' , 'Free Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'IS301' , 'IT Applications in Enterprise' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IS311' , 'Principles of Accounting and Finance' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IS312' , 'E-Commerce' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IS313' , 'ERP Systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IS321' , 'Advanced XML' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IS322' , 'Advanced Database' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'IS323' , 'Data warehouse' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ISB101' , 'Business Statistics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ISC301' , 'e-Commerce' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ISC302' , 'E-Commerce' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ISM301' , 'ERP Systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ISP391' , 'Integrated System Project' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ISP490' , 'IS Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'ITA201' , 'IT Applications in Enterprise' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITA202' , 'Management Information Systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITA202' , 'Management Information Systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITA203' , 'Information System overview' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITA203c' , 'Management information systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITA203c' , 'Management information systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITA301' , 'Information System Design & Analysis' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITB301c' , 'Business Intelligence (BI)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITE301' , 'Ethics in Information Technology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITE302' , 'Ethics in Information technology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITE302b' , 'Ethics in IT' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITE302c' , 'Ethics in IT' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ITE303' , 'Cyber Law and IT Ethics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JBI301' , 'Basic skills of Intereprating' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JBJ301' , 'Những vấn để cơ bản về ngữ pháp tiếng Nhật - Từ lí thuyết đến thực tiễn' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JBP301' , 'Ứng xử trong môi trường đối với đối tác Nhật Bản' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JBT301' , 'Basic skills of Translation' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JFE301' , 'Japanese IT Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JGP491' , 'Graduation Project - Japanese Studies' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'JGT492' , 'Graduation Thesis - Japanese Studies' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'JIG301' , 'Basic Issues of Japanese Gramma' , 3 , null , null )
INSERT INTO Subjects VALUES( 'JIJ301' , 'Basic issues of Japanese lexicology & phonetics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JIT301' , 'IT Japanese' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JIT491' , 'Japanese for JLPT' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JJB391' , 'Japanese for JLPT/BIT' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JJL301' , 'Japanese Literature' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLI301' , 'Interpretation 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLI401' , 'Interpretation 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLI401' , 'Interpretation 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLP301' , 'Project management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLP491' , 'Graduation Project - Japanese Studies' , 5 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'JLP491' , 'Graduation Project - Japanese Studies' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'JLR301' , 'Research Method' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLR302' , 'Phương pháp nghiên cứu' , 3 , null , null )
INSERT INTO Subjects VALUES( 'JLT301' , 'Translation 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLT401' , 'Translation 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLT401' , 'Translation 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JLT491' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'JLT492' , 'Graduation Thesis - Japanese Studies' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'JMS' , 'Japan Monozukuri & SW Development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JP111' , 'Japanese Elementary 1' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'JP112' , 'Japanese Elementary 2' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'JP113' , 'Japanese Elementary 3' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'JP114' , 'Japanese Elementary 4' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'JP115' , 'Japanese Elementary 5' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'JP211' , 'Japanese Intermediate 1' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'JP221' , 'Japanese Intermediate 2' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'JPC301' , 'Japanese Culture and Literature' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD111' , 'Elementary Japanese 1.1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD112' , 'Elementary Japanese 1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD112' , 'Elementary Japanese 1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD113' , 'Elementary Japanese 1-A1.1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD116' , 'Elementary Japanese 1-A1/A2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD121' , 'Elementary Japanese 1.2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD122' , 'Elementary Japanese 2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD122' , 'Elementary Japanese 2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD123' , 'Elementary Japanese 1-A1.2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD126' , 'Elementary Japanese 2-A2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD131' , 'Elementary Japanese 2.1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD133' , 'Elementary Japanese1-A1/A2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD141' , 'Elementary Japanese 2.2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPD216' , 'Japanese Pre-Intermediate 1-A2/B1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD222' , 'Japanese Pre-Intermediate 1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD223' , 'Japanese Pre-Intermediate 2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD226' , 'Japanese Pre-Intermediate 2-B1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD316' , 'Japanese Intermediate 1-B1/B2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD322' , 'Intermediate Japanese 1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD323' , 'Intermediate Japanese 2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD324' , 'Intermediate Japanese 3' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD325' , 'Intermediate Japanese 4' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD326' , 'Japanese Intermediate 2-B2.1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD336' , 'Japanese Intermediate 2-B2.2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPD346' , 'Japanese Intermediate2-B2/C1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPG301' , 'Japanese Vocabulary and Grammar' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPL-0001' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'JPL-0002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'JPL-0003' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'JPL-0004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'JPL-0005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'JPL301' , 'Japanese Literature' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPP301' , 'Phonetics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS111' , 'Japanese Elementary 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS112' , 'Japanese Elementary 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS121' , 'Japanese Elementary 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS122' , 'Japanese Elementary 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS122' , 'Japanese Elementary 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS131' , 'Japanese Elementary 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS132' , 'Japanese Elementary 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS141' , 'Japanese Elementary 4' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS142' , 'Japanese Elementary 4' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS151' , 'Japanese Elementary 5' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS152' , 'Japanese Elementary 5' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPS211' , 'Japanese Intermediate 1' , 3 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPS212' , 'Japanese Intermediate 1' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPS221' , 'Japanese Intermediate 2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPS222' , 'Japanese Intermediate 2' , 6 , 8340000, 10842000)
INSERT INTO Subjects VALUES( 'JPS301' , 'Japanese Study' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JPT491' , 'Graduation Thesis' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'JSC301' , 'Japanese Studies & and Japanese Culture' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'JSC301' , 'Japanese Studies & and Japanese Culture' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAB101' , 'C Lab' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAB211' , 'OOP with Java Lab' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAB221' , 'Desktop Java Lab' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAB231' , 'Web Java Lab' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAB301' , 'C#.NET Lab' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAW101' , 'Business Law Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAW102' , 'Business Law and Ethics Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAW201' , 'Media Law and Ethics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LAW202c' , 'Intellectual Property Rights' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LIT101' , 'English Literature' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LIT301' , 'British and American Literature' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LTG201' , 'Introduction to linguistics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LTG202' , 'Introduction to linguistics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LTG203' , 'Introduction to liguistics (in Japanness)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LTG203' , 'Introduction to liguistics (in Japanness)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LTJ301' , 'Japanese Theory' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'LUK.PM' , 'LUK.PM' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'LUK1' , 'Level 1' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'LUK2' , 'Level 2' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'LUK3' , 'Level 3' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'LUK4' , 'Level 4' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'LUK5' , 'Level 5' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'LUK6' , 'Level 6' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'MA101' , 'Advanced Mathematics 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MA102' , 'Advanced Mathematics 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MA201' , 'Statistics and Probability' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAA101' , 'Advanced Mathematics 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAC001' , 'Precalculus' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAC101' , 'Advanced Mathematics 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAC102' , 'Advanced Mathematics for Business' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAC102' , 'Advanced Mathematics for Business' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAC102' , 'Advanced Mathematics for Business' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAC201' , 'Calculus 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAD101' , 'Discrete mathematics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAD111' , 'Discrete Mathematics 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAD121' , 'Discrete Mathematics 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAE101' , 'Mathematics for Engineering' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAI391' , 'Advanced mathematics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAN201' , 'Numerical Methods' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAN201' , 'Numerical Methods' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAO301' , 'Combinatorial Optimizations' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAO302' , 'Linear Optimization' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAS201' , 'Statistics and data processing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAS202' , 'Applied Statistics for Business' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MAS291' , 'Statistics and Probability' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MBS391' , 'Wireless & Mobile Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MC-000001' , 'Concentration Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-000002' , 'Concentration Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-000003' , 'Concentration Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-000004' , 'Concentration Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-000005' , 'Major Elective Group 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-000006' , 'Major Elective Group 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-000007' , 'Major Elective Group 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-0001c' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-0002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-0003' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-0004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MC-0005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'MCO201' , 'Transmedia Storytelling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MCO201m' , 'Transmedia Storytelling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MCO206' , 'Intercultural Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MCO301' , 'Research methods in Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MCP301' , 'Micro-controller programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MED201' , 'New Media Technology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MEP201' , 'Multimedia Production Project' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MG101' , 'Introduction to Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MGT101' , 'Introduction to Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MGT101' , 'Introduction to Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MGT102' , 'Management Principle' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MGT103' , 'Introduction to Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKD301' , 'Digital Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT101' , 'Marketing Principles' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT201' , 'Consumer Behavior' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT201' , 'Consumer Behavior' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT202' , 'Services Marketing Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT202' , 'Services Marketing Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT204' , 'International Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT204c' , 'International Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT205c' , 'International Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT208c' , 'Social media marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT301' , 'Marketing Research' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT301' , 'Marketing Research' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT301' , 'Marketing Research' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT304' , 'Integrated Marketing Communications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT304' , 'Integrated Marketing Communications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT305' , 'Marketing Strategy' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT306' , 'Marketing Channel' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT307' , 'Customer Relationship Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT308' , 'Digital Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT308b' , 'Digital Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT308m' , 'Digital Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT308m' , 'Digital Marketing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT318' , 'Digital marketing 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT318m' , 'Digital marketing 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT328' , 'Digital marketing 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MKT328m' , 'Digital Marketing 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MLN101' , 'Principles of Marxism - Leninism' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'MLN111' , 'Philosophy of Marxism – Leninism' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MLN121' , 'Principles of Marxism Leninism' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'MLN122' , 'Political economics of Marxism – Leninism' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'MLN122' , 'Political economics of Marxism – Leninism' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'MLN131' , 'Scientific socialism' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'MMA001' , 'Monney Minded' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'MMM101' , 'Monney Minded' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'MMP101' , 'Media Psychology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MMP201' , 'Media Psychology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'MPL201' , 'Strategic Media Planning' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'NLP301' , 'Natural Language Processing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'NLP301c' , 'Natural Language Processing' , 3 , 0, 0 )
INSERT INTO Subjects VALUES( 'NMN101' , 'Traditional Instrument Night' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'NWC201' , 'Networking' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'NWC202' , 'Computer Networking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'NWC202c' , 'Computer Networking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'NWC203c' , 'Computer Networking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'NWC301' , 'Advanced Networking' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'NWC302' , 'Network Connetivity' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'NWC401' , 'Network Connectivity' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OB201' , 'Organization Behavior' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OBE101' , 'Organizational Behavior' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OBE101c' , 'Organizational Behavior' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OBE102c' , 'Organizational Behavior' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OFC311' , 'Optical Communications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OFC321' , 'Optical Fiber Communications 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OJA201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJB201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJB202' , 'On-the-job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJB211' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJB211' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJB211' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJC201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJE201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJE202' , 'On-the-job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJG201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJH201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJK201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJL201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJM201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJP202' , 'On-the-job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJS201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJS211' , 'On the Job Training 1' , 10 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'OJS221' , 'On the Job Training 2' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'OJS231' , 'On the Job Training 3' , 5 , 6950000, 9035000)
INSERT INTO Subjects VALUES( 'OJT201' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'OJT202' , 'On the job training' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'ORG101' , 'Orientation' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'ORT101' , 'Orientation' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'ORT102' , 'Orientation IT' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'ORT103' , 'Orientation Examination' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'ORT104' , 'Orientation Academic' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'ORT105' , 'Orientation Library' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'ORT106' , 'Orientation Accounting' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'OSG201' , 'Operating Systems' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'OSG202' , 'Operating Systems' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'OSP201' , 'Open Source Platform and Network Administration' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PCCC' , 'PCCC' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'PDP101' , 'Kỹ năng sinh tồn tại Hòa Lạc' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'PDP102' , 'Hoạt động Văn thể' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'PDP103' , 'Lễ trưởng thành' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'PFD201' , 'Photography for Designer' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PFD202' , 'Nhiếp ảnh' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PFL401' , 'Portfolio Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PHY101' , 'Physics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PHY101' , 'Physics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PHY121' , 'Physics (Lab)' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'PHY201' , 'Modern physics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PLT101' , 'Placement Test' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'PMG201c' , 'Project management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRC391' , 'Cloud Computing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRE201' , 'Excel Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRE201' , 'Excel Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRE202' , 'Public Relations Principles and Strategies' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRF191' , 'Programming Fundamentals' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'PRF192' , 'Programming Fundamentals' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRJ101' , 'Core Java' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRJ102' , 'Core Java' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRJ201' , 'Advanced Java' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRJ202' , 'Advanced Java' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRJ301' , 'Java Web Application Development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRJ311' , 'Desktop Java Applications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRJ321' , 'Web-Based Java Applications' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRM301' , 'Mobile Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRM391' , 'Mobile Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRN211' , 'Basic Cross-Platform Application Programming With .NET' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRN291' , '.NET and C#' , 4 , 5560000, 7228000)
INSERT INTO Subjects VALUES( 'PRN292' , '.NET and C#' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRO001' , 'Programming with Alice' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'PRO191' , 'Object-Oriented Paradigm (C++)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRO192' , 'Object-Oriented Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRO201' , 'Front-end Web Development' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRO201c' , 'Web Design for Everybody' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRO201m' , 'Web Design for Everybody' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRO201m' , 'Web Design for Everybody' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRP201' , 'Python programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRP201c' , 'Python programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRS301' , 'System Programming' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PRX301' , 'Web Development (XML)' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PST201' , 'Perspective' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'PST202' , 'Perspective' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'PST301' , 'Intermediate Visual Principles' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'RMB301' , 'Business Research Methods' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SAL301' , 'Professional Selling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SAL301' , 'Professional Selling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SAL301m' , 'Professional Selling' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SAL302' , 'Salesforce Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SCI201' , 'Information Security' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SCM201' , 'Supply Chain Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SCM201' , 'Supply Chain Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SCM201m' , 'Supply Chain Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SDP201' , 'Sound Production' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SDP201' , 'Sound Production' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE-000001' , 'Specialization 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-000002' , 'Specialization 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-000003' , 'Specialization 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-000004' , 'Specialization 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-000005' , 'Specialization 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-0001' , 'Elective 1' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-0002' , 'Elective 2' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-0003c' , 'Elective 3' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-0004' , 'Elective 4' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE-0005' , 'Elective 5' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SE101' , 'Introduction to Software Engineering' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE211' , 'Software Construction' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE212' , 'Human-Computer Interaction' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE213' , 'Software Requirements' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE214' , 'Software Quality Assurance & Testing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE216' , 'IT Project Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE300' , 'software entrepreneurship' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE315' , 'Software Architecture and Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SE400-ES' , 'Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'SE400-IS' , 'Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'SEM101' , 'Semantics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SEP490' , 'SE Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'SGG201' , 'Computer Graphics' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SPD401' , 'System Planning and Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SPM401' , 'Security Project Management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SRE301' , 'Software Reverse Engineering' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SS101' , 'Business Communication' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'SS102' , 'Working in Group' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'SS102-2' , 'Working in Group' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SS201' , 'Business Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSB201' , 'Advanced Business Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSC001' , 'Business Communication' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'SSC101' , 'Business Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSC102' , 'Business Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSC102' , 'Business Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSC103' , 'Business Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSC201' , 'Effective presentation skills' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSC302' , 'Advanced Presentation Skills' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSC302c' , 'Advanced Presentation skills' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSG001' , 'Working in Group' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'SSG101' , 'Working in Group Skills' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSG101-ST08' , 'Working in groups' , 3 , 0, 0)
INSERT INTO Subjects VALUES( 'SSG102' , 'Working in Group' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSG103' , 'Communication and In-Group Working Skills' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSG104' , 'Communication and In-Group Working Skills' , 3 , null , null )
INSERT INTO Subjects VALUES( 'SSL101' , 'Studying skill' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSL101c' , 'Studying skill' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSM201' , 'Management Skills' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSM201' , 'Management Skills' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSN301' , 'Negotiation' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSP201' , 'Pitching creative ideas' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SSS101' , 'Study skill' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'SWC101' , 'Software development process' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWC201' , 'Software Construction' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWC202' , 'Software Construction' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWD391' , 'Software Architecture and Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWD391c' , 'SW Architecture and Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWE101' , 'Introduction to Software Engineering' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWE102' , 'Introduction to Software Engineering' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWE201c' , 'Introduction to Software Engineering' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWM301' , 'Software project management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWM301b' , 'Software project management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWM301c' , 'Software project management' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWP391' , 'Application development project' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWP490' , 'Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'SWP491' , 'Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'SWP492' , 'Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'SWP493' , 'Capstone Project' , 10 , 13900000, 18070000)
INSERT INTO Subjects VALUES( 'SWQ391' , 'Software Quality Assurance and Testing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWR301' , 'Software Requirements' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWR302' , 'Software Requirement' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SWT301' , 'Software Testing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SYB301' , 'Start Your Business' , 0 , 3450000, 4485000)
INSERT INTO Subjects VALUES( 'SYB301b' , 'Start Your Business' , 0 , 3450000, 4485000)
INSERT INTO Subjects VALUES( 'SYB301c' , 'Start Your Business' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SYB302c' , 'Entrepreneurship' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SYB302c' , 'Entrepreneurship' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'SYB303c' , 'Start Your Business' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TMI101' , 'Traditional musical instrument' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TPG201' , 'Typography 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TPG202' , 'Typography 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TPG203' , 'Basic typography & Layout' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TPG301' , 'Typography 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TPG302' , 'Typography & E-publication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TRG101' , 'Trống' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TRG102' , 'Traditional musical instrument' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'TRS401' , 'English 4' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'TRS501' , 'English 5' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'TRS502' , 'English 5' , 6 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'TRS6' , 'Transition' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'TRS601' , 'Transition' , 0 , 10350000, 10350000)
INSERT INTO Subjects VALUES( 'VCM201' , 'Visual Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VCM202' , 'Visual Communication' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VDP201' , 'Video Production' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNC101' , 'Vietnamese Cultural' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VNC102' , 'Vietnamese Culture' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNC103' , 'Vietnamese culture base' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNC104' , 'Vietnamese Culture' , 3 , null , null )
INSERT INTO Subjects VALUES( 'VNF001' , 'Vietnamese 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNL111' , 'Vietnamese 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNL121' , 'Vietnamese 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNL131' , 'Vietnamese 3' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNR201' , 'Revolutionary line of CPV' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'VNR202' , 'History of Việt Nam Communist Party' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VO101' , 'Vovinam 1' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VO102' , 'Vovinam 2' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VO103' , 'Vovinam 3' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VO104' , 'Vovinam 4' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VOV111' , 'Vovinam 1' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VOV112' , 'Vovinam 1' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'VOV113' , 'Vovinam 2' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'VOV114' , 'Vovinam 1' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VOV121' , 'Vovinam 2' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VOV122' , 'Vovinam 3' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'VOV123' , 'Vovinam 4' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'VOV124' , 'Vovinam 2' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VOV131' , 'Vovinam 3' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VOV132' , 'Vovinam 5' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'VOV133' , 'Vovinam 6' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'VOV134' , 'Vovinam 3' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'VOV135' , 'Võ nâng cao' , 0 , 0, 0)
INSERT INTO Subjects VALUES( 'VOV141' , 'Vovinam 4' , 2 , 2780000, 3614000)
INSERT INTO Subjects VALUES( 'WDL202' , 'Web layout design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WDL301' , 'Web Design 1' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WDT401' , 'Web Design 2' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WDU201' , 'Principles of UX' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WDU201c' , 'Principles of UX' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WDU202c' , 'UI/UX Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WEB101' , 'Web Design' , 1 , 1390000, 1807000)
INSERT INTO Subjects VALUES( 'WED201c' , 'Web Design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WIR201' , 'Interaction design' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WMC201' , 'Media Writing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WMC201' , 'Media Writing' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'WMT201' , 'Web and Mobility Technology' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐBA101' , 'Đàn Bầu' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐBA102' , 'Traditional musical instrument' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐNG101' , 'Đàn Nguyệt' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐNG102' , 'Traditional musical instrument' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐNH101' , 'Đàn Nhị' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐNH102' , 'Traditional musical instrument' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐSA101' , 'Sáo trúc' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐSA102' , 'Traditional musical instrument' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐTB101' , 'Đàn Tỳ bà' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐTB102' , 'Traditional musical instrument' , 3 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐTR101' , 'Đàn Tranh' , 0 , 4170000, 5421000)
INSERT INTO Subjects VALUES( 'ÐTR102' , 'Traditional musical instrument' , 3 , 4170000, 5421000)


----------Role----------
--RoleId	RoleName
INSERT INTO Roles VALUES('Admin')
INSERT INTO Roles VALUES('Teacher')
INSERT INTO Roles VALUES('Staff')
INSERT INTO Roles VALUES('Student')
----------Users----------

GO
-- UserName Password Role FirstName MidleName LastName Gender DOB AvatarName AvatarByte Phone Email Address
CREATE PROCEDURE stp_InsertTeacher
-- Add the parameters for the stored procedure here
	@UserName VARCHAR(50), @Password VARCHAR(100),
	@FirstName NVARCHAR(20), @MidleName NVARCHAR(20), @LastName NVARCHAR(20),
	@Gender BIT, @DOB VARCHAR(20),
	@AvatarName NVARCHAR(200), @AvatarByte VARBINARY(MAX),
	@Phone VARCHAR(20),@Email VARCHAR(50), @Address NVARCHAR(300),
	@Department INT
AS
BEGIN
     DECLARE @Role INT = 2;
	DECLARE @Avatar INT;
	DECLARE @Contact INT;
	DECLARE @UserId INT;
	-- SET NOCOUNT ON added to prevent extra result sets from  
    -- interfering with SELECT statements.
	SET NOCOUNT ON
	INSERT INTO Users VALUES(@UserName,@Password,@Role);
	SET @UserId = @@IDENTITY;

	IF @AvatarName IS NOT NULL AND @AvatarByte IS NOT NULL
		BEGIN
			INSERT INTO Images VALUES(@AvatarName,@AvatarByte);
			SET @Avatar = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Avatar = NULL;
		END
		
	IF @Phone IS NOT NULL OR @Email IS NOT NULL OR @Address IS NOT NULL
		BEGIN
			INSERT INTO Contacts VALUES(@Phone,@Email,@Address);
			SET @Contact = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Contact = NULL;
		END
	INSERT INTO UserInformations VALUES(@UserId,@FirstName,@MidleName,@LastName,@Gender,CONVERT(DATE,@DOB),@Avatar,@Contact)
	INSERT INTO Teachers VALUES(@UserId,@Department);
END
GO
CREATE PROCEDURE stp_InsertAdmin
-- Add the parameters for the stored procedure here
	@UserName VARCHAR(50), @Password VARCHAR(100),
	@FirstName NVARCHAR(20), @MidleName NVARCHAR(20), @LastName NVARCHAR(20),
	@Gender BIT, @DOB VARCHAR(20),
	@AvatarName NVARCHAR(200), @AvatarByte VARBINARY(MAX),
	@Phone VARCHAR(20),@Email VARCHAR(50), @Address NVARCHAR(300)
AS
BEGIN
     DECLARE @Role INT = 1;
	DECLARE @Avatar INT;
	DECLARE @Contact INT;
	DECLARE @UserId INT;
	-- SET NOCOUNT ON added to prevent extra result sets from  
    -- interfering with SELECT statements.
	SET NOCOUNT ON
	INSERT INTO Users VALUES(@UserName,@Password,@Role);
	SET @UserId = @@IDENTITY;

	IF @AvatarName IS NOT NULL AND @AvatarByte IS NOT NULL
		BEGIN
			INSERT INTO Images VALUES(@AvatarName,@AvatarByte);
			SET @Avatar = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Avatar = NULL;
		END
		
	IF @Phone IS NOT NULL OR @Email IS NOT NULL OR @Address IS NOT NULL
		BEGIN
			INSERT INTO Contacts VALUES(@Phone,@Email,@Address);
			SET @Contact = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Contact = NULL;
		END
	INSERT INTO UserInformations VALUES(@UserId,@FirstName,@MidleName,@LastName,@Gender,CONVERT(DATE,@DOB),@Avatar,@Contact)
	INSERT INTO Admins VALUES(@UserId)
END
GO
CREATE PROCEDURE stp_InsertStaff
-- Add the parameters for the stored procedure here
	@UserName VARCHAR(50), @Password VARCHAR(100),
	@FirstName NVARCHAR(20), @MidleName NVARCHAR(20), @LastName NVARCHAR(20),
	@Gender BIT, @DOB VARCHAR(20),
	@AvatarName NVARCHAR(200), @AvatarByte VARBINARY(MAX),
	@Phone VARCHAR(20),@Email VARCHAR(50), @Address NVARCHAR(300),
	@Department INT
AS
BEGIN
	DECLARE @Avatar INT;
	DECLARE @Contact INT;
	DECLARE @UserId INT;
     DECLARE @Role INT = 3;
	-- SET NOCOUNT ON added to prevent extra result sets from  
    -- interfering with SELECT statements.
	SET NOCOUNT ON
	INSERT INTO Users VALUES(@UserName,@Password,@Role);
	SET @UserId = @@IDENTITY;

	IF @AvatarName IS NOT NULL AND @AvatarByte IS NOT NULL
		BEGIN
			INSERT INTO Images VALUES(@AvatarName,@AvatarByte);
			SET @Avatar = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Avatar = NULL;
		END
		
	IF @Phone IS NOT NULL OR @Email IS NOT NULL OR @Address IS NOT NULL
		BEGIN
			INSERT INTO Contacts VALUES(@Phone,@Email,@Address);
			SET @Contact = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Contact = NULL;
		END
	INSERT INTO UserInformations VALUES(@UserId,@FirstName,@MidleName,@LastName,@Gender,CONVERT(DATE,@DOB),@Avatar,@Contact)
	INSERT INTO Staffs VALUES(@UserId, @Department)
END

GO
CREATE PROCEDURE stp_InsertStudent
-- Add the parameters for the stored procedure here
	@UserName VARCHAR(50), @Password VARCHAR(100),
	@FirstName NVARCHAR(20), @MidleName NVARCHAR(20), @LastName NVARCHAR(20),
	@Gender BIT, @DOB VARCHAR(20),
	@AvatarName NVARCHAR(200), @AvatarByte VARBINARY(MAX) NULL,
	@Phone VARCHAR(20),@Email VARCHAR(50), @Address NVARCHAR(300),
	@Major INT,
	@Father NVARCHAR(100),@FPhone VARCHAR(20),@FEmail VARCHAR(50), @FAddress NVARCHAR(300),
	@Mother NVARCHAR(100),@MPhone VARCHAR(20),@MEmail VARCHAR(50), @MAddress NVARCHAR(300)
AS
BEGIN
     DECLARE @Role INT = 4;
	DECLARE @Avatar INT;
	DECLARE @Contact INT;
	DECLARE @UserId INT;
	DECLARE @ParentId INT;
	DECLARE @StudentId INT;
	DECLARE @FContact INT;
	DECLARE @MContact INT;
	DECLARE @MajorCode VARCHAR(10);
	-- SET NOCOUNT ON added to prevent extra result sets from  
    -- interfering with SELECT statements.
	SET NOCOUNT ON
     -- insert user
	INSERT INTO Users VALUES(@UserName,@Password,@Role);
	SET @UserId = @@IDENTITY;
     --insert avatar
	IF @AvatarName IS NOT NULL AND @AvatarByte IS NOT NULL
		BEGIN
			INSERT INTO Images VALUES(@AvatarName,@AvatarByte);
			SET @Avatar = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Avatar = NULL;
		END
		
	IF @Phone IS NOT NULL OR @Email IS NOT NULL OR @Address IS NOT NULL
		BEGIN
			INSERT INTO Contacts VALUES(@Phone,@Email,@Address);
			SET @Contact = @@IDENTITY;
		END
	ELSE
		BEGIN
			SET @Contact = NULL;
		END
	INSERT INTO UserInformations VALUES(@UserId,@FirstName,@MidleName,@LastName,@Gender,CONVERT(DATE,@DOB),@Avatar,@Contact)
	IF @FPhone IS NOT NULL OR @FEmail IS NOT NULL OR @FAddress IS NOT NULL
	     BEGIN
	          INSERT INTO Contacts VALUES(@FPhone,@FEmail,@FAddress)
	          SET @FContact = @@IDENTITY;
	     END
	ELSE
	     BEGIN
	          SET @FContact = NULL;
	     END
	IF @MPhone IS NOT NULL OR @MEmail IS NOT NULL OR @MAddress IS NOT NULL
	     BEGIN
	          INSERT INTO Contacts VALUES(@MPhone,@MEmail,@MAddress)
	          SET @MContact = @@IDENTITY;
	     END
	ELSE
	     BEGIN
	          SET @MContact = NULL;
	     END
	IF @Father IS NOT NULL OR @Mother IS NOT NULL
          BEGIN
               INSERT INTO Parents VALUES(@Father,@FContact,@Mother,@MContact)
	          SET @ParentId = @@IDENTITY
          END
	ELSE
          BEGIN 
               SET @ParentId = NULL;
          END

	SET @MajorCode = (SELECT MajorCode FROM Majors WHERE MajorId = @Major)
	INSERT INTO Students (UserId,Major,EnrollmentDate,Parent) VALUES(@UserId,@Major,DEFAULT,@ParentId)
	UPDATE Students SET StudentCode = CONCAT(@MajorCode, DATEDIFF( YEAR,CONVERT(DATE,'8/9/2006'),GETDATE()) * 1000 + @@IDENTITY) WHERE UserId = @UserId
END

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

     INSERT INTO Applications VALUES(@Department,@Title,GETDATE(),NULL,NULL,NULL)
     SET @DetailId = @@IDENTITY
     INSERT INTO ApplicationDetails VALUES(@DetailId,@StudentId,@Content,@FileId,NULL)
     
END


GO
CREATE PROCEDURE stp_UpdateApplication
@AppId INT,
@AppStatus BIT, @Solved INT,
@FileName NVARCHAR(200), @FileBytes VARBINARY(MAX),
@Solution NVARCHAR(MAX)
AS
BEGIN
     DECLARE @DateClose DATE;
     DECLARE @FileId INT;

     SET NOCOUNT ON

     IF @FileName IS NOT NULL AND @FileBytes IS NOT NULL
          BEGIN 
               INSERT INTO Files VALUES(@FileName,@FileBytes)
               SET @FileId = @@IDENTITY
          END
     ELSE
          BEGIN
               SET @FileId = NULL
          END

     SET @DateClose = GETDATE()

     UPDATE ApplicationDetails SET FileAttached = @FileId, Solution = @Solution WHERE Id = @AppId
     UPDATE Applications SET DateClose = @DateClose, AppStatus = @AppStatus, Solved = @Solved WHERE AppId = @AppId
END

GO
CREATE PROCEDURE stp_SelectApplication
@Title NVARCHAR(500)
AS 
BEGIN
     SET NOCOUNT ON
     DECLARE @Regex NVARCHAR(500)
     SET @Regex = CONCAT('%',@Title, '%')

     SELECT * FROM Applications WHERE Title LIKE @Regex
END

GO
CREATE PROCEDURE stp_SelectApplicationWithDepartment
@Department NVARCHAR(500)
AS 
BEGIN
     SET NOCOUNT ON
     DECLARE @DepartmentId INT;
     SET @DepartmentId = (SELECT DepartmentId FROM Departments WHERE DepartmentName LIKE @Department)

     SELECT * FROM Applications WHERE Department = @DepartmentId
END

GO

/****** Object:  StoredProcedure [dbo].[stp_InsertApplication]    Script Date: 7/21/2021 9:51:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stp_InsertApplication]
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

     INSERT INTO Applications VALUES(@Department,@Title,GETDATE(),NULL,NULL,@DetailId)
END
GO
CREATE PROCEDURE [dbo].[stp_UpdateApplication]
@AppId INT,
@AppStatus BIT, @Solved INT,
@Solution NVARCHAR(MAX)
AS
BEGIN
     DECLARE @DateClose DATE;

     SET NOCOUNT ON

     SET @DateClose = GETDATE()

     UPDATE ApplicationDetails SET Solution = @Solution WHERE Id = @AppId
     UPDATE Applications SET DateClose = @DateClose, AppStatus = @AppStatus, Solved = @Solved WHERE AppId = @AppId
END
GO

CREATE PROCEDURE [dbo].[stp_UpdateApplicationByMe]
@AppId INT,
@AppStatus BIT, @Solved INT,
@Solution NVARCHAR(MAX)
AS
BEGIN
     DECLARE @DateClose DATE;
     DECLARE @TeacherId INT;
     SET NOCOUNT ON
     SET @TeacherId = (SELECT TeacherId FROM Teachers WHERE UserId = @Solved)
     SET @DateClose = GETDATE()

     UPDATE ApplicationDetails SET Solution = @Solution WHERE Id = @AppId
     UPDATE Applications SET DateClose = @DateClose, AppStatus = @AppStatus, Solved = @TeacherId WHERE AppId = @AppId
END
GO
