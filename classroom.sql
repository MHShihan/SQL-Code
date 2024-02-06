CREATE DATABASE college;
USE college;

CREATE TABLE student (
	id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT NOT NULL 
);

INSERT INTO student 
(id, name, age)
VALUES
(1, "Shihan", 23),
(2, "Nabila", 22),
(3, "Razzak", 24),
(4, "Shadhin", 24);

SELECT * FROM student;
