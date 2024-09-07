-- Day 07/30 SQL Challenge


-- Create product_spend table
CREATE TABLE product_spend (
    category VARCHAR(255),
    product VARCHAR(255),
    user_id INTEGER,
    spend DECIMAL(10, 2),
    transaction_date TIMESTAMP
);

-- Insert sample records
INSERT INTO product_spend (category, product, user_id, spend, transaction_date) VALUES
('appliance', 'refrigerator', 165, 246.00, '2021-12-26 12:00:00'),
('appliance', 'refrigerator', 123, 299.99, '2022-03-02 12:00:00'),
('appliance', 'washing machine', 123, 219.80, '2022-03-02 12:00:00'),
('electronics', 'vacuum', 178, 152.00, '2022-04-05 12:00:00'),
('electronics', 'wireless headset', 156, 249.90, '2022-07-08 12:00:00'),
('electronics', 'vacuum', 145, 189.00, '2022-07-15 12:00:00');

-- Formulate the question


/*
-- Amazon Interview question

Question:
Write a query to identify the top two highest-grossing products 
within each category in the year 2022. Output should include the category,
product, and total spend.

*/


SELECT * FROM product_spend;


-- SUB QUERY
SELECT 
	category,
    product,
    total_spend
 FROM 
(
SELECT
	category,
    product,
    sum(spend) as total_spend,
    RANK() OVER(PARTITION BY category ORDER BY sum(spend) desc) as rn
FROM product_spend
WHERE YEAR(transaction_date) = 2022
GROUP BY category,product
) AS X1
WHERE
X1.rn <= 2;


--- CTE
WITH product_totals AS (
    SELECT 
        category,
        product,
        SUM(spend) AS total_spend,
        RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS rnk
    FROM product_spend
    WHERE YEAR(transaction_date) = 2022
    GROUP BY category, product
)
SELECT 
    category,
    product,
    total_spend
FROM product_totals
WHERE rnk <= 2
;


-- -------------------------------------------------------

-- Create Department table
CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert values into Department table
INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');

-- Create Employee table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

-- Insert additional records into Employee table
INSERT INTO Employee (id, name, salary, departmentId) VALUES
(8, 'Alice', 75000, 2),
(9, 'Bob', 82000, 2),
(10, 'Carol', 78000, 1),
(11, 'David', 70000, 1),
(12, 'Eva', 85000, 2),
(13, 'Frank', 72000, 1),
(14, 'Gina', 83000, 1),
(15, 'Hank', 68000, 1),
(16, 'Irene', 76000, 2),
(17, 'Jack', 74000, 2),
(18, 'Kelly', 79000, 1),
(19, 'Liam', 71000, 1),
(20, 'Molly', 77000, 2),
(21, 'Nathan', 81000, 1),
(22, 'Olivia', 73000, 2),
(23, 'Peter', 78000, 1),
(24, 'Quinn', 72000, 1),
(25, 'Rachel', 80000, 2),
(26, 'Steve', 75000, 2),
(27, 'Tina', 79000, 1);



SELECT * FROM Employee;
SELECT * FROM Department;


/*
-- Question Day-09/30 Find Department's Top three 
salaries in each department.

Table: department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |  id is primary key
| name        | varchar |	department_name
+-------------+---------+

Table: employee
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |		id is the primary key
| name         | varchar |
| salary       | int     |
| departmentId | int     |		departmentId is the foreign key	
+--------------+---------+

 A company's executives are interested in seeing who earns the most 
 money in each of the company's departments. 
 A high earner in a department is an employee 
 who has a salary in the top three unique salaries 
 for that department.

-- Write a solution to find the employees 
who are high earners in each of the departments.
*/


-- CTE

WITH top_3_salary AS
	(
    SELECT 
		e.id,
		e.name,
		e.salary,
		d.name AS department,
		dense_rank() OVER(partition by d.name order by e.salary DESC) AS dns_rnk
	FROM Employee e
	JOIN Department d
	ON e.departmentid = d.id
)
SELECT 
		id,
		name,
		salary,
		department
FROM top_3_salary
WHERE dns_rnk <= 3;




-- SUB QUERY


SELECT *
FROM (
SELECT 
	e.id,
    e.name,
    e.salary,
    d.name AS department,
    dense_rank() OVER(partition by d.name order by e.salary DESC) AS dns_rnk
FROM Employee e
JOIN Department d
ON e.departmentid = d.id
) AS X1
WHERE dns_rnk <=3;
