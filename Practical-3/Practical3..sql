-- PROMPT 24012011142_Vatsal [\d] \D \n>
-- tee c:/Users/Lenovo/Desktop/DBMS/DBMS_Practicals/Practical-1/Task.txt

CREATE DATABASE Practical_3_24012011142;

USE Practical_3_24012011142;

-- 1. TABLE Creation and Insertion of Data

CREATE TABLE Account_24012011142 (
    Acc_no VARCHAR(5),
    Name VARCHAR(30) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Balance DECIMAL(10,2) CHECK (Balance >= 500),
    loan_taken VARCHAR(3) CHECK (loan_taken IN ('YES', 'NO')),
    PRIMARY KEY (Acc_no)
);

INSERT INTO Account_24012011142 (Acc_no, Name, City, Balance, loan_taken) VALUES
('A001', 'Patel Jigar', 'Mehsana', 50000.00, 'YES'),
('A002', 'Patel Ramesh', 'Mehsana', 50000.00, 'YES'),
('A003', 'Dave Hardik', 'Ahmedabad', 75000.00, 'NO'),
('A004', 'Soni Hetal', 'Ahmedabad', 100000.00, 'NO'),
('A005', 'Sony Atul', 'Vadodara', 100000.00, 'YES'),
('A005', 'Patel Arun', 'Surat', 4000.00, 'NO'),
('A006', NULL, 'Baroda', 5000.00, 'NO'),
('A007', 'Patel Rachit', NULL, 5000.00, 'NO'),
('A008', 'Patel Vir', 'Mehsana', 400.00, 'NO'),
('A009', 'Patel Vyom', 'Surat', 1000.00, 'ABC');


CREATE TABLE Loan_24012011142(
    Loan_no VARCHAR(5) CHECK (Loan_no LIKE 'L%'),
    Acc_no VARCHAR(5),
    Loan_amt DECIMAL(10,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    Loan_date DATE,
    Remaining_amt DECIMAL(10,2),
    PRIMARY KEY (Loan_no),
    FOREIGN KEY (Acc_no) REFERENCES Account_24012011142(Acc_no),
    CHECK (Remaining_amt <= Loan_amt)
);

INSERT INTO Loan_24012011142 (Loan_no, Acc_no, Loan_amt, interest_rate, Loan_date, Remaining_amt) VALUES
('L001', 'A001', 100000.00, 7.0, '2004-01-01', 75000.00),
('L002', 'A002', 100000.00, 9.0, '2004-05-18', 150000.00),
('L003', 'A005', 100000.00, 11.0, '2004-06-15', 300000.00);

CREATE TABLE Installment_24012011142(
    Loan_no VARCHAR(5),
    Inst_no VARCHAR(5) CHECK (Inst_no LIKE 'I%'),
    Idate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Loan_no) REFERENCES Loan_24012011142(Loan_no)
);

INSERT INTO Installment_24012011142 (Loan_no, Inst_no, Idate, Amount) VALUES
('L001', 'I001', '2004-02-02', 15000.00),
('L002', 'I002', '2004-06-18', 20000.00),
('L003', 'I003', '2004-07-15', 20000.00);


-- 2. CONSTRAINTS Based Queries

CREATE TABLE Student_24012011142(
    Rollno VARCHAR(6),
    Name VARCHAR(20),
    Branch VARCHAR(6),
    Address VARCHAR(20),
    Mobile_Number DECIMAL(10)
);
DESC Student_24012011142;

-- 1. Primary Key Constraint
ALTER TABLE Student_24012011142
ADD CONSTRAINT PRIM_rollno PRIMARY KEY (Rollno);
DESC Student_24012011142;

-- 2. Not Null Constraint
ALTER TABLE Student_24012011142
MODIFY Name VARCHAR(20) NOT NULL;
DESC Student_24012011142;

ALTER TABLE Student_24012011142
MODIFY Branch VARCHAR(6) NOT NULL;
DESC Student_24012011142;

-- 3. Check Constraint
ALTER TABLE Student_24012011142
ADD CONSTRAINT CHK_cap CHECK (UPPER(LEFT(Name,1)) = LEFT(Name,1));
DESC Student_24012011142;

-- 4. Unique Constraint
ALTER TABLE Student_24012011142
ADD CONSTRAINT UNI_mobilenumber UNIQUE (Mobile_Number);
DESC Student_24012011142;

-- 5. DROP CHECK Constraint
ALTER TABLE Student_24012011142
DROP CONSTRAINT CHK_cap;
DESC Student_24012011142;

----

CREATE TABLE Register_24012011142(
    Rollno VARCHAR(6),
    Name VARCHAR(20)
);
DESC Register_24012011142;

-- 1. Foreign Key Constraint
ALTER TABLE Register_24012011142
ADD CONSTRAINT FOR_rollno FOREIGN KEY (Rollno) REFERENCES Student_24012011142(Rollno);
DESC Register_24012011142;

-- 2. Check Constraint
ALTER TABLE Register_24012011142
ADD CONSTRAINT CHK_cap CHECK (UPPER(LEFT(Name,1)) = LEFT(Name,1));
DESC Register_24012011142;

-- 3. NOT NULL Constraint
ALTER TABLE Register_24012011142
MODIFY Name VARCHAR(20) NOT NULL;
DESC Register_24012011142;

-- 4. DROP FOREIGN KEY Constraint
ALTER TABLE Register_24012011142
DROP CONSTRAINT FOR_rollno;
DESC Register_24012011142;

-- 5. DROP NOT NULL Constraint
-- In MySQL, you cannot drop a NOT NULL constraint by using DROP CONSTRAINT. 
-- Instead, you need to MODIFY the column to allow NULL values.
ALTER TABLE Register_24012011142
MODIFY Name VARCHAR(20) NULL;
DESC Register_24012011142;


-----

-- DIY

CREATE TABLE Car_24012011142 (
    CarId VARCHAR(5),
    ModelName VARCHAR(30) NOT NULL,
    LaunchYear INT CHECK (LaunchYear >= 1990 AND LaunchYear <= YEAR(CURDATE())),
    PRIMARY KEY (CarId)
);

CREATE TABLE Customer_24012011142 (
    Cust_Id VARCHAR(5),
    Email VARCHAR(50) UNIQUE,
    PhoneNumber VARCHAR(15) NOT NULL,
    PRIMARY KEY (Cust_Id)
);

CREATE TABLE Order_24012011142 (
    OrderId VARCHAR(5) PRIMARY KEY,
    CustomerId VARCHAR(5),
    CarId VARCHAR(5),
    Quantity INT CHECK (Quantity > 0),
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customer_24012011142(Cust_Id),
    FOREIGN KEY (CarId) REFERENCES Car_24012011142(CarId)
);
