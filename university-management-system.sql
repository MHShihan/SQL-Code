CREATE SCHEMA pr2;
USE pr2;
CREATE TABLE pr2.Addresses
(
	AddressID     INTEGER       AUTO_INCREMENT PRIMARY KEY,
	Street1       VARCHAR(20)    NOT NULL,
	Street2       VARCHAR(20),
	City          VARCHAR(20)    NOT NULL,
	State         VARCHAR(20)    NOT NULL,
	ZIP           VARCHAR(10)    NOT NULL
);

CREATE TABLE pr2.ClassRoom
(
	ClassRoomID		VARCHAR(20)  NOT NULL	PRIMARY KEY,
	RoomNumber		VARCHAR(20)  NOT NULL,
	MaximumSeating	INTEGER      NOT NULL   CHECK(MaximumSeating > 0),
	WhiteBoardCount INTEGER      NOT NULL,
	OtherAV         VARCHAR(20)  
);
CREATE TABLE pr2.CourseDailySchedule
(
	DailyID			INTEGER	   AUTO_INCREMENT PRIMARY KEY,
	CourseID		INTEGER	  NOT NULL        UNIQUE			REFERENCES pr2.CourseSchedule(CourseScheduleID),
	DayOfWeek		INTEGER	  NOT NULL							REFERENCES pr2.DayOfWeek(Id),
	StartTime		TIME	  NOT NULL,
	EndTime     	TIME      NOT NULL		  
);

CREATE TABLE pr2.CourseEnrollment
(
	EnrollmentID	INTEGER	        PRIMARY KEY,
	CourseID	    INTEGER	        NOT NULL      REFERENCES    pr2.CourseSchedule(CourseScheduleID),
	StudentID	    INTEGER	        NOT NULL      REFERENCES    pr2.StudentInfo(StudentID),
	StatusID	    INTEGER	        NOT NULL      REFERENCES    pr2.StudentGradingStatus(StudentGradingStatusID),
	GradeID	        INTEGER	                      REFERENCES    pr2.Grades(GradeID)
);

SELECT * 
FROM pr2.CourseEnrollment ce
JOIN pr2.CourseSchedule cs ON ce.CourseScheduleId = cs.CourseScheduleId;


CREATE TABLE pr2.CourseSchedule
(
	CourseScheduleID INTEGER   AUTO_INCREMENT PRIMARY KEY,
	CourseCode       VARCHAR(20) NOT NULL,
	CourseNumber	 INTEGER     NOT NULL,
	NumberOfSeats    INTEGER     NOT NULL CHECK(NumberOfSeats>=0),
	Location		 VARCHAR(100)          REFERENCES pr2.ClassRoom(ClassRoomID),
	Semester		 INTEGER     NOT NULL REFERENCES pr2.SemesterInfo(SemesterID)
);

CREATE TABLE pr2.DayOfWeek
(
	Id	    INTEGER		AUTO_INCREMENT PRIMARY KEY,
	Text	VARCHAR(50)		NOT NULL	 UNIQUE
);

CREATE TABLE pr2.EmployeeInfo
(
	EmployeeID     VARCHAR(20)    PRIMARY KEY,
	PersonID       INTEGER        NOT NULL       REFERENCES pr2.People(PersonID),
	YearlyPay      DECIMAL(10,2)  NOT NULL,
	JobInformation InTEGER        NOT NULL       REFERENCES pr2.JobInformation(JobID)
);

CREATE TABLE pr2.Grades
(
	GradeID	    INTEGER	      AUTO_INCREMENT PRIMARY KEY,
	Grade		VARCHAR(20)	   NOT NULL		 UNIQUE
);

CREATE TABLE pr2.JobInformation
( 
	JobID           INTEGER        AUTO_INCREMENT PRIMARY KEY,
	JobDescription  VARCHAR(500)   NOT NULL,
	MinPay          DECIMAL(10,2)  NOT NULL       CHECK  (Minpay >= 0),
    MaxPay          DECIMAL(10,2)  NOT NULL       CHECK  (Maxpay >= 0),
	UnionJob        VARCHAR(3)     NOT NULL	      DEFAULT 'Yes'
);

CREATE TABLE pr2.People
(
	PersonID     INTEGER       	AUTO_INCREMENT PRIMARY KEY,
	NTID         VARCHAR(20)    NOT NULL		UNIQUE,
	FirstName    VARCHAR(50)    NOT NULL,
    LastName     VARCHAR(50)    NOT NULL,
	designation  VARCHAR(20) NOT NULL,
    age          INTEGER NOT NULL,
	HomeAddress  INTEGER        NOT NULL		REFERENCES pr2.Addresses(AddressID),
	LocalAddress INTEGER						REFERENCES pr2.Addresses(AddressID),
	IsActive     VARCHAR(3)     NOT NULL		DEFAULT 'Yes'
);

CREATE TABLE pr2.SemesterInfo
(
	SemesterID	INTEGER	   AUTO_INCREMENT PRIMARY KEY,
	Semester	INTEGER	    NOT NULL		  REFERENCES        pr2.SemesterText(SemesterTextID),
	Year		INTEGER	    NOT NULL,
	FirstDay	DATE		NOT NULL,
	LastDay		DATE		NOT NULL          
);

CREATE TABLE pr2.SemesterText
(
	SemesterTextID	INTEGER			AUTO_INCREMENT PRIMARY KEY,
	SemesterText	VARCHAR(50)		NOT NULL
);

CREATE TABLE pr2.StudentGradingStatus
(
	StudentGradingStatusId      INTEGER	       AUTO_INCREMENT PRIMARY KEY,
	StudentGradingStatus        VARCHAR(20)    NOT NULL
);

CREATE TABLE pr2.StudentInfo 
(
	StudentID				INTEGER	   AUTO_INCREMENT PRIMARY KEY,
	PersonID				INTEGER 	NOT NULL       REFERENCES     pr2.People(PersonID),
	StudentStatusID			INTEGER					   REFERENCES     pr2.StudentStatus(StudentStatusID)	
);

CREATE TABLE pr2.StudentStatus 
(
	StudentStatusID      INTEGER	    AUTO_INCREMENT PRIMARY KEY,
	StudentStatus		 VARCHAR(80)	NOT NULL
);


-- *************************
-- Data Insercation 
-- **************************
INSERT INTO pr2.Addresses (Street1, Street2 , City , State , ZIP) VALUES 
('740 Park Avenue','Westcott Street','Syracuse','NewYork','13210'),
('437 Columbus Avenue','Westcott Street','Syracuse','NewYork','13210'),
('128 Westcott Street',NULL,'Syracuse','NewYork','13210'),
('12th Avenue',NULL,'Syracuse','NewYork','13210'),
('1120 N Street','Eureka','Sacremento','California','96001'),
('111 Grand Avenue',NULL,'East Bay','California','96000'),
('Paras Apartment','Paud Road','Pune','Maharashtra','411038'),
('123 Kailas Tower','Powai','Mumbai','Maharashtra','760004');
-- SELECT * FROM pr2.Addresses;

INSERT INTO pr2.ClassRoom (ClassRoomID, RoomNumber,MaximumSeating, WhiteBoardCount,OtherAV) VALUES
('01-CC','CC-101',50, 3,'Slide Projector'),
('02-HL','HL-410',50 ,2,'Conference Phone'),
('03-HC','HC-114',40 ,2,'Handheld Microphone'),
('04-CST','CST-112',80, 1,'Tape Player'),
('05-NCC','NCC-312',30 ,0,'Podiums'),
('06-SC','SC-222',20, 3,'Audio Recording');
-- SELECT * FROM pr2.ClassRoom;

INSERT INTO pr2.CourseDailySchedule (CourseID , DayOfWeek , StartTime , EndTime) VALUES
(13,2,'13:00:00','15:00:00'),
(19,2,'15:00:00','17:00:00'),
(20,3,'16:00:00','18:00:00'),
(21,4,'18:00:00','19:20:00'),
(22,5,'9:00:00','10:30:00'),
(27,3,'16:30:00','19:00:00'),
(29,1,'15:00:00','18:00:00'),
(30,1,'16:00:00','19:00:00');
-- SELECT * FROM pr2.CourseDailySchedule;

INSERT INTO pr2.CourseEnrollment (EnrollmentID,CourseID,StudentID,StatusID,GradeID) VALUES
(200,13,1,1,1),
(201,19,1,2,NULL),
(202,20,3,1,4),
(203,21,4,2,2),
(204,22,5,2,NULL),
(205,27,2,1,1),
(206,13,6,1,NULL);
-- SELECT * FROM pr2.CourseEnrollment;

INSERT INTO pr2.CourseSchedule (CourseCode,CourseNumber,NumberOfSeats,Location,Semester) VALUES 
('CS', 612 ,50,'04-CST',1),
('CS', 692 ,60,'04-CST',2),
('EE', 632 ,25,'05-NCC',3),
('EE', 662 ,35,'03-HC',4),
('CS', 702 ,45,'02-HL',5),
('CS', 772 ,15,NULL,7),
('MAE', 111 ,30,NULL,1),
('CE', 775 , 30 , NULL , 8);
-- SELECT * FROM pr2.CourseSchedule;

INSERT INTO pr2.DayOfWeek(Text) VALUES
('Sunday'),
('Monday'),
('Tuesday'),
('Wednesday'),
('Thursday'),
('Friday'),
('Saturday');
-- SELECT * FROM pr2.DayOfWeek;

INSERT INTO pr2.EmployeeInfo (EmployeeID, PersonID , YearlyPay , JobInformation) VALUES
('01-PR', 7 , 23000.00 , 4),
('02-TA', 9 , 10000.00 ,  6),
('03-TS', 8 , 50000.00 , 2),
('04-FA', 10 , 3000.00 ,  1),
('05-AA', 12 , 40000.00 , 6),
('10-GI', 11 , 5000.00 , 3);
-- SELECT * FROM pr2.EmployeeInfo;

INSERT INTO pr2.Grades(Grade)VALUES
('A'),
('B'),
('C'),
('D');
-- SELECT * FROM pr2.Grades;

INSERT INTO pr2.JobInformation (JobDescription, MinPay,MaxPay,UnionJob) VALUES
('Professor',2000.00,50000.00,'No'),
('Assistant Professor',10000.00,80000.00,'Yes'),
('Visiting Professor', 6000.00,60000.00,'No'),
('Lecturer', 10000.00,90000.00,'Yes'),
('Research Professor', 7000.00,45000.00,'No'),
('Teaching Assistant', 10000.00,95000.00,'No');
-- SELECT * FROM pr2.JobInformation;

-- Students
INSERT INTO pr2.People (NTID ,FirstName, LastName, age, designation , HomeAddress , LocalAddress , IsActive) VALUES
('07-GA','Gomez','Addams', 22,'student', 1 , NULL, 'Yes'),
('08-MA','Morticia','Addams',23, 'student', 3 , 4, 'Yes'),
('09-PA','Pugsley','Addams',24, 'student', 3 , 1, 'Yes'),
('10-WA','Wednesday','Addams',22, 'student' , 4 , 6, 'No'),
('11-UF','Uncle','Fester', 25 , 'student', 2 , NULL, 'Yes'),
('12-GA','Grandmama','Addams', 23 , 'student', 5 , 3 , 'No');

-- Professors/employees
INSERT INTO pr2.People (NTID ,FirstName, LastName,age,  designation, HomeAddress , LocalAddress , IsActive) VALUES
('01-Sd','Scooby','Doo',45,'professor', 1 , 2, 'Yes'),
('02-Sr','Shaggy','Rogers',46, 'professor',1 , 2, 'Yes'),
('03-Fj','Fred','Jones',47, 'professor' ,5 , 4, 'Yes'),
('04-Db','Daphne','Blake',50, 'employee' ,1 , 6, 'No'),
('05-Vd','Velma','Dinkley',30, 'employee',2 , NULL, 'Yes'),
('06-Yd','Yabba','Doo',30, 'employee', 5 , NULL, 'No');
-- SELECT * FROM pr2.People;

-- SELECT * FROM pr2.people p
-- LEFT JOIN pr2.Addresses a ON p.HomeAddress = a.AddressId
-- JOIN pr2.Addresses la ON p.LocalAddress = la.AddressId;

INSERT INTO pr2.SemesterInfo(Semester,Year,FirstDay,LastDay)VALUES
(1,2012,'20120618','20121218'),
(2,2013,'20130116','20130516'),
(1,2013,'20130616','20131216'),
(2,2014,'20140116','20140516'),
(1,2014,'20140616','20141216'),
(2,2015,'20150116','20150516'),
(1,2016,'20160618','20161218'),
(2,2016,'20160116','20160518');
-- SELECT * FROM pr2.SemesterInfo;

INSERT INTO pr2.SemesterText(SemesterText) VALUES
('FALL'),
('SPRING'), 
('SUMMER');
-- SELECT * FROM pr2.SemesterText;

INSERT INTO pr2.StudentGradingStatus (StudentGradingStatus) VALUES ('Graded');
INSERT INTO pr2.StudentGradingStatus (StudentGradingStatus) VALUES ('Ungraded');
-- SELECT * FROM pr2.StudentGradingStatus;

INSERT INTO pr2.StudentInfo (PersonID, StudentStatusID) VALUES
(3,4),
(4,3),
(6,3),
(1,1),
(5,2),
(2,4);
-- SELECT * FROM pr2.StudentInfo;

INSERT INTO pr2.StudentStatus (StudentStatus) VALUES 
('Full-Time'),
('Part-Time'),
('Voluntary Withdrawal'),
('Expelled');
-- SELECT * FROM pr2.StudentStatus;
 
-- SELECT *
-- FROM pr2.StudentInfo s
-- JOIN pr2.People p ON s.PersonId = p.PersonID
-- JOIN pr2.StudentStatus st ON s.StudentStatusID = st.StudentStatusID;







