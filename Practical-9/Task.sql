-- PROMPT 24012011142_Vatsal [\d] \D \n>

-- Start Logging
-- tee C:\Users\Vatsal\Desktop\Sem3\DBMS\Practical-9\log.txt

-- Create Database
DROP DATABASE IF EXISTS practical_9_24012011142;
CREATE DATABASE practical_9_24012011142;
USE practical_9_24012011142;

-- Task 1
-- Table: STUDENT(sr_no INT, name VARCHAR(50), address VARCHAR(100))
CREATE TABLE STUDENT (
    sr_no VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

DESC STUDENT;

-- Insert Sample Data
INSERT INTO STUDENT (sr_no, name, address) VALUES
('10IT49', 'Vatsal', 'Gujarat'),
('10IT50', 'Riya', 'Gujarat'),
('10IT51', 'Aryan', 'Gujarat');

SELECT * FROM STUDENT;


-- Procedure to get student details by sr_no
DELIMITER $$

CREATE PROCEDURE get_student()
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_address VARCHAR(200);
    DECLARE not_found INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND 
        SET not_found = 1;

    SELECT name, address INTO v_name, v_address
    FROM student
    WHERE sr_no = '10IT48';

    IF not_found = 1 THEN
        SELECT 'data not found' AS message;
    ELSE
        SELECT v_name AS name, v_address AS address;
    END IF;

END$$

DELIMITER ;

-- Call the procedure to test
CALL get_student();



-- Task 2
-- Same Table: STUDENT(sr_no INT, name VARCHAR(50), address VARCHAR(100))

DELIMITER $$

CREATE PROCEDURE example_too_many_rows()
BEGIN
    DECLARE msg VARCHAR(100);

    DECLARE CONTINUE HANDLER FOR 1172     -- MySQL error: Subquery returns more than 1 row
        SET msg = 'TOO MANY ROWS ERROR OCCURRED';

    -- This SELECT must return exactly 1 row, otherwise error 1172
    SELECT name INTO msg
    FROM STUDENT
    WHERE address = 'Gujarat';   -- assume many students from Gujarat

    SELECT msg AS result;

END$$

DELIMITER ;

-- Call the procedure to test
CALL example_too_many_rows();


-- Task 3
-- Table: emp_mas(emp_no INT PRIMARY KEY, name VARCHAR(50))
CREATE TABLE emp_mas (
    emp_no INT,
    name VARCHAR(50),
    PRIMARY KEY (emp_no)
);

DESC emp_mas;

INSERT INTO emp_mas (emp_no, name) VALUES
(101, 'Vatsal'),
(102, 'Riya');

SELECT * FROM emp_mas;

-- Trigger to PRIMARY KEY VIOLATION

DELIMITER $$

CREATE PROCEDURE primary_key_violation()
BEGIN
    DECLARE msg VARCHAR(100) DEFAULT '';

    -- Handle Duplicate key exception
    DECLARE CONTINUE HANDLER FOR 1062 
        SET msg = 'PRIMARY KEY VIOLATION - DUPLICATE EMP_NO';

    -- Insert again → will cause error 1062
    INSERT INTO emp_mas(emp_no, name)
    VALUES (101, 'Aryan');

    SELECT msg AS message;
END$$

DELIMITER ;


-- Call the procedure to test
CALL primary_key_violation();


-- Task 4
-- Table: Same as Task 1

DELIMITER $$

CREATE PROCEDURE insert_student(
    IN p_sr_no INT,
    IN p_name VARCHAR(100),
    IN p_address VARCHAR(200)
)
BEGIN
    -- User-defined exception: sr_no must be >= 0
    IF p_sr_no < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'INVALID SR_NO: MUST BE >= 0';
    END IF;

    -- Insert when valid
    INSERT INTO student(sr_no, name, address)
    VALUES(p_sr_no, p_name, p_address);

END$$

DELIMITER ;

-- Call the procedure to test
SELECT * FROM STUDENT;
CALL insert_student(-5, 'Vatsal', 'Ahmedabad');
CALL insert_student(22, 'Kush', 'Ahmedabad');
SELECT * FROM STUDENT;

-- Stop Logging
NOTEE;

-- Practical-9 Completed