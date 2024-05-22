CREATE DATABASE shihan;
USE shihan;

CREATE TABLE shihanInfo (
firsName VARCHAR(20),
lastName VARCHAR(20),
age INT,
university VARCHAR(50),
CGPA FLOAT
);

INSERT INTO shihanInfo
VALUES (
"Mahmudul Hasan",
"Hasan",
23,
"Uttara University",
3.95
);

SELECT * FROM  shihanInfo;