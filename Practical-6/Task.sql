-- PROMPT 24012011142_Vatsal [\d] \D \n>
-- tee C:\Users\Vatsal\Desktop\Sem3\DBMS\Practical-6\Log.txt


-- Task 1
-- a.
DELIMITER //

CREATE PROCEDURE calculate_if_else_142 (
    IN val1 DECIMAL(10, 2),
    IN val2 DECIMAL(10, 2),
    IN op CHAR(1)
)
procedure_calculate_if_else_142: BEGIN 

    DECLARE result DECIMAL(10, 2);
    -- 1. Apply a label to the entire procedure block

        IF op = '+' THEN
            SET result = val1 + val2;
        ELSEIF op = '-' THEN
            SET result = val1 - val2;
        ELSEIF op = '*' THEN
            SET result = val1 * val2;
        ELSEIF op = '/' THEN
            -- Check for division by zero
            IF val2 = 0 THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Division by zero is not allowed.';
                -- 2. Use LEAVE to exit the labeled block
                LEAVE procedure_calculate_if_else_142;
            END IF;
            SET result = val1 / val2;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid operator.';
            -- 3. Use LEAVE to exit the labeled block
            LEAVE procedure_calculate_if_else_142;
        END IF;

        -- This SELECT statement will only run if an early exit (LEAVE) was NOT triggered.
        SELECT CONCAT('Result: ', result) AS Calculation_Result;

END procedure_calculate_if_else_142;//

DELIMITER ;

-- Execute the IF-ELSE procedure
CALL calculate_if_else_142(10, 5, '+');
CALL calculate_if_else_142(10, 5, '*');

-- Test the early exit for Division by Zero (should signal error)
CALL calculate_if_else_142(10, 0, '/');

-- Test the early exit for Invalid Operator (should signal error)
CALL calculate_if_else_142(10, 5, '@');

-- b.
DELIMITER //

CREATE PROCEDURE calculate_case_142 (
    IN val1 DECIMAL(10, 2),
    IN val2 DECIMAL(10, 2),
    IN op CHAR(1)
)
procedure_calculate_if_else_142: BEGIN
    DECLARE result DECIMAL(10, 2);

    -- Check for division by zero before the CASE statement
    IF op = '/' AND val2 = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Division by zero is not allowed.';
        LEAVE procedure_calculate_if_else_142;
    END IF;

    CASE op
        WHEN '+' THEN
            SET result = val1 + val2;
        WHEN '-' THEN
            SET result = val1 - val2;
        WHEN '*' THEN
            SET result = val1 * val2;
        WHEN '/' THEN
            SET result = val1 / val2;
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid operator.';
            LEAVE procedure_calculate_if_else_142;
    END CASE;

    SELECT CONCAT('Result: ', result) AS Calculation_Result;

END procedure_calculate_if_else_142;//

DELIMITER ;

-- Execute the CASE procedure
CALL calculate_case_142(20, 4, '/');
CALL calculate_case_142(20, 4, '-');

-- Task 2
-- Table creation for employee_details
CREATE TABLE employee_details_142 (
    emp_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2)
);

INSERT INTO employee_details_142 (emp_no, name, salary) VALUES
(1001, 'Riya', 5000),
(1002, 'Rima', 10000),
(1003, 'Rekha', 12000),
(1004, 'Dhara', 6000);

SELECT * FROM employee_details_142;

-- Procedure to update Rekha's salary
DELIMITER //

CREATE PROCEDURE update_rekha_salary_142()
procedure_update_rekha_salary_142: BEGIN

    DECLARE riya_salary DECIMAL(10, 2);
    DECLARE rima_salary DECIMAL(10, 2);
    DECLARE amount_to_add DECIMAL(10, 2);

    -- 1. Get Riya's salary
    SELECT salary INTO riya_salary
    FROM employee_details_142
    WHERE name = 'Riya';

    -- 2. Get Rima's salary
    SELECT salary INTO rima_salary
    FROM employee_details_142
    WHERE name = 'Rima';

    -- 3. Calculate the total amount to add (50% of Riya + 70% of Rima)
    SET amount_to_add = (riya_salary * 0.50) + (rima_salary * 0.70);

    -- 4. Update Rekha's salary
    UPDATE employee_details_142
    SET salary = salary + amount_to_add
    WHERE name = 'Rekha';

    -- 5. Optional: Show the updated record
    SELECT *
    FROM employee_details_142
    WHERE name = 'Rekha';

END procedure_update_rekha_salary_142;//

DELIMITER ;

-- Execute the procedure
CALL update_rekha_salary_142();


-- Task 3
-- Table creation for emp_info
CREATE TABLE emp_info_142 (
    emp_no VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2)
);

INSERT INTO emp_info_142 (emp_no, name, balance) VALUES
('e001', 'John', 3000),
('e002', 'Joly', 4000),
('e003', 'Tony', 2000),
('e004', 'Doly', 500);

SELECT * FROM emp_info_142;

-- Procedure for debiting an account
DELIMITER //

CREATE PROCEDURE debit_account_142(
    IN p_emp_no VARCHAR(10),
    IN p_debit_amount DECIMAL(10, 2)
)
procedure_debit_account_142: BEGIN
    DECLARE current_balance DECIMAL(10, 2);
    DECLARE new_balance DECIMAL(10, 2);

    -- 1. Get current balance
    SELECT balance INTO current_balance
    FROM emp_info_142
    WHERE emp_no = p_emp_no;

    -- Check if the employee exists
    IF current_balance IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Employee number not found.';
        LEAVE procedure_debit_account_142;
    END IF;

    SET new_balance = current_balance - p_debit_amount;

    -- 2. Check the balance condition
    IF new_balance < 500.00 THEN
        -- Raise a user-defined error (PL/SQL EXCEPTION equivalent)
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Balance below 500/-';
    ELSE
        -- 3. Update the table
        UPDATE emp_info_142
        SET balance = new_balance
        WHERE emp_no = p_emp_no;
        
        SELECT CONCAT('Successfully debited ', p_debit_amount, '. New balance for ', p_emp_no, ' is ', new_balance) AS Status;
    END IF;

END procedure_debit_account_142;//

DELIMITER ;

-- Example 1: Successful Debit (John's balance: 3000 -> 2500)
CALL debit_account_142('e001', 500);

-- Example 2: Debit that results in balance below 500 (Doly's balance: 500)
-- This call will raise the custom error.
CALL debit_account_142('e004', 10);


-- Task 4
-- Table creation for old_salary
CREATE TABLE old_salary_142 (
    emp_no INT,
    previous_salary DECIMAL(10, 2),
    change_date DATE,
    PRIMARY KEY (emp_no, change_date)
);

-- procedure to log salary changes
DELIMITER //

CREATE PROCEDURE manage_emp_salary_update_142 (
    IN p_emp_no INT
)
procedure_manage_emp_salary_update_142: BEGIN
    DECLARE current_salary DECIMAL(10, 2);
    DECLARE new_salary DECIMAL(10, 2) DEFAULT 6000;

    -- 1. Get current salary
    SELECT salary INTO current_salary
    FROM employee_details_142
    WHERE emp_no = p_emp_no;

    -- 2. Check the condition (salary < 6000)
    IF current_salary < 6000.00 THEN
        -- 3. Record the old salary
        INSERT INTO old_salary_142 (emp_no, previous_salary, change_date)
        VALUES (p_emp_no, current_salary, CURDATE());

        -- 4. Update the employee_details table
        UPDATE employee_details_142
        SET salary = new_salary
        WHERE emp_no = p_emp_no;

        SELECT CONCAT('Salary updated for EMP_NO ', p_emp_no, ' from ', current_salary, ' to ', new_salary) AS Status;
    ELSE
        SELECT CONCAT('No salary change required for EMP_NO ', p_emp_no, '. Current salary is ', current_salary) AS Status;
    END IF;

END procedure_manage_emp_salary_update_142;//

DELIMITER ;

-- Test Case 1: Riya (1001) has 5000, so it will be updated to 6000
CALL manage_emp_salary_update_142(1001);

SELECT * FROM old_salary_142;

-- Task 5
-- Basic Loop to sum first n natural numbers
DELIMITER //

CREATE PROCEDURE sum_natural_loop_142 (
    IN n INT
)
procedure_sum_natural_loop_142: BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;

    main_loop: LOOP
        -- PL/SQL 'EXIT WHEN counter > n' is equivalent to this:
        IF counter > n THEN
            LEAVE main_loop;
        END IF;

        SET total_sum = total_sum + counter;
        SET counter = counter + 1;
        
    END LOOP main_loop;
    
    SELECT CONCAT('Sum of first ', n, ' numbers (Basic LOOP): ', total_sum) AS Result;
END procedure_sum_natural_loop_142; //

DELIMITER ;

-- Execute the Basic Loop procedure
CALL sum_natural_loop_142(5); -- Expected result: 15 (1+2+3+4+5)

-- With WHILE Loop to sum first n natural numbers
DELIMITER //

CREATE PROCEDURE sum_natural_while_142 (
    IN n INT
)
procedure_sum_natural_while_142: BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;

    WHILE counter <= n DO
        SET total_sum = total_sum + counter;
        SET counter = counter + 1;
    END WHILE;

    SELECT CONCAT('Sum of first ', n, ' numbers (WHILE LOOP): ', total_sum) AS Result;
END procedure_sum_natural_while_142;//

DELIMITER ;

-- Execute the WHILE Loop procedure
CALL sum_natural_while_142(5); -- Expected result: 15




-- Task 6
-- Factorial of a Number
-- Labeled LOOP
DELIMITER //

CREATE PROCEDURE factorial_loop_142 (
    IN p_number INT
)
procedure_factorial_loop_142: BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE factorial_result DECIMAL(30, 0) DEFAULT 1;

    IF p_number < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Factorial is not defined for negative numbers.';
        LEAVE procedure_factorial_loop_142;
    END IF;

    factorial_loop: LOOP
        IF i > p_number THEN
            LEAVE factorial_loop;
        END IF;

        SET factorial_result = factorial_result * i;
        SET i = i + 1;
    END LOOP factorial_loop;

    SELECT CONCAT('Factorial of ', p_number, ' is: ', factorial_result) AS Result;
END procedure_factorial_loop_142;//

DELIMITER ;

-- Execute the loop procedure
CALL factorial_loop_142(5); -- Expected result: 120


-- REPEAT Loop
DELIMITER //

CREATE PROCEDURE factorial_repeat_142 (
    IN p_number INT
)
procedure_factorial_repeat_142: BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE factorial_result DECIMAL(30, 0) DEFAULT 1;

    IF p_number < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Factorial is not defined for negative numbers.';
        LEAVE procedure_factorial_repeat_142;
    END IF;

    REPEAT
        SET factorial_result = factorial_result * i;
        SET i = i + 1;
    UNTIL i > p_number END REPEAT;

    SELECT CONCAT('Factorial of ', p_number, ' is: ', factorial_result) AS Result;
END procedure_factorial_repeat_142;//

DELIMITER ;

CALL factorial_repeat_142(6); -- Expected result: 720
