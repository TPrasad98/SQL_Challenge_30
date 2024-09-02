
-- Leetcode problem LeetCode SQL Premium Problem 2853: 'Highest Salary Difference'

/*
Write an SQL query to calculate the difference 
between the highest salaries 
in the marketing and engineering department. 
Output the absolute difference in salaries.
*/

-- create the Salaries table
CREATE TABLE Salaries (
emp_name VARCHAR(50),
department VARCHAR(50),
salary INT,
PRIMARY KEY (emp_name, department)
);

-- Insert Data Into Salaries table
INSERT INTO Salaries 
(emp_name, department, salary) 
VALUES
	('Kathy', 'Engineering', 50000),
	('Roy', 'Marketing', 30000),
	('Charles', 'Engineering', 45000),
	('Jack', 'Engineering', 85000),
	('Benjamin', 'Marketing', 34000),
	('Anthony', 'Marketing', 42000),
	('Edward', 'Engineering', 102000),
	('Terry', 'Engineering', 44000),
	('Evelyn', 'Marketing', 53000),
	('Arthur', 'Engineering', 32000);
    
    

-- ----------------------------------------------
-- My solution
-- ----------------------------------------------


    
SELECT 
	ABS(MAX(CASE WHEN department = 'Marketing' THEN salary END) -
	MAX(CASE WHEN department = 'Engineering' THEN salary END)) AS salary_diff
FROM Salaries;


-- ------------------------------QUESTION - 2 --------------------------------------------
-- ---------------------------------------------------------------------------------------

/*
Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. 
Output the results in descending order based on the count of the messages.
*/

-- ----------------------
--       SOLUTION
-- ----------------------

-- Create the Messages Table

CREATE TABLE Messages (
    message_id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    content VARCHAR(255),
    sent_date DATETIME
);


-- Insert Data into the Messages Table:

INSERT INTO Messages (message_id, sender_id, receiver_id, content, sent_date) VALUES
(901, 3601, 4500, 'You up?', '2022-08-03 16:43:00'),
(743, 3601, 8752, 'Let''s take this offline', '2022-06-14 14:30:00'),
(888, 3601, 7855, 'DataLemur has awesome user base!', '2022-08-12 08:45:00'),
(898, 2520, 9630, 'Are you ready for your upcoming presentation?', '2022-08-13 14:35:00'),
(990, 2520, 8520, 'Maybe it was done by the automation process.', '2022-08-19 06:30:00'),
(819, 2310, 4500, 'What''s the status on this?', '2022-07-10 15:55:00'),
(922, 3601, 4500, 'Get on the call', '2022-08-10 17:03:00'),
(942, 2520, 3561, 'How much do you know about Data Science?', '2022-08-17 13:44:00'),
(966, 3601, 7852, 'Meet me in five!', '2022-08-17 02:20:00'),
(902, 4500, 3601, 'Only if you''re buying', '2022-08-03 06:50:00');


SELECT * FROM Messages;


SELECT 
    sender_id,
    COUNT(*) AS total_messages
FROM 
    Messages
WHERE 
    DATE_FORMAT(sent_date, '%Y-%m') = '2022-08'
GROUP BY 
    sender_id
ORDER BY 
    total_messages DESC
LIMIT 2;


