CREATE DATABASE Person;
CREATE DATABASE Employee;

DROP DATABASE Employee;

USE Person;

CREATE TABLE Student(
	StudentId INT PRIMARY KEY,
    Name VARCHAR(50),
	Gender VARCHAR(20),
    Age INT NOT NULL,
    GPA FLOAT
);

INSERT INTO Student
(StudentId, Name, Gender, Age, GPA)
VALUES
(1, "Shihan", "Male", 23, 3.96),
(2, "Razzak", "Male", 24, 3.75),
(3, "Shadhin", "Male", 24, 3.50);

SELECT * FROM Student;
DROP TABLE Student;
DROP DATABASE Person;



