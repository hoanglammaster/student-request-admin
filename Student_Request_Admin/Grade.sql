CREATE DATABASE DemoGrade
Go
USE DemoGrade
GO
CREATE TABLE Semester(
	SemesterId INT IDENTITY(1000,1) PRIMARY KEY,
	SemesterName VARCHAR(200) NOT NULL,
	StartDate DATE DEFAULT GETDATE(),
	EndDate DATE DEFAULT DATEADD(WEEK,11,GETDATE())
)

CREATE TABLE Student(
	StudentId INT IDENTITY(1000,1) PRIMARY KEY,
	StudentName VARCHAR(200) NOT NULL
)

CREATE TABLE Semester_Student(
	Id INT IDENTITY(1000,1) PRIMARY KEY,
	SemesterId INT NOT NULL FOREIGN KEY (SemesterId) REFERENCES Semester(SemesterId),
	StudentId INT NOT NULL FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
)
CREATE TABLE Subjects(
	SubjectId INT IDENTITY(1000,1) PRIMARY KEY,
	SubjectCode VARCHAR(15) NOT NULL,
	SubjectName VARCHAR(200) NOT NULL
)

CREATE TABLE Classes(
	ClassId INT IDENTITY(1000,1) PRIMARY KEY,
	ClasName VARCHAR(20) NOT NULL
)

CREATE TABLE Class_Student(
	Id INT IDENTITY(1000,1) PRIMARY KEY,
	ClassId INT NOT NULL FOREIGN KEY (ClassId) REFERENCES Classes(ClassId),
	SubjectId INT NOT NULL FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId),
	Semester_Student INT NOT NULL FOREIGN KEY (Semester_Student) REFERENCES Semester_Student(Id)
)



CREATE TABLE GradeCategory(
	Id INT IDENTITY(10000,1) PRIMARY KEY,
	SubjectId INT NOT NULL FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId),
	CategoryName VARCHAR(100) NOT NULL,
	Percents NUMERIC(4,1) NOT NULL
)

CREATE TABLE GradeItems(
	Id INT IDENTITY(10000,1) PRIMARY KEY,
	CategoryId INT NOT NULL FOREIGN KEY (CategoryId) REFERENCES GradeCategory(Id),
	ItemName VARCHAR(100) NOT NULL,
	Persents NUMERIC(4,1) NOT NULL,
)

CREATE TABLE Grades(
	GradeId INT IDENTITY(10000,1) PRIMARY KEY,
	GradeItems INT NOT NULL FOREIGN KEY (GradeItems) REFERENCES GradeItems(Id), 
	Class_Student INT NOT NULL FOREIGN KEY (Class_Student) REFERENCES Class_Student(Id),
	Score NUMERIC(4,2)  NULL
)

GO
INSERT INTO Semester (SemesterName) VALUES('Spring2021')
INSERT INTO Semester (SemesterName) VALUES('Summer2020')
GO
INSERT INTO Student VALUES('Hoang Van Lam')
INSERT INTO Student VALUES('Nguyen Thi Phuong Thao')
INSERT INTO Student VALUES('Hoang Thi Minh Huyen')
INSERT INTO Student VALUES('Hoang Thi Thu Trang')
GO

SELECT * FROM Semester
SELECT * FROM Student
SELECT * FROM Semester_Student
GO
--spring 2021
INSERT INTO Semester_Student VALUES(1000,1000)
INSERT INTO Semester_Student VALUES(1000,1001)
INSERT INTO Semester_Student VALUES(1000,1002)
INSERT INTO Semester_Student VALUES(1000,1003)
--summer 2020
INSERT INTO Semester_Student VALUES(1001,1000)
INSERT INTO Semester_Student VALUES(1001,1001)
INSERT INTO Semester_Student VALUES(1001,1002)
INSERT INTO Semester_Student VALUES(1001,1003)
GO
INSERT INTO Classes VALUES('SE1427')
INSERT INTO Classes VALUES('SE1503')
GO
INSERT INTO Subjects VALUES('MEA','Math Enegiree Alogrim')
INSERT INTO Subjects VALUES('PRO','Progaram Relative Origion')
INSERT INTO Subjects VALUES('SWT','Software Testing')
GO
SELECT * FROM Subjects
SELECT * FROM Semester_Student
SELECT * FROM Classes

GO
--insert 4 student in spring 2021 learn MEA in Class SE1427
INSERT INTO Class_Student VALUES(1000,1000,1000)
INSERT INTO Class_Student VALUES(1000,1000,1001)
INSERT INTO Class_Student VALUES(1000,1000,1002)
INSERT INTO Class_Student VALUES(1000,1000,1003)

--insert 2 student in spring 2021 learn SWT in Class SE1427
INSERT INTO Class_Student VALUES(1000,1001,1001)
INSERT INTO Class_Student VALUES(1000,1001,1002)

--insert 3 student in spring 2021 learn RPO in Class SE1503
INSERT INTO Class_Student VALUES(1001,1002,1000)
INSERT INTO Class_Student VALUES(1001,1002,1001)
INSERT INTO Class_Student VALUES(1001,1002,1003)

GO

SELECT * FROM Class_Student cs
JOIN Classes cl ON cs.ClassId = cl.ClassId
WHERE cs.SubjectId  = 1000 AND cl.ClasName = 'SE1427'

SELECT * FROM Subjects
GO
INSERT INTO GradeCategory VALUES(1000,'Progess Test',10)
INSERT INTO GradeCategory VALUES(1000,'Workshop',10)
INSERT INTO GradeCategory VALUES(1000,'Practical Exam',20)
INSERT INTO GradeCategory VALUES(1000,'Assignment',40)
INSERT INTO GradeCategory VALUES(1000,'Final Exam',20)

SELECT * FROM GradeCategory
SELECT * FROM GradeItems

--
INSERT INTO GradeItems VALUES(10000,'Progess Test 1',5)
INSERT INTO GradeItems VALUES(10000,'Progess Test 2',5)
INSERT INTO GradeItems VALUES(10001,'Workshop 1',5)
INSERT INTO GradeItems VALUES(10001,'Workshop 2',5)
INSERT INTO GradeItems VALUES(10002,'Practical Exam',20)
INSERT INTO GradeItems VALUES(10003,'Assignment',40)
INSERT INTO GradeItems VALUES(10004,'Final Exam',20)
GO
SELECT * FROM GradeItems gi JOIN GradeCategory gc ON gc.Id = gi.CategoryId WHERE gc.SubjectId = 1000

SELECT * FROM Class_Student WHERE SubjectId = 1000
SELECT * FROM Grades
INSERT INTO Grades VALUES (10000,1000,9)
INSERT INTO Grades VALUES (10001,1000,5.5)
INSERT INTO Grades VALUES (10002,1000,10)
INSERT INTO Grades VALUES (10003,1000,9.6)
INSERT INTO Grades VALUES (10004,1000,8.5)
INSERT INTO Grades VALUES (10005,1000,3)
INSERT INTO Grades VALUES (10006,1000,8.75)

INSERT INTO Grades VALUES (10000,1001,4)
INSERT INTO Grades VALUES (10001,1001,5.5)
INSERT INTO Grades VALUES (10002,1001,6)
INSERT INTO Grades VALUES (10003,1001,4.6)
INSERT INTO Grades VALUES (10004,1001,5.5)
INSERT INTO Grades VALUES (10005,1001,3)
INSERT INTO Grades VALUES (10006,1001,7.75)
SELECT * FROM GradeItems
SELECT * FROM GradeCategory
SELECT * FROM Semester_Student WHERE StudentId = 1000
SELECT * FROM Class_Student WHERE Semester_Student = 1000 
SELECT s.SemesterName,s.StartDate,s.EndDate,std.StudentName,sj.SubjectName,cl.ClasName,gc.CategoryName,gi.ItemName,g.Score,gi.Persents  FROM Grades g 
JOIN GradeItems gi ON g.GradeItems = gi.Id
JOIN Class_Student cs ON g.Class_Student = cs.Id
JOIN Semester_Student ss ON cs.Semester_Student = ss.Id
JOIN Student std ON ss.StudentId = std.StudentId
JOIN Semester s ON s.SemesterId = ss.SemesterId
JOIN Subjects sj ON sj.SubjectId = cs.SubjectId
JOIN Classes cl ON cl.ClassId = cs.ClassId
JOIN GradeCategory gc ON gi.CategoryId = gc.Id
WHERE std.StudentId = 1000

SELECT * FROM Student