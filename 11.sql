-- SQL Challenge 11/30 Days 

CREATE TABLE job_listings (
    job_id INTEGER PRIMARY KEY,
    company_id INTEGER,
    title TEXT,
    description TEXT
);

INSERT INTO job_listings (job_id, company_id, title, description)
VALUES
    (248, 827, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
    (149, 845, 'Business Analyst', 'Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.'),
    (945, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.'),
    (164, 345, 'Data Analyst', 'Data analyst reviews data to identify key insights into a business''s customers and ways the data can be used to solve problems.'),
    (172, 244, 'Data Engineer', 'Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.'),
    (573, 456, 'Software Engineer', 'Software engineer designs, develops, tests, and maintains software applications.'),
    (324, 789, 'Software Engineer', 'Software engineer designs, develops, tests, and maintains software applications.'),
    (890, 123, 'Data Scientist', 'Data scientist analyzes and interprets complex data to help organizations make informed decisions.'),
    (753, 123, 'Data Scientist', 'Data scientist analyzes and interprets complex data to help organizations make informed decisions.');


/*
-- Q.1 LinkedIn Data Analyst Interview question 

Assume you're given a table containing job postings 
from various companies on the LinkedIn platform. 
Write a query to retrieve the count of companies
that have posted duplicate job listings.

Definition:

Duplicate job listings are defined as two job listings 
within the same company that share identical titles and descriptions.
*/



-- -----------------------------------------------------------------
-- My Solution
-- -----------------------------------------------------------------

-- count of company who posted more 1 jobs wiht same title and desc


select * from job_listings;


-- with CTE
WITH duplicate_jobs 
AS (
	SELECT
		company_id,
        title,
        description,
        COUNT(*) AS total_job
	FROM
		job_listings
	GROUP BY 1,2,3
    HAVING
		COUNT(*) > 1
)
SELECT COUNT(*) count_comp
FROM duplicate_jobs
;

-- with subqueries

SELECT
	COUNT(*) as cnt_company
FROM 	
	(SELECT 
		company_id,
		title,
		description,
		COUNT(1) as total_job
	FROM job_listings
	GROUP BY 1, 2, 3
	HAVING COUNT(1) > 1
)X1;






-- Q2 - Flipkart Business Analyst entry level SQL question


CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    Region VARCHAR(50),
    Amount DECIMAL(10, 2),
    SaleDate DATE
);

INSERT INTO Sales (Region, Amount, SaleDate) VALUES
('North', 5000.00, '2024-07-01'),
('South', 6000.00, '2024-07-03'),
('East', 4500.00, '2024-07-05'),
('West', 7000.00, '2024-07-07'),
('North', 5500.00, '2024-07-09'),
('South', 6500.00, '2024-07-11'),
('East', 4800.00, '2024-07-13'),
('West', 7200.00, '2024-07-15'),
('North', 5200.00, '2024-07-17'),
('South', 6200.00, '2024-07-19'),
('East', 4700.00, '2024-07-21'),
('West', 7100.00, '2024-07-23'),
('North', 5300.00, '2024-07-25'),
('South', 6300.00, '2024-07-27'),
('East', 4600.00, '2024-07-29'),
('West', 7300.00, '2024-07-31'),
('North', 5000.00, '2023-07-01'),
('South', 6000.00, '2023-07-15'),
('East', 4500.00, '2023-07-29'),
('West', 7000.00, '2023-08-10'),
('North', 5500.00, '2023-08-25'),
('South', 6500.00, '2023-09-01'),
('East', 4800.00, '2023-09-10'),
('West', 7200.00, '2023-09-20'),
('North', 5200.00, '2023-10-01'),
('South', 6200.00, '2023-10-15'),
('North', 5400.00, '2024-08-02'),
('South', 6400.00, '2024-08-04'),
('East', 4900.00, '2024-08-06'),
('West', 7400.00, '2024-08-08');



/*

Identify the region with the lowest sales amount for the previous month. 
return region name and total_sale amount.

*/
-- region and sum sale
-- filter last month
-- lowest sale region

-- -----------------------------------------------------
-- My Solution
-- -----------------------------------------------------

select * from sales;

SELECT 
    region,
    SUM(amount) AS total_sales
FROM sales
WHERE 
    MONTH(saledate) = MONTH(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
    AND YEAR(saledate) = YEAR(CURDATE())
GROUP BY region
ORDER BY total_sales ASC
LIMIT 1;

