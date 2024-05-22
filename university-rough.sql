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

CREATE TABLE pr2.AreaOfStudy
(
	AreaOfStudyID	    VARCHAR(20)				PRIMARY KEY,
	StudyTitle	        VARCHAR(50)			NOT NULL,
	CollegeID	        INTEGER				NOT NULL	REFERENCES pr2.College(CollegeID)
);


CREATE TABLE pr2.ClassRoom
(
	ClassRoomID		VARCHAR(20)  NOT NULL	PRIMARY KEY,
	RoomNumber		VARCHAR(20)  NOT NULL,
	MaximumSeating	INTEGER      NOT NULL   CHECK(MaximumSeating > 0),
	WhiteBoardCount INTEGER      NOT NULL,
	OtherAV         VARCHAR(20)  
);

CREATE TABLE pr2.College
(
	CollegeID	INTEGER		PRIMARY KEY		AUTO_INCREMENT PRIMARY KEY,
	CollegeName	VARCHAR(20)	NOT NULL		UNIQUE
);


CREATE TABLE pr2.CourseDailySchedule
(
	DailyID			INTEGER	   AUTO_INCREMENT PRIMARY KEY,
	CourseID		INTEGER	  NOT NULL        UNIQUE			REFERENCES pr2.CourseSchedule(CourseScheduleID),
	DayOfWeek		INTEGER	  NOT NULL							REFERENCES pr2.DayOfWeek(Id),
	StartTime		TIME	  NOT NULL,
	EndTime     	TIME      NOT NULL		  CHECK (EndTime > StartTime)
);

CREATE TABLE pr2.CourseEnrollment
(
	EnrollmentID	INTEGER	        PRIMARY KEY,
	CourseID	    INTEGER	        NOT NULL      REFERENCES    pr2.CourseSchedule(CourseScheduleID),
	StudentID	    INTEGER	        NOT NULL      REFERENCES    pr2.StudentInfo(StudentID),
	StatusID	    INTEGER	        NOT NULL      REFERENCES    pr2.StudentGradingStatus(StudentGradingStatusID),
	GradeID	        INTEGER	                      REFERENCES    pr2.Grades(GradeID)
);

CREATE TABLE pr2.CourseSchedule
(
	CourseScheduleID INTEGER   AUTO_INCREMENT PRIMARY KEY,
	CourseCode       VARCHAR(20) NOT NULL,
	CourseNumber	 INTEGER     NOT NULL,
	NumberOfSeats    INTEGER     NOT NULL CHECK(NumberOfSeats>=0),
	Location		 VARCHAR(20)          REFERENCES pr2.ClassRoom(ClassRoomID),
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
	JobRequirements VARCHAR(500),
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
	Password     VARCHAR(50),
	DOB          DATE           NOT NULL,
	SSN          VARCHAR(11),
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
	LastDay		DATE		NOT NULL          CHECK(LastDay > FirstDay)
);

CREATE TABLE pr2.SemesterText
(
	SemesterTextID	INTEGER			AUTO_INCREMENT PRIMARY KEY,
	SemesterText	VARCHAR(50)		NOT NULL
);

CREATE TABLE pr2.StudentAreaOfStudy
(
	AreaOfStudyID	INTEGER	      PRIMARY KEY,
	StudentID		INTEGER	      NOT NULL		REFERENCES pr2.StudentInfo(StudentID),
	AreaID		    VARCHAR(20)	  NOT NULL		REFERENCES pr2.AreaOfStudy(AreaOfStudyID),
	IsMajor			VARCHAR(3)	  NOT NULL
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

CREATE TABLE pr2.TeachingAssignment
(
	EmployeeID           VARCHAR(20)     NOT NULL	  REFERENCES pr2.EmployeeInfo(EmployeeID),
	CourseScheduleID     INTEGER         NOT NULL     REFERENCES pr2.CourseSchedule(CourseScheduleID) ,
	PRIMARY KEY (EmployeeID, CourseScheduleID)
);



-- Data Loading commands
-- *************************

-- Data inserted seperately was added later for testing purpose

INSERT INTO pr2.Addresses (Street1, Street2 , City , State , ZIP) VALUES 
('740 Park Avenue','Westcott Street','Syracuse','NewYork','13210'),
('437 Columbus Avenue','Westcott Street','Syracuse','NewYork','13210'),
('128 Westcott Street',NULL,'Syracuse','NewYork','13210'),
('12th Avenue',NULL,'Syracuse','NewYork','13210'),
('1120 N Street','Eureka','Sacremento','California','96001'),
('111 Grand Avenue',NULL,'East Bay','California','96000'),
('Paras Apartment','Paud Road','Pune','Maharashtra','411038'),
('123 Kailas Tower','Powai','Mumbai','Maharashtra','760004');

-- SELECT * FROM pr2.Addresses

INSERT INTO pr2.AreaOfStudy VALUES
('01-CE','Computer Engineering',1),
('02-ME','Mechanical Engineering',1),
('03-CE','Civil Engineering',1),
('04-AP','Astrophysics',3),
('05-SE','Systems Engineering',1),
('08-S','Statistics',5);

-- SELECT * FROM pr2.AreaOfStudy

-- INSERT INTO pr2.Benefits (BenefitCost,BenefitDescription,BenefitSelection) VALUES
-- (1000,'OutpatientCare',3),
-- (2000,'ICU',1),
-- (3000, 'InpatientCare',2),
-- (4000, 'BabyCare',2),
-- (5000, 'Psychotherapy',1),
-- (6000, 'LabTest',3)

-- SELECT * FROM pr2.Benefits






INSERT INTO pr2.ClassRoom (ClassRoomID,Building,RoomNumber,MaximumSeating,Projector,WhiteBoardCount,OtherAV) VALUES
('01-CC',1,'CC-101',50,2,3,'Slide Projector'),
('02-HL',2,'HL-410',50,3,2,'Conference Phone'),
('03-HC',3,'HC-114',40,1,2,'Handheld Microphone'),
('04-CST',4,'CST-112',80,3,1,'Tape Player'),
('05-NCC',5,'NCC-312',30,4,0,'Podiums'),
('06-SC',6,'SC-222',20,2,3,'Audio Recording');

-- SELECT * FROM pr2.ClassRoom

INSERT INTO pr2.College(CollegeName)VALUES
('College Of Engineering'),
('College of Journalism'),
('College of Information Studies'),
('College of Management Studies'),
('Physics College'),
('College of Mathematics'),
('Arts college'),
('College of Pschycology studies');

-- SELECT * FROM pr2.College

INSERT INTO pr2.CourseCatalogue VALUES('CS','702','Integer Optimization','Introduces optimization problems over integers, and surveys the theory behind the algorithms used in state-of-the-art methods for solving such problems.');
INSERT INTO pr2.CourseCatalogue VALUES('CS','612','Machine Learning','Computational approaches to learning: including inductive inference, explanation-based learning, analogical learning, connectionism, and formal models.');
INSERT INTO pr2.CourseCatalogue VALUES('EE','632','VLSI Systems Design','Overview of MOS devices and circuits; introduction to integrated circuit fabrication; topological design of data flow and control; interactive graphics layout; circuit simulation; system timing; organizational and architectural considerations; alternative implementation approaches');
INSERT INTO pr2.CourseCatalogue VALUES('EE','662','Advanced Computer Architecture','Advanced techniques of computer design. Parallel processing and pipelining; multiprocessors, multi-computers and networks; high performance machines and special purpose processors; data flow architecture.');
INSERT INTO pr2.CourseCatalogue VALUES('CS','772','Distributed Systems','distributed programming; distributed file systems; atomic actions; fault tolerance, transactions, program & data replication, recovery; distributed machine architectures; security and authentication');
INSERT INTO pr2.CourseCatalogue VALUES('CS','692','Dynamic Programming','A generalized optimization model; discrete and continuous state spaces; deterministic and stochastic transition functions. Multistage decision processes. Functional equations and successive approximation in function ');
INSERT INTO pr2.CourseCatalogue VALUES('MAE','111','Energy Conversion','Energy demand and resources. Fundamentals of combustion. Power plants, refrigeration systems. Turbines and engines.');
INSERT INTO pr2.CourseCatalogue VALUES('CE','775','Distributed Objects','Design and implement software components using the Component Object Model (COM).');

-- SELECT * FROM pr2.CourseCatalogue

INSERT INTO pr2.CourseDailySchedule (CourseID , DayOfWeek , StartTime , EndTime) VALUES
(13,2,'13:00:00','15:00:00');

-- DBCC CHECKIDENT ('pr2.CourseDailySchedule', RESEED, 2)

INSERT INTO pr2.CourseDailySchedule (CourseID , DayOfWeek , StartTime , EndTime) VALUES
(19,2,'15:00:00','17:00:00');

-- DBCC CHECKIDENT ('pr2.CourseDailySchedule', RESEED, 4)

INSERT INTO pr2.CourseDailySchedule (CourseID , DayOfWeek , StartTime , EndTime) VALUES
(20,3,'16:00:00','18:00:00'),
(21,4,'18:00:00','19:20:00'),
(22,5,'9:00:00','10:30:00'),
(27,3,'16:30:00','19:00:00'),
(29,1,'15:00:00','18:00:00'),
(30,1,'16:00:00','19:00:00');

-- SELECT * FROM pr2.CourseDailySchedule

INSERT INTO pr2.CourseEnrollment (EnrollmentID,CourseID,StudentID,StatusID,GradeID) VALUES
(200,13,1,1,1),
(201,19,1,2,NULL),
(202,20,3,1,4),
(203,21,4,2,2),
(204,22,5,2,NULL),
(205,27,2,1,1),
(206,13,6,1,NULL);

-- SELECT * FROM pr2.CourseEnrollment

-- DBCC CHECKIDENT ('pr2.CourseSchedule', RESEED, 12)

INSERT INTO pr2.CourseSchedule (CourseCode,CourseNumber,NumberOfSeats,Location,Semester) VALUES 
('CS', 612 ,50,'04-CST',1);

-- DBCC CHECKIDENT ('pr2.CourseSchedule', RESEED, 18)
INSERT INTO pr2.CourseSchedule (CourseCode,CourseNumber,NumberOfSeats,Location,Semester) VALUES 
('CS', 692 ,60,'04-CST',2),
('EE', 632 ,25,'05-NCC',3),
('EE', 662 ,35,'03-HC',4),
('CS', 702 ,45,'02-HL',5);

-- DBCC CHECKIDENT ('pr2.CourseSchedule', RESEED, 26)
INSERT INTO pr2.CourseSchedule (CourseCode,CourseNumber,NumberOfSeats,Location,Semester) VALUES 
('CS', 772 ,15,NULL,7);

-- DBCC CHECKIDENT ('pr2.CourseSchedule', RESEED, 28)
INSERT INTO pr2.CourseSchedule (CourseCode,CourseNumber,NumberOfSeats,Location,Semester) VALUES 
('MAE', 111 ,30,NULL,1),
('CE', 775 , 30 , NULL , 8);

-- SELECT * FROM pr2.CourseSchedule

INSERT INTO pr2.DayOfWeek(Text) VALUES
('Sunday'),
('Monday'),
('Tuesday'),
('Wednesday'),
('Thursday'),
('Friday'),
('Saturday');

-- SELECT * FROM pr2.DayOfWeek;

INSERT INTO pr2.EmployeeInfo (EmployeeID, PersonID , YearlyPay , HealthBenefits , VisionBenefits, DentalBenefits , JobInformation) VALUES
('01-PR', 7 , 23000.00 , 2 , 1 , 3 , 4),
('02-TA', 9 , 10000.00 , 1 , 5 , 1 , 6),
('03-TS', 8 , 50000.00 , 5 , 2 , 4 , 2),
('04-FA', 10 , 3000.00 , 4 , 6 , 2 , 1),
('05-AA', 12 , 40000.00 , 1 , 4 , 5 , 6),
('10-GI', 11 , 5000.00 , 2 , 4 , 1 , 3);

-- SELECT * FROM pr2.EmployeeInfo

INSERT INTO pr2.Grades(Grade)VALUES
('A'),
('B'),
('C'),
('D');

-- SELECT * FROM pr2.Grades

INSERT INTO pr2.JobInformation (JobDescription,JobRequirements,MinPay,MaxPay,UnionJob) VALUES
('Professor','Minimum Qualification is PhD and a minimum of 5 years teaching experience',2000.00,50000.00,'No'),
('Assistant Professor','Minimum Qualification is PhD and a minimum of 2 years teaching experience', 10000.00,80000.00,'Yes'),
('Visiting Professor','Minimum Qualification is PhD and a minimum of 2 years Industry experience',6000.00,60000.00,'No'),
('Lecturer','Minimum of a bachelor degree in an academic field of study',10000.00,90000.00,'Yes'),
('Research Professor','Minimum of a doctoral degree in an academic field of study and a minimum of 4 years research experience',7000.00,45000.00,'No'),
('Teaching Assistant','Minimum of a bachelor degree in an academic field of study and persuing doctoral degree',10000.00,95000.00,'No');

-- SELECT * FROM pr2.JobInformation

-- Students
INSERT INTO pr2.People (NTID ,FirstName, LastName, Password, DOB , SSN , HomeAddress , LocalAddress , IsActive) VALUES
('07-GA','Gomez','Addams','JASj23','19931204','374-AB-WE12', 1 , NULL, 'Yes'),
('08-MA','Morticia','Addams','ehreu12_ty', '19940112',NULL , 3 , 4, 'Yes'),
('09-PA','Pugsley','Addams',NULL, '19920215', NULL , 3 , 1, 'Yes'),
('10-WA','Wednesday','Addams','wed12nes34day_77', '19900618','F56-TH-4657' , 4 , 6, 'No'),
('11-UF','Uncle','Fester', NULL , '19920214','Q12-FH-5623', 2 , NULL, 'Yes'),
('12-GA','Grandmama','Addams', 'fhdfh&48' , '19800719','439-SD-1234', 5 , 3 , 'No');

-- Professors/employees
INSERT INTO pr2.People (NTID ,FirstName, LastName, Password, DOB , SSN , HomeAddress , LocalAddress , IsActive) VALUES
('01-Sd','Scooby','Doo','Hello123','20080618 10:34:09 AM','102-02-1992', 1 , 2, 'Yes'),
('02-Sr','Shaggy','Rogers',NULL, '19930413 10:34:09 AM','1AB-01-1912',1 , 2, 'Yes'),
('03-Fj','Fred','Jones',NULL, '19920609 10:55:10 AM','113-0B-19LK' ,5 , 4, 'Yes'),
('04-Db','Daphne','Blake','Shaggy221', '19900218 09:34:09 AM','FHJ-59-5759' ,1 , 6, 'No'),
('05-Vd','Velma','Dinkley','11Velm12', '19921020 08:30:09 AM','HJC-36-8430',2 , NULL, 'Yes'),
('06-Yd','Yabba','Doo',NULL, '19900719 04:17:19 AM','475-47-SGFC', 5 , NULL, 'No');

-- SELECT * FROM pr2.People


INSERT INTO pr2.SemesterInfo(Semester,Year,FirstDay,LastDay)VALUES
(1,2012,'20120618','20121218'),
(2,2013,'20130116','20130516'),
(1,2013,'20130616','20131216'),
(2,2014,'20140116','20140516'),
(1,2014,'20140616','20141216'),
(2,2015,'20150116','20150516');

INSERT INTO pr2.SemesterInfo(Semester,Year,FirstDay,LastDay)VALUES
(1,2016,'20160618','20161218');

INSERT INTO pr2.SemesterInfo(Semester,Year,FirstDay,LastDay)VALUES
(2,2016,'20160116','20160518');

-- SELECT * FROM pr2.SemesterInfo

INSERT INTO pr2.SemesterText(SemesterText) VALUES
('FALL'),
('SPRING'), 
('SUMMER');

-- SELECT * FROM pr2.SemesterText

INSERT INTO pr2.StudentAreaOfStudy (AreaOfStudyID,StudentID,AreaID,IsMajor) VALUES
(100, 2 , '01-CE' , 'Yes'),
(101, 1 , '02-ME' , 'No'),
(102, 5 , '03-CE' , 'Yes'),
(103, 6 , '04-AP' , 'No'),
(104, 3 , '05-SE' , 'Yes'),
(105, 4 , '08-S' , 'No');

-- SELECT * FROM pr2.StudentAreaOfStudy

INSERT INTO pr2.StudentGradingStatus (StudentGradingStatus) VALUES ('Graded');
INSERT INTO pr2.StudentGradingStatus (StudentGradingStatus) VALUES ('Ungraded');

-- SELECT * FROM pr2.StudentGradingStatus

INSERT INTO pr2.StudentInfo (PersonID, StudentStatusID) VALUES
(3,4),
(4,3),
(6,3),
(1,1),
(5,2),
(2,4);

-- SELECT * FROM pr2.StudentInfo

INSERT INTO pr2.StudentStatus (StudentStatus) VALUES 
('Full-Time'),
('Part-Time'),
('Voluntary Withdrawal'),
('Expelled');

-- SELECT * FROM pr2.StudentStatus

INSERT INTO pr2.TeachingAssignment (EmployeeID,CourseScheduleID) VALUES
('01-PR',13),
('02-TA',19),
('03-TS',20),
('04-FA',21),
('05-AA',22),
('10-GI',27)

-- SELECT * FROM pr2.TeachingAssignment