DROP DATABASE sample2;

CREATE DATABASE sample2;

CREATE TABLE customer (
	customerid INT AUTO_INCREMENT PRIMARY KEY,
    customernumber INT NOT NULL UNIQUE CHECK (customernumber > 0),
    lastname VARCHAR(30) NOT NULL,
    firstname VARCHAR(30) NOT NULL,
    areacode INT DEFAULT 71000,
    address VARCHAR(50),
    country VARCHAR(50) default 'Malaysia'
);

INSERT INTO customer (customernumber,lastname,firstname,areacode,address,country)
VALUES 	(100,'Fang Ying','Sham','418999','sdadasfdfd',DEFAULT),
		(200,'Mei Mei','Tan',default,'adssdsadsd','Thailand'),
        (300,'Albert','John',default,'dfdsfsdf',default);
        
SELECT * FROM customer;

SELECT customerid, customernumber, lastname, firstname
FROM customer;

ALTER TABLE customer
ADD phonenumber VARCHAR(20);
SELECT * FROM customer;

UPDATE customer
SET phonenumber = '45554654'
WHERE customerid = 2;
SELECT * FROM customer;

ALTER TABLE customer
DROP COLUMN phonenumber;
SELECT * FROM customer;

DELETE 
FROM customer
WHERE country = 'Thailand';

SELECT * FROM customer;

ALTER TABLE customer
ALTER COLUMN phonenumber VARCHAR(10);

CREATE DATABASE SaleOrder;
USE Saleorder;

CREATE TABLE customer(
	CustomerID INT NOT NULL PRIMARY KEY,
    CustomerFirstName VARCHAR(50) NOT NULL,
    CustomerLastName VARCHAR(50) NOT NULL,
    CustomerAddress VARCHAR(50) NOT NULL,
    CustomerSuburb VARCHAR(50) NOT NULL,
    CustomerCity VARCHAR(50) NOT NULL,
    CustomerPostCode CHAR(4) NULL,
    CustomerPhoneNumber CHAR(12) NULL    
);

CREATE TABLE inventory (
	InventoryID TINYINT NOT NULL PRIMARY KEY,
    InventoryName VARCHAR(50) NOT NULL,
    InentoryDescription VARCHAR(255) NULL
);

CREATE TABLE employee(
	EmployeeID TINYINT NOT NULL PRIMARY KEY,
    EmployeeFirstName VARCHAR(50) NOT NULL,
    EmployeeLastName VARCHAR(50) NOT NULL,
    EmployeeExtension CHAR(4) NULL
);

CREATE TABLE sale(
	SaleID TINYINT NOT NULL PRIMARY KEY,
    CustomerID INT NOT NULL REFERENCES customer(CustomerID),
    InventoryID TINYINT NOT NULL REFERENCES inventory(inventoryID),
    EmployeeID TINYINT NOT NULL REFERENCES Employee(EmployeeID),
    SaleDate DATE NOT NULL,
    SaleQuantity INT NOT NULL,
    SaleUnitPrice DECIMAL(4, 2)
);

SELECT * FROM information_schema.tables;

SELECT top 2 * 
FROM customer