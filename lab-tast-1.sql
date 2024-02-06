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
(1, "Nabila", "Female", 22, 3.48),
(2, "Momi", "Female", 22, 3.22);

DROP TABLE Student;