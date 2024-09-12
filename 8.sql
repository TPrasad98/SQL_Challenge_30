-- Day 08/30 SQL Interview Question - Medium

CREATE TABLE Transactionss (
    id INT PRIMARY KEY,
    country VARCHAR(255),
    state VARCHAR(20),
    amount INT,
    trans_date DATE
);

INSERT INTO Transactionss (id, country, state, amount, trans_date) VALUES
(121, 'US', 'approved', 1000, '2018-12-18'),
(122, 'US', 'declined', 2000, '2018-12-19'),
(123, 'US', 'approved', 2000, '2019-01-01'),
(124, 'DE', 'approved', 2000, '2019-01-07');


/*
Write an SQL query to find for each month and country, 
the number of transactions and their total amount, 
the number of approved transactions and their total amount.

Return the result table in in below order.RANGE


Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/

-- -------------------------------------------------------------
-- My Solution
-- -------------------------------------------------------------

select * from transactionss;

SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM 
    Transactionss
GROUP BY 
    month, country
ORDER BY 
    month, country;





-- QUESTION  2

CREATE TABLE reviews (
    review_id INTEGER,
    user_id INTEGER,
    submit_date TIMESTAMP,
    product_id INTEGER,
    stars INTEGER
);

INSERT INTO reviews (review_id, user_id, submit_date, product_id, stars) VALUES
(6171, 123, '2022-06-08 00:00:00', 50001, 4),
(7802, 265, '2022-06-10 00:00:00', 69852, 4),
(5293, 362, '2022-06-18 00:00:00', 50001, 3),
(6352, 192, '2022-07-26 00:00:00', 69852, 3),
(4517, 981, '2022-07-05 00:00:00', 69852, 2),
(8654, 753, '2022-08-15 00:00:00', 50001, 5),
(9743, 642, '2022-08-22 00:00:00', 69852, 3),
(1025, 874, '2022-08-05 00:00:00', 50001, 4),
(2089, 512, '2022-09-10 00:00:00', 69852, 2),
(3078, 369, '2022-09-18 00:00:00', 50001, 5),
(4056, 785, '2022-09-25 00:00:00', 69852, 4),
(5034, 641, '2022-10-12 00:00:00', 50001, 3),
(6023, 829, '2022-10-18 00:00:00', 69852, 5),
(7012, 957, '2022-10-25 00:00:00', 50001, 2),
(8001, 413, '2022-11-05 00:00:00', 69852, 4),
(8990, 268, '2022-11-15 00:00:00', 50001, 3),
(9967, 518, '2022-11-22 00:00:00', 69852, 3),
(1086, 753, '2022-12-10 00:00:00', 50001, 5),
(1175, 642, '2022-12-18 00:00:00', 69852, 4),
(1264, 874, '2022-12-25 00:00:00', 50001, 3),
(1353, 512, '2022-12-31 00:00:00', 69852, 2),
(1442, 369, '2023-01-05 00:00:00', 50001, 4),
(1531, 785, '2023-01-15 00:00:00', 69852, 5),
(1620, 641, '2023-01-22 00:00:00', 50001, 3),
(1709, 829, '2023-01-30 00:00:00', 69852, 4);



-- ---------------------------------------------
-- Amazon Interview Question for enty Business Analyst!
-- ---------------------------------------------
/*
Question:: Given the reviews table, write a query to retrieve 
the average star rating for each product, grouped by month. 
The output should display the month as a numerical value, 
product ID, and average star rating rounded to two decimal places. 
Sort the output first by month and then by product ID.
*/

-- ---------------------------------
-- My Solution
-- ---------------------------------


SELECT * FROM reviews;


SELECT 
	EXTRACT(month from submit_date) as month,
    product_id,
    ROUND(avg(stars),2) as avg_rating
FROM reviews
GROUP BY 1,2
ORDER BY 1,2;