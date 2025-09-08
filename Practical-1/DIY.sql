CREATE DATABASE CAR_24012011142;

USE CAR_24012011142;

CREATE TABLE Cars_24012011142 (
    car_id VARCHAR(5) PRIMARY KEY,
    model_name VARCHAR(50),
    year INT,
    price DECIMAL(10,2)
);

DESC Cars_24012011142;

CREATE TABLE Manufacturers_24012011142 (
    manufacturer_id VARCHAR(5) PRIMARY KEY,
    name VARCHAR(50),
    country VARCHAR(50)
);

DESC Manufacturers_24012011142;

CREATE TABLE Production_24012011142 (
    production_id VARCHAR(5) PRIMARY KEY,
    car_id VARCHAR(5),
    manufacturer_id VARCHAR(5),
    production_date DATE,
    units_produced INT
);

DESC Production_24012011142;

-- Dummy data for Cars
INSERT INTO Cars_24012011142 (car_id, model_name, year, price) VALUES
('C001', 'Speedster', 2021, 25000),
('C002', 'EchoDrive', 2023, 18000),
('C003', 'UrbanX', 2022, 22000),
('C004', 'FamilyGo', 2020, 17000);

-- Dummy data for Manufacturers
INSERT INTO Manufacturers_24012011142 (manufacturer_id, name, country) VALUES
('M01', 'AutoTech', 'Germany'),
('M02', 'Green Motors', 'USA'),
('M03', 'City Cars', 'Japan'),
('M04', 'Family Motors', 'India');

-- Dummy data for Production
INSERT INTO Production_24012011142 (production_id, car_id, manufacturer_id, production_date, units_produced) VALUES
('P001', 'C001', 'M01', '2021-03-10', 150),
('P002', 'C002', 'M02', '2023-07-15', 200),
('P003', 'C003', 'M03', '2022-11-05', 180),
('P004', 'C004', 'M04', '2020-06-20', 120);

SELECT * FROM Cars_24012011142;
SELECT * FROM Cars_24012011142 WHERE year > 2020;

SELECT * FROM Manufacturers_24012011142;
SELECT name, country FROM Manufacturers_24012011142;

SELECT * FROM Cars_24012011142;
UPDATE Cars_24012011142 SET price = 19500 WHERE car_id = 'C002';
SELECT * FROM Cars_24012011142;

SELECT * FROM Manufacturers_24012011142;
UPDATE Manufacturers_24012011142 SET name = 'EcoMotors' WHERE manufacturer_id = 'M02';
SELECT * FROM Manufacturers_24012011142;

SELECT * FROM Cars_24012011142;
DELETE FROM Cars_24012011142 WHERE car_id = 'C003';
SELECT * FROM Cars_24012011142;

SELECT * FROM Production_24012011142;
DELETE from Production_24012011142 WHERE production_id = 'P003';
SELECT * FROM Production_24012011142;

SELECT * FROM Production_24012011142;
