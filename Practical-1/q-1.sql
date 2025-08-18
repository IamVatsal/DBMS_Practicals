-- DDL

CREATE DATABASE SchoolDB_142;

USE SchoolDB_142;

CREATE TABLE Students_142 (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Course VARCHAR(100),
    Marks INT
);

ALTER TABLE Students_142 ADD Email VARCHAR(100);

ALTER TABLE Students_142 MODIFY Marks FLOAT;

RENAME TABLE Students_142 TO StudentRecords_142;

TRUNCATE TABLE StudentRecords_142;

DROP TABLE StudentRecords_142;
