-- PROMPT 24012011142_Vatsal [\d] \D \n>

-- Start Logging
-- tee C:\Users\Vatsal\Desktop\Sem3\DBMS\Practical-8\log.txt

-- Create Database
DROP DATABASE IF EXISTS practical_8_24012011142;
CREATE DATABASE practical_8_24012011142;
USE practical_8_24012011142;

-- Task 1
-- Create Functions
-- Addition Function

DELIMITER $$

CREATE FUNCTION addition(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a + b;
END$$

-- Subtraction Function

CREATE FUNCTION subtraction(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a - b;
END$$

-- Multiplication Function

CREATE FUNCTION multiplication(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a * b;
END$$

-- Division Function

CREATE FUNCTION division(a INT, b INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN a / b;
END$$

DELIMITER ;

-- Testing the Functions
SELECT addition(10,10);
SELECT subtraction(10,5);
SELECT multiplication(10,5);
SELECT division(10,4);


-- Task 2
-- Function that returns max of two numbers

DELIMITER $$

CREATE FUNCTION max_two(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    IF a > b THEN
        RETURN a;
    ELSE
        RETURN b;
    END IF;
END$$

DELIMITER ;

-- Testing the Function

SELECT max_two(10,20);
SELECT max_two(30,15);


-- Task 3
-- Calculator Function (‘+’, ‘-’, ‘*’, ‘/’)

DELIMITER $$

CREATE FUNCTION calculator(a DECIMAL(10,2), b DECIMAL(10,2), op CHAR(1))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    IF op = '+' THEN
        RETURN a + b;
    ELSEIF op = '-' THEN
        RETURN a - b;
    ELSEIF op = '*' THEN
        RETURN a * b;
    ELSEIF op = '/' THEN
        RETURN a / b;
    ELSE
        RETURN NULL;
    END IF;
END$$

DELIMITER ;

-- Testing the Calculator Function

SELECT calculator(10, 5, '+');
SELECT calculator(10, 5, '*');

-- Task 4.
-- Table: Employee_Details(Emp_No, Name, Salary)

CREATE TABLE Employee_Details (
    Emp_No INT,
    Name VARCHAR(255),
    Salary DECIMAL(10,2)
);

DESC Employee_Details;

INSERT INTO Employee_Details (Emp_No, Name, Salary) VALUES
(1, 'Vatsal', 50000.00),
(2, 'Riya', 60000.00),
(3, 'Aryan', 55000.00),
(4, 'Sneha', 70000.00),
(5, 'Keta', 65000.00);

SELECT * FROM Employee_Details;

-- Function to update salary = salary + (salary * percentage / 100)

DELIMITER $$

CREATE PROCEDURE update_salary(
    IN empName VARCHAR(50),
    IN percentage DECIMAL(5,2)
)
BEGIN
    UPDATE Employee_Details
    SET salary = salary + (salary * percentage / 100)
    WHERE Name = empName;
END$$

DELIMITER ;

-- Test the procedure

SELECT * FROM Employee_Details;

CALL update_salary('Vatsal', 10);

SELECT * FROM Employee_Details;


-- Task 5.
-- Table: Company1(no, name)
-- Table: Company2(no, name, operation)

CREATE TABLE Company1 (
    no INT,
    name VARCHAR(50)
);

CREATE TABLE Company2 (
    no INT,
    name VARCHAR(50),
    operation VARCHAR(20)
);

DESC Company1;
DESC Company2;

INSERT INTO Company1 (no, name) VALUES
(1, 'Vatsal'),
(2, 'Riya'),
(3, 'Aryan');

-- Trigger to log UPDATE operations

DELIMITER $$

CREATE TRIGGER log_update_company1
AFTER UPDATE ON Company1
FOR EACH ROW
BEGIN
    INSERT INTO Company2(no, name, operation)
    VALUES (OLD.no, OLD.name, 'update');
END$$

DELIMITER ;

-- Test the Trigger
SELECT * FROM Company1;
SELECT * FROM Company2;

UPDATE Company1 SET name='Vatsal Patel' WHERE no=1;
UPDATE Company1 SET name='Riya Patel' WHERE no=2;

SELECT * FROM Company1;
SELECT * FROM Company2;


-- Trigger to log DELETE operations

DELIMITER $$

CREATE TRIGGER log_delete_company1
AFTER DELETE ON Company1
FOR EACH ROW
BEGIN
    INSERT INTO Company2(no, name, operation)
    VALUES (OLD.no, OLD.name, 'delete');
END$$

DELIMITER ;

-- Test the Trigger
SELECT * FROM Company1;
SELECT * FROM Company2;

DELETE FROM Company1 WHERE no=3;

SELECT * FROM Company1;
SELECT * FROM Company2;

-- Task 6.
-- Table: Test1(No1, No2)
-- Table: Test2(Total)

CREATE TABLE Test1 (
    No1 INT,
    No2 INT
);
CREATE TABLE Test2 (
    Total INT
);

DESC Test1;
DESC Test2;

-- Trigger to insert sum of No1 and No2 into Test2 on INSERT in Test1

DELIMITER $$

CREATE TRIGGER calc_total_insert
AFTER INSERT ON Test1
FOR EACH ROW
BEGIN
    INSERT INTO Test2(total)
    VALUES (NEW.No1 + NEW.No2);
END$$

DELIMITER ;

-- Test the Trigger
INSERT INTO Test1 (No1, No2) VALUES (10, 20);
INSERT INTO Test1 (No1, No2) VALUES (30, 40);
SELECT * FROM Test1;
SELECT * FROM Test2;

-- Practical 8 Completed
NOTEE;