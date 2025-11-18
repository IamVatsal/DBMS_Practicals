-- PROMPT 24012011142_Vatsal [\d] \D \n>

-- Start Logging
-- tee C:\Users\Vatsal\Desktop\Sem3\DBMS\Practical-10\log.txt

-- Create Database
DROP DATABASE IF EXISTS practical_10_24012011142;
CREATE DATABASE practical_10_24012011142;
USE practical_10_24012011142;

-- Q1.
-- Create Table: Order_info(order_id INT, order_date DATE, order_amount INT)
CREATE TABLE Order_info (
    order_id INT PRIMARY KEY auto_increment,
    order_date DATE,
    order_amount INT
);

DESC Order_info;

-- Insert Sample Data
INSERT INTO Order_info (order_date, order_amount) VALUES
('2025-01-10', 4500),
('2025-01-11', 6000),
('2025-01-12', 3200);

SELECT * FROM Order_info;

SELECT * FROM Order_info WHERE order_amount = 6000;

-- Q2.
-- Create index idx_order on order_amount
CREATE INDEX idx_order ON Order_info(order_amount);

-- Q3.
CREATE TABLE order_seq(val INT NOT NULL);
INSERT INTO order_seq(val) VALUES (1);
UPDATE order_seq SET val = val + 3;

SELECT val FROM order_seq;


-- Q4.
UPDATE order_seq SET val = IF(val + 3 > 9999, 1, val + 3);

SELECT val FROM order_seq;


-- Q5.
SELECT val FROM order_seq;


-- Q6.
UPDATE order_seq SET val = val + 3;
SELECT val FROM order_seq;

-- Q7.
CREATE TABLE order1(
    onum INT, 
    odate DATE
);

UPDATE order_seq SET val = val + 3;

INSERT INTO order1(onum, odate) VALUES ((SELECT val FROM order_seq), CURDATE());

SELECT * FROM order1;

-- Q8.
DROP TABLE order_seq;

-- Q9.
DROP INDEX idx_order ON Order_info;



-- Q11.
CREATE VIEW vw_order AS
SELECT order_date, order_amount FROM Order_info;

SHOW CREATE VIEW vw_order;


-- Q12.
CREATE TABLE customer(
    cust_no INT PRIMARY KEY,
    cust_name VARCHAR(20),
    city VARCHAR(30)
);

INSERT INTO customer(cust_no, cust_name, city) VALUES
(1, 'Vatsal', 'Ahmedabad'),
(2, 'Riya', 'Surat'),
(3, 'Aryan', 'Vadodara');


CREATE VIEW vw_customer AS
SELECT cust_no, cust_name, city FROM customer;

SHOW CREATE VIEW vw_customer;
SELECT * FROM customer;


-- Q13.
-- No Error
INSERT INTO vw_order VALUES ('2025-01-13', 6000);

-- Error:
CREATE TABLE 24012011142_order(
    order_no INT NOT NULL PRIMARY KEY,
    order_date DATE,
    order_amount INT
);

INSERT INTO 24012011142_order(order_no, order_date, order_amount) VALUES
(101, '2025-01-10', 4500),
(102, '2025-01-11', 6000),
(103, '2025-01-12', 3200);

CREATE VIEW vw_24012011142_orders AS
SELECT order_date, order_amount FROM 24012011142_order;

INSERT INTO vw_24012011142_orders
VALUES ('2025-01-13', 7000);

-- Stop Logging
-- notee;