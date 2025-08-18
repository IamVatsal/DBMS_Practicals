CREATE DATABASE AccountDB_142;

USE AccountDB_142;

CREATE TABLE ACCOUNT_24012011142 (
    acc_no VARCHAR(5) PRIMARY KEY,
    Name VARCHAR(30),
    City VARCHAR(20),
    Balance DECIMAL(10, 2),
    loan_taken VARCHAR(5)
);

INSERT INTO ACCOUNT_24012011142 (acc_no, Name, City, Balance, loan_taken) VALUES
('A001', 'Patel Jigar', 'Mehsana', 50000, 'YES'),
('A002', 'Patel Ramesh', 'Mehsana', 50000, 'YES'),
('A003', 'Dave Hardik', 'Ahmedabad', 75000, 'NO'),
('A004', 'Soni Hetal', 'Ahmedabad', 100000, 'NO'),
('A005', 'Sony Atul', 'Vadodara', 100000, 'YES');


CREATE TABLE LOAN_24012011142 (
    loan_no VARCHAR(5) PRIMARY KEY,
    acc_no VARCHAR(5),
    loan_amt DECIMAL(10, 2),
    interest_rate DECIMAL(5, 2),
    loan_date DATE,
    remaining_loan DECIMAL(10, 2)
);

INSERT INTO LOAN_24012011142 (loan_no, acc_no, loan_amt, interest_rate, loan_date, remaining_loan) VALUES
('L001', 'A001', 100000, 7, '2004-01-01', 75000),
('L002', 'A002', 300000, 9, '2004-05-18', 150000),
('L003', 'A005', 500000, 11, '2004-06-15', 300000);

CREATE TABLE INSTALLMENT_24012011142 (
    loan_no VARCHAR(5),
    installment_no VARCHAR(5) PRIMARY KEY,
    installment_date DATE,
    Amount DECIMAL(10, 2)
);

INSERT INTO INSTALLMENT_24012011142 (loan_no, installment_no, installment_date, Amount) VALUES
('L001', 'I001', '2004-02-02', 15000),
('L002', 'I002', '2004-06-18', 20000),
('L003', 'I003', '2004-07-15', 20000);

-- 1.
SELECT * FROM INSTALLMENT_24012011142;
-- 2.
SELECT loan_no, installment_no, Amount FROM INSTALLMENT_24012011142;
-- 3.
SELECT acc_no, Name FROM ACCOUNT_24012011142 WHERE City = 'Ahmedabad';
-- 4.
SELECT * FROM LOAN_24012011142 WHERE loan_amt > 100000;
-- 5.
DESCRIBE ACCOUNT_24012011142;
DESCRIBE LOAN_24012011142;
DESCRIBE INSTALLMENT_24012011142;
-- 6.
UPDATE ACCOUNT_24012011142 SET Name = 'Patel Hiren' WHERE Name = 'Patel Jigar';
-- 7.
UPDATE ACCOUNT_24012011142 SET Name = 'Kothari Nehal' , City = 'Kherva' WHERE acc_no = 'A005';
-- 8.
SELECT * FROM ACCOUNT_24012011142 WHERE loan_taken = 'YES';
-- 9.
ALTER TABLE ACCOUNT_24012011142 ADD COLUMN address VARCHAR(20);
-- 10.
ALTER TABLE LOAN_24012011142 ADD COLUMN credit_no VARCHAR(4);
-- 11.
CREATE TABLE ACCOUNT_TEMP AS SELECT acc_no, Name, Balance FROM ACCOUNT_24012011142;
-- 12.
CREATE TABLE LOAN_TEMP AS SELECT loan_no, acc_no, loan_amt, loan_date FROM LOAN_24012011142;
-- 13.
CREATE TABLE TRANS_TEMP AS SELECT acc_no AS account_number FROM ACCOUNT_24012011142;
-- 14.
ALTER TABLE LOAN_24012011142 MODIFY acc_no VARCHAR(7);
-- 15.
DELETE FROM ACCOUNT_24012011142 WHERE acc_no = 'A004';
-- 16.
UPDATE LOAN_24012011142 SET interest_rate = interest_rate + 2;
-- 17.
SELECT * FROM LOAN_24012011142 WHERE MONTH(loan_date) = 1;
-- 18.
UPDATE INSTALLMENT_24012011142 SET installment_date = '2022-03-03' WHERE installment_date = '2021-02-02';
-- 19.
SELECT loan_no, acc_no, loan_amt, loan_amt * 2 AS double_loan_amt FROM LOAN_24012011142;
-- 20.
UPDATE LOAN_24012011142 SET loan_amt = 150000 WHERE loan_no = 'L001';
-- 21.
SELECT loan_no, Amount, installment_date FROM INSTALLMENT_24012011142 ORDER BY installment_date;
-- 22.
SELECT * FROM ACCOUNT_24012011142 ORDER BY acc_no DESC;
-- 23.
DROP TABLE LOAN_TEMP;