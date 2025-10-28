
Customize

-- ============================================================
-- DATABASE MANAGEMENT SYSTEM - PRACTICAL 5
-- PREREQUISITE STEPS & COMPLETE SOLUTION
-- WITH BEFORE/AFTER VERIFICATIONS
-- ============================================================

-- ============================================================
-- STEP 1: TEE COMMAND (Save session to file)
-- ============================================================
-- Replace 'YourEnrollment' and 'YourName' with actual values
TEE C:\practical5_YourEnrollment_YourName.txt

-- ============================================================
-- STEP 2: SET CUSTOM PROMPT
-- ============================================================
-- Replace with your actual enrollment number and first name
PROMPT YourEnrollment_YourName [\d] \D \n> 

-- ============================================================
-- STEP 3: CREATE DATABASE
-- ============================================================
-- Replace 'YourEnrollment' with your actual enrollment number
DROP DATABASE IF EXISTS PRACTICAL_5_YourEnrollment;
CREATE DATABASE PRACTICAL_5_YourEnrollment;

-- ============================================================
-- STEP 4: USE DATABASE
-- ============================================================
USE PRACTICAL_5_YourEnrollment;

-- ============================================================
-- TABLE CREATION
-- ============================================================

-- Create salesmen table
CREATE TABLE salesmen (
    snum VARCHAR(6) PRIMARY KEY CHECK (snum LIKE 's%'),
    sname VARCHAR(20) NOT NULL,
    city VARCHAR(15),
    comm DECIMAL(5,2)
);

-- DESCRIBE after CREATE
DESC salesmen;

-- Create customer table
CREATE TABLE customer (
    cnum VARCHAR(6) PRIMARY KEY CHECK (cnum LIKE 'c%'),
    cname VARCHAR(20) NOT NULL,
    city VARCHAR(15),
    rating INT,
    snum VARCHAR(6)
);

-- DESCRIBE after CREATE
DESC customer;

-- Create order_info table
CREATE TABLE order_info (
    onum VARCHAR(6) PRIMARY KEY CHECK (onum LIKE 'o%'),
    amt DECIMAL(10,2) NOT NULL,
    odate DATE,
    cnum VARCHAR(6),
    snum VARCHAR(6)
);

-- DESCRIBE after CREATE
DESC order_info;

-- ============================================================
-- DATA INSERTION
-- ============================================================

-- BEFORE INSERT - Show empty salesmen table
SELECT '=== BEFORE INSERT - SALESMEN TABLE ===' AS Status;
SELECT * FROM salesmen;

-- Insert into salesmen
INSERT INTO salesmen VALUES ('s1001', 'Piyush', 'London', 0.12);
INSERT INTO salesmen VALUES ('s1002', 'Niraj', 'san jose', 0.13);
INSERT INTO salesmen VALUES ('s1003', 'Miti', 'London', 0.11);
INSERT INTO salesmen VALUES ('s1004', 'Rajesh', 'Barcelona', 0.15);
INSERT INTO salesmen VALUES ('s1005', 'Haresh', 'new York', 0.10);
INSERT INTO salesmen VALUES ('s1006', 'Ram', 'Bombay', 0.10);
INSERT INTO salesmen VALUES ('s1007', 'Nehal', 'Delhi', 0.09);

-- AFTER INSERT - Show salesmen table with data
SELECT '=== AFTER INSERT - SALESMEN TABLE ===' AS Status;
SELECT * FROM salesmen;

-- BEFORE INSERT - Show empty customer table
SELECT '=== BEFORE INSERT - CUSTOMER TABLE ===' AS Status;
SELECT * FROM customer;

-- Insert into customer
INSERT INTO customer VALUES ('c2001', 'hardik', 'london', 100, 's1001');
INSERT INTO customer VALUES ('c2002', 'geeta', 'rome', 200, 's1003');
INSERT INTO customer VALUES ('c2003', 'kavish', 'san jose', 200, 's1002');
INSERT INTO customer VALUES ('c2004', 'dhruv', 'berlin', 300, 's1002');
INSERT INTO customer VALUES ('c2005', 'pratham', 'london', 100, 's1001');
INSERT INTO customer VALUES ('c2006', 'vyomesh', 'san jose', 300, 's1007');
INSERT INTO customer VALUES ('c2007', 'kirit', 'rome', 100, 's1004');
INSERT INTO customer VALUES ('c2008', 'agam', NULL, 200, 's1003');
INSERT INTO customer VALUES ('c2009', 'falgun', 'san jose', NULL, 's1001');

-- AFTER INSERT - Show customer table with data
SELECT '=== AFTER INSERT - CUSTOMER TABLE ===' AS Status;
SELECT * FROM customer;

-- BEFORE INSERT - Show empty order_info table
SELECT '=== BEFORE INSERT - ORDER_INFO TABLE ===' AS Status;
SELECT * FROM order_info;

-- Insert into order_info
INSERT INTO order_info VALUES ('o3001', 18.69, '2020-03-10', 'c2008', 's1007');
INSERT INTO order_info VALUES ('o3003', 767.19, '2020-03-10', 'c2001', 's1001');
INSERT INTO order_info VALUES ('o3002', 1900.10, '2021-10-03', 'c2007', 's1004');
INSERT INTO order_info VALUES ('o3005', 5160.45, '2021-10-04', 'c2003', 's1002');
INSERT INTO order_info VALUES ('o3006', 1098.16, '2020-03-10', 'c2008', 's1007');
INSERT INTO order_info VALUES ('o3009', 1713.23, '2020-04-10', 'c2002', 's1003');
INSERT INTO order_info VALUES ('o3007', 75.75, '2020-04-10', 'c2004', 's1002');
INSERT INTO order_info VALUES ('o3008', 4723.00, '2021-05-10', 'c2006', 's1001');
INSERT INTO order_info VALUES ('o3010', 1309.95, '2021-05-10', 'c2004', 's1002');
INSERT INTO order_info VALUES ('o3011', 9891.88, '2021-06-10', 'c2006', 's1001');
-- Additional Inserts to address queries with no results and zero/null values
INSERT INTO order_info VALUES ('o3012', 0, '2020-10-03', 'c2005', 's1001'); -- Zero amount
INSERT INTO order_info VALUES ('o3013', 0, '2020-10-04', 'c2009', 's1001'); -- NULL amount

-- AFTER INSERT - Show order_info table with data
SELECT '=== AFTER INSERT - ORDER_INFO TABLE ===' AS Status;
SELECT * FROM order_info;

-- ============================================================
-- QUERIES SECTION
-- ============================================================

-- Query 1: Display commission values without repetition
SELECT '=== QUERY 1: Distinct Commission Values ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM salesmen;
-- Actual Query
SELECT DISTINCT comm FROM salesmen;

-- Query 2: Salesmen in BARCELONA or LONDON (use IN)
SELECT '=== QUERY 2: Salesmen in Barcelona or London ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM salesmen;
-- Actual Query
SELECT * FROM salesmen WHERE city IN ('Barcelona', 'London');

-- Query 3: Salesmen with commission between 0.10 and 0.12
SELECT '=== QUERY 3: Salesmen with commission between 0.10 and 0.12 ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM salesmen;
-- Actual Query
SELECT * FROM salesmen WHERE comm BETWEEN 0.10 AND 0.12;

-- Query 4: Customers whose name's third letter is 'R'
SELECT '=== QUERY 4: Customers with third letter R in name ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM customer;
-- Actual Query
SELECT * FROM customer WHERE cname LIKE '__r%';

-- Query 5: Salesmen whose name starts with 'P' and ends with 'h'
SELECT '=== QUERY 5: Salesmen name starting with P and ending with h ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM salesmen;
-- Actual Query
SELECT * FROM salesmen WHERE sname LIKE 'P%h';

-- Query 6: Customers with NULL city values
SELECT '=== QUERY 6: Customers with NULL city ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM customer;
-- Actual Query
SELECT * FROM customer WHERE city IS NULL;

-- Query 7a: Orders on Oct 3rd or 4th 2020 using BETWEEN **Requires attention** Returns Empty set Solved by adding Orders with these dates
SELECT '=== QUERY 7a: Orders on Oct 3-4, 2020 (BETWEEN) ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT * FROM order_info 
WHERE odate BETWEEN '2020-10-03' AND '2020-10-04';

-- Query 7b: Orders on Oct 3rd or 4th 2020 using OR **Requires attention** Returns Empty set Solved by adding Orders with these dates
SELECT '=== QUERY 7b: Orders on Oct 3-4, 2020 (OR) ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT * FROM order_info 
WHERE odate = '2020-10-03' OR odate = '2020-10-04';

-- Query 8: Orders without ZEROS or NULLS in amount  **Requires attention** Returns All rows Solved by adding Insertion of 0 amount orders
SELECT '=== QUERY 8: Orders without zeros or nulls in amount ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT * FROM order_info WHERE amt IS NOT NULL AND amt != 0;

-- Query 9: Count salesmen without duplication from order_info
SELECT '=== QUERY 9: Count of distinct salesmen in orders ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT COUNT(DISTINCT snum) AS salesmen_count FROM order_info;

-- Query 10: Count rating with NULL and without NULL
SELECT '=== QUERY 10: Count of ratings (with and without NULL) ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM customer;
-- Actual Query
SELECT 
    COUNT(rating) AS rating_count_without_null,
    COUNT(*) AS rating_count_with_null
FROM customer;

-- Query 11: Largest order by each salesperson
SELECT '=== QUERY 11: Largest order by each salesperson ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT snum, MAX(amt) AS largest_order 
FROM order_info 
GROUP BY snum;

-- Query 12: Largest order by each salesperson on each date
SELECT '=== QUERY 12: Largest order by salesperson on each date ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT snum, odate, MAX(amt) AS largest_order 
FROM order_info 
GROUP BY snum, odate;

-- Query 13: Total amount by customer (only > 800)
SELECT '=== QUERY 13: Total amount by customer (>800) ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT cnum, SUM(amt) AS total_amount 
FROM order_info 
GROUP BY cnum 
HAVING SUM(amt) > 800;

-- Query 14: Count different non-NULL cities
SELECT '=== QUERY 14: Count of distinct non-NULL cities ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM customer;
-- Actual Query
SELECT COUNT(DISTINCT city) AS city_count FROM customer;

-- Query 15: Sname and commission in descending order of snum
SELECT '=== QUERY 15: Salesmen by snum descending ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM salesmen;
-- Actual Query
SELECT sname, comm FROM salesmen ORDER BY snum DESC;

-- Query 16: Order details with 12% commission
SELECT '=== QUERY 16: Order with salesperson commission (12%) ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT onum, snum, amt * 0.12 AS commission 
FROM order_info;

-- Query 17: Highest rating in each city
SELECT '=== QUERY 17: Highest rating by city ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM customer;
-- Actual Query
SELECT CONCAT('For the city ', city, ', the highest rating is: ', MAX(rating)) AS result
FROM customer 
WHERE city IS NOT NULL
GROUP BY city;

-- Query 18: Total orders by date in descending order
SELECT '=== QUERY 18: Total orders by date (descending) ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM order_info;
-- Actual Query
SELECT odate, SUM(amt) AS total_amount 
FROM order_info 
GROUP BY odate 
ORDER BY total_amount DESC;

-- Query 19: Customer names with their salesmen
SELECT '=== QUERY 19: Customers matched with salesmen ===' AS Query_Description;
-- SELECT from tables before query
SELECT * FROM customer;
SELECT * FROM salesmen;
-- Actual Query
SELECT c.cname, s.sname 
FROM customer c 
INNER JOIN salesmen s ON c.snum = s.snum;

-- Query 20: Order number with customer name
SELECT '=== QUERY 20: Order number with customer name ===' AS Query_Description;
-- SELECT from tables before query
SELECT * FROM order_info;
SELECT * FROM customer;
-- Actual Query
SELECT o.onum, c.cname 
FROM order_info o 
INNER JOIN customer c ON o.cnum = c.cnum;

-- Query 21: Order with salesperson and customer names
SELECT '=== QUERY 21: Order with salesperson and customer names ===' AS Query_Description;
-- SELECT from tables before query
SELECT * FROM order_info;
SELECT * FROM customer;
SELECT * FROM salesmen;
-- Actual Query
SELECT o.onum, s.sname AS salesperson_name, c.cname AS customer_name
FROM order_info o 
INNER JOIN customer c ON o.cnum = c.cnum
INNER JOIN salesmen s ON o.snum = s.snum;

-- Query 22: Customers serviced by salesmen with commission > 0.12
SELECT '=== QUERY 22: Customers with salesmen commission > 0.12 ===' AS Query_Description;
-- SELECT from tables before query
SELECT * FROM customer;
SELECT * FROM salesmen;
-- Actual Query
SELECT c.cname, s.sname, s.comm 
FROM customer c 
INNER JOIN salesmen s ON c.snum = s.snum 
WHERE s.comm > 0.12;

-- Query 23: Commission on orders for customers with rating > 100
SELECT '=== QUERY 23: Commission on orders (customer rating > 100) ===' AS Query_Description;
-- SELECT from tables before query
SELECT * FROM order_info;
SELECT * FROM customer;
SELECT * FROM salesmen;
-- Actual Query
SELECT o.onum, o.amt, s.comm, (o.amt * s.comm) AS commission_amount
FROM order_info o 
INNER JOIN customer c ON o.cnum = c.cnum
INNER JOIN salesmen s ON o.snum = s.snum
WHERE c.rating > 100;

-- Query 24: UNION of customers with HIGH/LOW rating
SELECT '=== QUERY 24: Customers with rating classification ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM customer;
-- Actual Query
SELECT cname, city, rating, 'HIGH RATING' AS rating_category
FROM customer 
WHERE rating >= 200
UNION
SELECT cname, city, rating, 'LOW RATING' AS rating_category
FROM customer 
WHERE rating < 200;

-- Query 25: Customers who made orders on 10th March 2020
SELECT '=== QUERY 25: Customers with orders on 10-Mar-2020 ===' AS Query_Description;
-- SELECT from tables before query
SELECT * FROM customer;
SELECT * FROM order_info;
-- Actual Query
SELECT * FROM customer 
WHERE cnum IN (
    SELECT cnum FROM order_info WHERE odate = '2020-03-10'
);

-- Query 26: Customers with rating greater than any customer in ROME **Requires attention** WHY MIN()?
SELECT '=== QUERY 26: Customers with rating > any customer in Rome ===' AS Query_Description;
-- SELECT from table before query
SELECT * FROM customer;
-- Actual Query
SELECT * FROM customer 
WHERE rating > (
    SELECT MIN(rating) FROM customer WHERE city = 'rome'
);

-- Query 27: Create London_staff with same structure as salesmen
SELECT '=== QUERY 27: Creating London_staff table ===' AS Query_Description;

-- BEFORE ALTER - Show salesmen structure
DESC salesmen;

-- Create London_staff table **Requires attention** No City default value?
CREATE TABLE London_staff (
    snum VARCHAR(6) PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    city VARCHAR(15) DEFAULT 'London', -- Add Default value for city
    comm DECIMAL(5,2)
);

-- AFTER CREATE - Show London_staff structure
DESC London_staff;

-- Query 28: Delete salesmen with at least one customer rating 100
SELECT '=== QUERY 28: Deleting salesmen with customers rating 100 ===' AS Query_Description;

-- BEFORE DELETE - Show salesmen table
SELECT * FROM salesmen;

-- Delete query
DELETE FROM salesmen 
WHERE snum IN (
    SELECT DISTINCT snum FROM customer WHERE rating = 100
);

-- AFTER DELETE - Show salesmen table
SELECT * FROM salesmen;

-- ============================================================
-- ADDITIONAL UPDATE EXAMPLE (Bonus Demonstration)
-- ============================================================

SELECT '=== BONUS: UPDATE OPERATION DEMONSTRATION ===' AS Operation;

-- BEFORE UPDATE - Show customer table
SELECT * FROM customer;

-- Example UPDATE: Change rating of customer c2009
UPDATE customer 
SET rating = 150 
WHERE cnum = 'c2009';

-- AFTER UPDATE - Show customer table
SELECT * FROM customer;

-- ============================================================
-- ADDITIONAL ALTER EXAMPLES (Bonus Demonstration)
-- ============================================================

SELECT '=== BONUS: ALTER OPERATIONS DEMONSTRATION ===' AS Operation;

-- BEFORE ALTER - Show London_staff structure
DESC London_staff;

-- ALTER: Add a new column
ALTER TABLE London_staff ADD phone VARCHAR(15);

-- AFTER ALTER - Show London_staff structure
DESC London_staff;

-- BEFORE ALTER - Show London_staff structure
DESC London_staff;

-- ALTER: Modify column
ALTER TABLE London_staff MODIFY phone VARCHAR(20);

-- AFTER ALTER - Show London_staff structure
DESC London_staff;

-- BEFORE ALTER - Show London_staff structure
DESC London_staff;

-- ALTER: Drop column
ALTER TABLE London_staff DROP COLUMN phone;

-- AFTER ALTER - Show London_staff structure
DESC London_staff;

-- ============================================================
-- END OF PRACTICAL
-- ============================================================

-- Stop logging
NOTEE;
