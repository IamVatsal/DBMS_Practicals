-- DML

CREATE DATABASE SchoolDB_142;

USE SchoolDB_142;

CREATE TABLE Students_142 (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Course VARCHAR(100),
    Marks INT,
    Email VARCHAR(100)
);

INSERT INTO Students_142 (StudentID, Name, Course, Marks, Email) VALUES
(1, 'Vatsal', 'Computer Engineering', 85, 'vatsal@example.com');
-- (2, 'Janvi', 'Computer Engineering', 90, 'janvi@example.com'),
-- (3, 'Preet', 'Computer Engineering', 78, 'preet@example.com');

UPDATE Students_142 SET Marks = 90 WHERE StudentID = 1;

DELETE FROM Students_142 WHERE StudentID = 1;

SELECT * FROM Students_142;

INSERT INTO Students_142 (StudentID, Name, Course, Marks, Email) VALUES
(1, 'Vatsal', 'Computer Engineering', 85, 'vatsal@example.com');

SAVEPOINT sp_insert;

UPDATE Students_142 SET Marks = 95 WHERE StudentID = 1;

ROLLBACK TO sp_insert;

COMMIT;

SELECT * FROM Students_142;
