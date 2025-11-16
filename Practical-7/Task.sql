-- PROMPT 24012011142_Vatsal [\d] \D \n>

-- Start Logging
-- tee C:\Users\Vatsal\Desktop\Sem3\DBMS\Practical-7\log.txt

-- Create Database
DROP DATABASE IF EXISTS practical_7_24012011142;
CREATE DATABASE practical_7_24012011142;
USE practical_7_24012011142;

-- Task 1
-- Table: Grade(name, salary)
CREATE TABLE Grade (
    name VARCHAR(255),
    salary INT
);
DESC Grade;

INSERT INTO Grade (name, salary) VALUES
('Rima', 10000);

SELECT * FROM Grade;

-- A
START TRANSACTION;
INSERT INTO Grade (name, salary) VALUES ('abc', 6000);
UPDATE Grade SET salary = 4000 WHERE name = 'Rima';
ROLLBACK;
COMMIT;

SELECT * FROM Grade;
-- B
START TRANSACTION;
INSERT INTO Grade (name, salary) VALUES ('abc', 6000);
UPDATE Grade SET salary = 4000 WHERE name = 'Rima';
COMMIT;
ROLLBACK;

SELECT * FROM Grade;
-- C
START TRANSACTION;
INSERT INTO Grade (name, salary) VALUES ('xyz', 7000);
SAVEPOINT first;
UPDATE Grade SET salary = 50000 WHERE name = 'xyz';
ROLLBACK TO first;
COMMIT;

SELECT * FROM Grade;


-- Task 2
-- Table: 

CREATE TABLE Employee_Details (
    name VARCHAR(255),
    salary INT
);

DESC Employee_Details;

INSERT INTO Employee_Details (name, salary) VALUES
('Riya', 1000),
('Rima', 2000);

SELECT * FROM Employee_Details;

DELIMITER $$

CREATE PROCEDURE addNewEmployee_And_UpdateSalaries(IN newName VARCHAR(255), IN newSalary INT)
BEGIN
    DECLARE totalSal INT;

    START TRANSACTION;

    -- Insert new record
    INSERT INTO Employee_Details(name, salary)
    VALUES (newName, newSalary);

    -- Update Riya & Rima
    UPDATE Employee_Details
    SET salary = salary + 7000
    WHERE name IN ('Riya', 'Rima');

    -- Check total salary
    SELECT SUM(salary) INTO totalSal FROM Employee_Details;

    IF totalSal > 20000 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'TOTAL SALARY EXCEEDED 20000';
    ELSE
        COMMIT;
    END IF;
END $$

DELIMITER ;

-- Test the procedure
CALL addNewEmployee_And_UpdateSalaries('Vatsal', 2000);


-- Task 3.
-- Use Same Table: Employee_Details

DELIMITER $$

CREATE PROCEDURE give_salary_raise()
BEGIN
    START TRANSACTION;
    UPDATE Employee_Details
    SET salary = salary * 1.05;
    COMMIT;
END $$

DELIMITER ;

-- Test the procedure
-- Check salaries before raise
SELECT * FROM Employee_Details;

-- Give salary raise
CALL give_salary_raise();

-- Check salaries after raise
SELECT * FROM Employee_Details;


-- Task 4.
-- Table 1: Empmaster(No, Name, City)

CREATE TABLE Empmaster (
    No INT,
    Name VARCHAR(255),
    City VARCHAR(255)
);

DESC Empmaster;

INSERT INTO Empmaster (No, Name, City) VALUES
(10, 'Riya', 'Bombay'),
(20, 'Rima', 'Delhi'),
(30, 'Rekha', 'Bombay'),
(40, 'Dhara', 'Ahmedabad'),
(50, 'Dhaval', 'Jaipur');

SELECT * FROM Empmaster;

-- Table 2: CITYLIST(No, Name)
CREATE TABLE CITYLIST (
    No INT,
    Name VARCHAR(255)
);

DESC CITYLIST;

SELECT * FROM CITYLIST;


DELIMITER $$

CREATE PROCEDURE move_bombay_employees()
BEGIN
    INSERT INTO CITYLIST(No, Name)
    SELECT No, Name
    FROM Empmaster
    WHERE City='Bombay';
END $$

DELIMITER ;

-- Test the procedure

-- Check CITYLIST before moving
SELECT * FROM CITYLIST;
-- Move Bombay employees to CITYLIST
CALL move_bombay_employees();
-- Check CITYLIST after moving
SELECT * FROM CITYLIST;

-- Task 5.
-- Table: Temp(No, Company, Salary)
CREATE TABLE Temp (
    No INT,
    Company VARCHAR(255),
    Salary DECIMAL(10, 2)
);

DESC Temp;

INSERT INTO Temp (No, Company, Salary) VALUES
(1, 'IBM', 5000000),
(2, 'GOOGLE', 7000000),
(3, 'MICROSOFT', 6000000);

SELECT * FROM Temp;

DELIMITER $$

CREATE PROCEDURE updateCompanySalary(IN companyName VARCHAR(50))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_no INT;
    DECLARE v_salary INT;

    DECLARE cur CURSOR FOR
        SELECT no, salary FROM Temp WHERE company = companyName;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_no, v_salary;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        UPDATE Temp
        SET salary = salary + 100000
        WHERE no = v_no;
    END LOOP;

    CLOSE cur;
END $$

DELIMITER ;

-- Test the procedure
-- Check Temp before update
SELECT * FROM Temp;
-- Update salaries for GOOGLE
CALL updateCompanySalary('GOOGLE');
-- Check Temp after update
SELECT * FROM Temp;


-- Task 6.
-- Use Same Table: Empmaster(No, Name, City)

-- Option 1: Using Simple LIMIT
SELECT no, name
FROM Empmaster
LIMIT 3;

-- Option 2: Using Cursor in Stored Procedure
DELIMITER $$

CREATE PROCEDURE show_3()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_no INT;
    DECLARE v_name VARCHAR(255);

    DECLARE cur CURSOR FOR SELECT no, name FROM Empmaster LIMIT 3;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_no, v_name;
        IF done = 1 THEN LEAVE read_loop; END IF;

        SELECT v_no AS No, v_name AS Name;
    END LOOP;

    CLOSE cur;
END $$

DELIMITER ;

-- Test the procedure
CALL show_3();


-- Task 7.
-- Table: EMPLOYEES(EmpNo, Name, Salary, Designation, DeptID)

CREATE TABLE EMPLOYEES (
    EmpNo INT,
    Name VARCHAR(255),
    Salary DECIMAL(10, 2),
    Designation VARCHAR(255),
    DeptID INT
);

DESC EMPLOYEES;

INSERT INTO EMPLOYEES (EmpNo, Name, Salary, Designation, DeptID) VALUES
(1, 'Amit', 60000, 'Manager', 101),
(2, 'Suman', 50000, 'Developer', 102),
(3, 'Rakesh', 55000, 'Analyst', 101),
(4, 'Neha', 45000, 'Developer', 103),
(5, 'Vikram', 70000, 'Manager', 102),
(6, 'Pooja', 48000, 'Analyst', 103),
(7, 'Rahul', 52000, 'Developer', 101),
(8, 'Anita', 62000, 'Manager', 103),
(9, 'Suresh', 47000, 'Analyst', 102);

SELECT * FROM EMPLOYEES;

-- Option 1: Using Simple Aggregate Query
SELECT * FROM EMPLOYEES
ORDER BY Salary DESC
LIMIT 5;

-- Option 2: Using Cursor in Stored Procedure
DELIMITER $$

CREATE PROCEDURE top5()
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE v_no INT;
    DECLARE v_name VARCHAR(50);
    DECLARE v_salary INT;

    DECLARE cur CURSOR FOR
        SELECT EmpNo, Name, Salary
        FROM EMPLOYEES
        ORDER BY Salary DESC
        LIMIT 5;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_no, v_name, v_salary;
        IF finished = 1 THEN LEAVE read_loop; END IF;

        SELECT v_no AS EmpNo, v_name AS Name, v_salary AS Salary;
    END LOOP;

    CLOSE cur;
END $$

DELIMITER ;

-- Test the procedure
CALL top5();

-- END OF TASKS
-- End Logging
NOTEE;