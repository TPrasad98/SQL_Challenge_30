CREATE DATABASE sql_challenge_30;
use  sql_challenge_30;

-- # 1/30
-- Amazon interview practice

CREATE TABLE Supplier (
    Supplier_id INT PRIMARY KEY,
    Supplier_Name VARCHAR(50),
    Country VARCHAR(20)
);

INSERT INTO Supplier 
(Supplier_id,Supplier_Name,Country)
Values
(1, 'Supplier A', 'USA'),
(2, 'Supplier B', 'USA'),
(3, 'Supplier C', 'Canada'),
(4, 'Supplier D', 'Canada'),
(5, 'Supplier E', 'Mexico');



-- creating the product table 
CREATE TABLE Product (
    Product_id INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Supplier_id INT,
    Price INT,
    FOREIGN KEY (Supplier_id)
        REFERENCES Supplier (Supplier_id)
);


INSERT INTO Product
	(Product_id,Product_Name,Supplier_id,Price)
VALUES
	(1, 'Product 1', 1, 150),
	(2, 'Product 2', 1, 200),
	(3, 'Product 3', 2, 250),
	(4, 'Product 4', 3, 300),
	(5, 'Product 5', 4, 350),
	(6, 'Product 6', 5, 400);
    
    
SELECT 
    *
FROM
    Product;
SELECT 
    *
FROM
    Supplier;


    
    
    
-- Approach - 1
WITH highest_price_cte 
AS(
	SELECT
		P.Product_Name,
        P.Price,
        S.Country,
        row_number() OVER (PARTITION BY S.Country 	ORDER BY P.Price DESC) AS Row_Num
						
	FROM	Product P
	JOIN	Supplier S 
	ON 		S.Supplier_id = P.Supplier_id)
    
SELECT
	Product_Name,
    Price,
    Country
FROM	highest_price_cte 
WHERE	Row_Num =1;


	

-- Approach-2

SELECT 
	X.Product_Name,
    X.Price,
    X.Country
FROM
(
	SELECT
			P.Product_Name,
			P.Price,
			S.Country,
			row_number() OVER (PARTITION BY S.Country 	ORDER BY P.Price DESC) rn
	FROM	
		Product P
	JOIN 
		Supplier S 
	ON 
		S.Supplier_id = P.Supplier_id
) X
WHERE 
	X.rn = 1;


-- ------------------------------xxxxxxxxxxxxxxxxx---------------------------------------------

CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Registration_Date DATE
);
    
-- Insert sample data into the Customer table
INSERT INTO Customer (Customer_id, Customer_Name, Registration_Date) VALUES
(1, 'Alice', '2020-05-15'),
(2, 'Bob', '2021-03-22'),
(3, 'Charlie', '2023-01-10');


-- Create Transaction Table

CREATE TABLE Transaction (
    Transaction_id INT PRIMARY KEY,
    Customer_id INT,
    Transaction_Date DATE,
    Amount DECIMAL(10 , 2 ),
    FOREIGN KEY (Customer_id)
        REFERENCES Customer (Customer_id)
);
    
-- Insert records into Transaction table
INSERT INTO Transaction (Transaction_id, Customer_id, Transaction_Date, Amount)
VALUES
    (201, 1, '2024-01-20', 50.00),
    (202, 1, '2024-02-05', 75.50),
    (203, 2, '2023-02-22', 100.00),
    (204, 3, '2022-03-15', 200.00),
    (205, 2, '2024-03-20', 120.75),
	(301, 1, '2024-01-20', 50.00),
    (302, 1, '2024-02-05', 75.50),
    (403, 2, '2023-02-22', 100.00),
    (304, 3, '2022-03-15', 200.00),
    (505, 2, '2024-03-20', 120.75);
	
 
SELECT 
    *
FROM
    Customer;
SELECT 
    *
FROM
    Transaction;

-- Solution

SELECT 
    C.Customer_id, C.Customer_Name, SUM(T.Amount) total_amount
FROM
    Customer C
        JOIN
    Transaction T ON C.Customer_id = T.Customer_id
WHERE
    EXTRACT(YEAR FROM T.Transaction_Date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY 1 , 2
;

-- verifying it
SELECT 
    SUM(amount)
FROM
    Transaction
WHERE
    customer_id = 1
        AND EXTRACT(YEAR FROM Transaction_Date) = '2024'