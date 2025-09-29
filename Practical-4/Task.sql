-- PROMPT 24012011142_Vatsal [\d] \D \n>
-- tee c:/Users/Lenovo/Desktop/DBMS/DBMS_Practicals/Practical-1/Task.txt

CREATE DATABASE Practical_4_24012011142;

USE Practical_4_24012011142;

CREATE TABLE ACCOUNT_24012011142 (
    acc_no VARCHAR(5) PRIMARY KEY,
    Name VARCHAR(30),
    City VARCHAR(20),
    Balance DECIMAL(10, 2),
    loan_taken VARCHAR(5)
);

DESC ACCOUNT_24012011142;

INSERT INTO ACCOUNT_24012011142 (acc_no, Name, City, Balance, loan_taken) VALUES
('A001', 'Patel Jigar', 'Mehsana', 50000, 'YES'),
('A002', 'Patel Ramesh', 'Mehsana', 50000, 'YES'),
('A003', 'Dave Hardik', 'Ahmedabad', 75000, 'NO'),
('A004', 'Soni Hetal', 'Ahmedabad', 100000, 'NO'),
('A005', 'Sony Atul', 'Vadodara', 100000, 'YES');

SELECT * FROM ACCOUNT_24012011142;

CREATE TABLE LOAN_24012011142 (
    loan_no VARCHAR(5) PRIMARY KEY,
    acc_no VARCHAR(5),
    loan_amt DECIMAL(10, 2),
    interest_rate DECIMAL(5, 2),
    loan_date DATE,
    remaining_loan DECIMAL(10, 2)
);

DESC LOAN_24012011142;

INSERT INTO LOAN_24012011142 (loan_no, acc_no, loan_amt, interest_rate, loan_date, remaining_loan) VALUES
('L001', 'A001', 100000, 7, '2004-01-01', 75000),
('L002', 'A002', 300000, 9, '2004-05-18', 150000),
('L003', 'A005', 500000, 11, '2004-06-15', 300000);

SELECT * FROM LOAN_24012011142;

CREATE TABLE INSTALLMENT_24012011142 (
    loan_no VARCHAR(5),
    installment_no VARCHAR(5) PRIMARY KEY,
    installment_date DATE,
    Amount DECIMAL(10, 2)
);

DESC INSTALLMENT_24012011142;

INSERT INTO INSTALLMENT_24012011142 (loan_no, installment_no, installment_date, Amount) VALUES
('L001', 'I001', '2004-02-02', 15000),
('L002', 'I002', '2004-06-18', 20000),
('L003', 'I003', '2004-07-15', 20000);

CREATE TABLE TRANSACTION_24012011142 (
    Acc_no VARCHAR(5),
    Tr_date DATE,
    Amt DECIMAL(10, 2),
    Type_of_tr CHAR(1),
    Mode_of_pay VARCHAR(30)
);

INSERT INTO TRANSACTION_24012011142 (Acc_no, Tr_date, Amt, Type_of_tr, Mode_of_pay) VALUES 
('A001', '2021-05-01', 10000.00, 'D', 'Cash'),
('A002', '2021-07-02', 5000.00, 'W', 'Cheque'),
('A003', '2021-08-03', 25000.00, 'D', 'Cheque'),
('A004', '2021-05-04', 30000.00, 'D', 'Cheque'),
('A005', '2021-10-05', 15000.00, 'W', 'Cash');


-- 1.
SELECT City, SUM(Balance) AS total_balance
FROM ACCOUNT_24012011142
GROUP BY City;

-- 2.
SELECT City, COUNT(*) AS total_accounts
FROM ACCOUNT_24012011142
GROUP BY City
ORDER BY total_accounts ASC;

-- 3.
SELECT loan_taken, SUM(Balance) AS total_balance
FROM ACCOUNT_24012011142
GROUP BY loan_taken
HAVING loan_taken = 'NO';

-- 4.
SELECT a.*
FROM ACCOUNT_24012011142 a
JOIN LOAN_24012011142 l ON a.acc_no = l.acc_no
WHERE a.Balance = l.loan_amt;

-- 5.
SELECT l.acc_no, i.installment_no, l.loan_amt, i.installment_date
FROM LOAN_24012011142 l
JOIN INSTALLMENT_24012011142 i ON l.loan_no = i.loan_no
WHERE l.loan_no = 'L001';

-- 6.
SELECT a.acc_no, a.City, l.remaining_loan, l.loan_date, l.loan_no
FROM ACCOUNT_24012011142 a
LEFT JOIN LOAN_24012011142 l ON a.acc_no = l.acc_no;

-- 7.
SELECT l.loan_no, l.interest_rate, t.Tr_date, t.Type_of_tr
FROM LOAN_24012011142 l
RIGHT JOIN TRANSACTION_24012011142 t ON l.acc_no = t.Acc_no;

-- 8.
SELECT t.Amt, a.Name, a.acc_no, t.Mode_of_pay
FROM TRANSACTION_24012011142 t
JOIN ACCOUNT_24012011142 a ON t.Acc_no = a.acc_no
WHERE t.Mode_of_pay = 'Cheque';

-- 9.
SELECT l.loan_amt, NULL AS transaction_amt, NULL AS mode_of_pay
FROM LOAN_24012011142 l
WHERE MONTH(l.loan_date) = 5

UNION

SELECT NULL AS loan_amt, t.Amt AS transaction_amt, t.Mode_of_pay
FROM TRANSACTION_24012011142 t
WHERE MONTH(t.Tr_date) = 5;

-- 10.
SELECT a1.Name, a1.Balance
FROM ACCOUNT_24012011142 a1
JOIN ACCOUNT_24012011142 a2 ON a2.Name = 'Dave Hardik'
WHERE a1.Balance > a2.Balance;

-- 11.
SELECT *
FROM ACCOUNT_24012011142
WHERE Balance < (SELECT AVG(Balance) FROM ACCOUNT_24012011142);

-- 12.
SELECT *
FROM INSTALLMENT_24012011142
WHERE Amount > (SELECT MIN(Amt) FROM TRANSACTION_24012011142);

-- 13.
SELECT 
    (SELECT SUM(Amount) FROM INSTALLMENT_24012011142) AS total_installments,
    (SELECT SUM(Amt) FROM TRANSACTION_24012011142) AS total_transactions;

-- 14.
SELECT *
FROM ACCOUNT_24012011142
ORDER BY acc_no DESC
LIMIT 3;

-- 15.
SELECT *
FROM ACCOUNT_24012011142
ORDER BY acc_no
LIMIT 4 OFFSET 1;
