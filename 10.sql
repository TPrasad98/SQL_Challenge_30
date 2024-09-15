-- 10/30 SQL Challenge

-- Facebook medium level SQL question for Data Analyst 
-- ---------------------------------------------------
-- ---------------------------------------------------

-- Q.1 SCHEMAS

CREATE TABLE fb_posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    likes INT,
    comments INT,
    post_date DATE
);


INSERT INTO fb_posts (post_id, user_id, likes, comments, post_date) VALUES
(1, 101, 50, 20, '2024-02-27'),
(2, 102, 30, 15, '2024-02-28'),
(3, 103, 70, 25, '2024-02-29'),
(4, 101, 80, 30, '2024-03-01'),
(5, 102, 40, 10, '2024-03-02'),
(6, 103, 60, 20, '2024-03-03'),
(7, 101, 90, 35, '2024-03-04'),
(8, 101, 90, 35, '2024-03-05'),
(9, 102, 50, 15, '2024-03-06'),
(10, 103, 30, 10, '2024-03-07'),
(11, 101, 60, 25, '2024-03-08'),
(12, 102, 70, 30, '2024-03-09'),
(13, 103, 80, 35, '2024-03-10'),
(14, 101, 40, 20, '2024-03-11'),
(15, 102, 90, 40, '2024-03-12'),
(16, 103, 20, 5, '2024-03-13'),
(17, 101, 70, 25, '2024-03-14'),
(18, 102, 50, 15, '2024-03-15'),
(19, 103, 30, 10, '2024-03-16'),
(20, 101, 60, 20, '2024-03-17');

/*
-- Q.1
Question: Identify the top 3 posts with the highest engagement 
(likes + comments) for each user on a Facebook page. Display 
the user ID, post ID, engagement count, and rank for each post.
*/


select * from fb_posts;


WITH engagement_rankings AS
	(
    SELECT 
		user_id ,
        post_id,
        sum(likes+ comments) as engagement_count,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY SUM(likes + comments) DESC) rn,
		DENSE_RANK() OVER(PARTITION BY user_id ORDER BY SUM(likes + comments) DESC) ranks
        FROM fb_posts
	GROUP BY user_id, post_id
	ORDER BY user_id, engagement_count DESC
        
    )
    
SELECT 
	user_id,
    post_id,
    engagement_count,
    rn
FROM
	engagement_rankings
WHERE
	rn <= 3
;






-- Schemas for Q.2

CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    likes INT,
    post_date DATE
);

INSERT INTO posts (post_id, user_id, likes, post_date) VALUES
(1, 101, 50, '2024-09-20'),
(2, 102, 30, '2024-09-21'),
(3, 103, 70, '2024-09-22'),
(4, 101, 80, '2024-09-23'),
(5, 102, 40, '2024-09-24'),
(6, 103, 60, '2024-09-25'),
(7, 101, 90, '2024-09-26'),
(8, 102, 55, '2024-09-27'),
(9, 103, 45, '2024-09-28'),
(10, 101, 60, '2024-09-29'),
(11, 102, 35, '2024-09-30'),
(12, 103, 75, '2024-10-01'),
(13, 101, 65, '2024-10-02'),
(14, 102, 40, '2024-10-03'),
(15, 103, 85, '2024-10-04'),
(16, 101, 95, '2024-10-05'),
(17, 102, 60, '2024-10-06'),
(18, 103, 50, '2024-10-07'),
(19, 101, 55, '2024-10-08'),
(20, 102, 65, '2024-10-09'),
(21, 103, 70, '2024-10-10'),
(22, 101, 75, '2024-10-11'),
(23, 102, 85, '2024-10-12'),
(24, 103, 90, '2024-10-13'),
(25, 101, 100, '2024-10-14'),
(26, 102, 95, '2024-10-15');







/*
-- Q.2

Determine the users who have posted more than 2 times 
in the past week and calculate the total number of likes
they have received. Return user_id and number of post and no of likes
*/


-- ------------------------------------------------------------------------
-- My Solution for Q2
-- ----------------------------------------------------------------------
-- user posted > 2
-- sum(likes)
-- COUNT(post)
-- past week


SELECT * FROM posts;


WITH recentposts 
AS (
	SELECT 
		user_id,
        SUM(likes) AS total_likes,
        COUNT(post_id) AS num_of_posts
	FROM
		posts
	WHERE 
		post_date >= current_date() - INTERVAL 7 day
	GROUP BY
		user_id
)
SELECT *
FROM recentposts
WHERE num_of_posts >= 2
;



