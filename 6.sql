-- Day 06/30 days sql challenge


-- SCHEMAS


-- Create viewership table
DROP TABLE IF EXISTS viewership;
CREATE TABLE viewership (
	user_id INT,
    device_type VARCHAR(25),
    view_time  TIMESTAMP
);

INSERT INTO viewership (user_id, device_type, view_time)
VALUES 
(150, 'phone', '2022-03-10 14:25:00'),
(151, 'laptop', '2022-03-11 09:15:00'),
(152, 'tablet', '2022-03-12 17:45:00'),
(153, 'phone', '2022-03-13 11:00:00'),
(154, 'laptop', '2022-03-14 19:30:00');


-- Formulate the question


/*

Question:
Write a query that calculates the total viewership for laptops and mobile devices, 
where mobile is defined as the sum of tablet and phone viewership. Output the total 
viewership for laptops as laptop_views and the total viewership for mobile devices as mobile_views.

*/

-- Question link https://datalemur.com/questions/laptop-mobile-viewership

-- ----------------------------------------------
-- My solution
-- ----------------------------------------------



SELECT 
	SUM(CASE WHEN device_type IN ('phone','tablet') THEN 1 ELSE 0 END) AS mobile_views,
    SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views
FROM viewership;


-- -----------------------QUESTION - 2 --------------------------------------


/*
Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

*/

-- CREATE tweets TABLE
CREATE TABLE tweets (
    tweet_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    msg VARCHAR(255),
    tweet_date TIMESTAMP
);

-- INSERT VALUE INTO tweets table

INSERT INTO tweets (tweet_id, user_id, msg, tweet_date) VALUES
(214252, 111, 'Am considering taking Tesla private at $420. Funding secured.', '2021-12-30 00:00:00'),
(739252, 111, 'Despite the constant negative press covfefe', '2022-01-01 00:00:00'),
(846402, 111, 'Following @NickSinghTech on Twitter changed my life!', '2022-02-14 00:00:00'),
(241425, 254, 'If the salary is so competitive why won’t you tell me what it is?', '2022-03-01 00:00:00'),
(231574, 148, 'I no longer have a manager. I can\'t be managed', '2022-03-23 00:00:00');



-- ------------------------------
--       Solution 
-- ------------------------------


SELECT *
FROM tweets;


WITH tweet_counts
AS (
	SELECT user_id,
    COUNT(msg) AS tweet_bucket
    FROM tweets
    WHERE YEAR(tweet_date) =2022
    GROUP BY user_id
)
SELECT
	tweet_bucket,
    COUNT(user_id) AS users_num
FROM
	tweet_counts
GROUP BY
	tweet_bucket
;


-----

SELECT 
    tweet_count AS tweet_bucket, 
    COUNT(user_id) AS users_num
FROM (
    SELECT 
        user_id, 
        COUNT(tweet_id) AS tweet_count
    FROM 
        tweets
    WHERE 
        YEAR(tweet_date) = 2022
    GROUP BY 
        user_id
) AS user_tweet_counts
GROUP BY 
    tweet_count
ORDER BY 
    tweet_bucket;




    


