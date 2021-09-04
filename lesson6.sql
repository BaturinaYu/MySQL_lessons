-- Задание 1

SELECT id FROM users;

SELECT from_user_id, to_user_id FROM messages
WHERE to_user_id = 3;

SELECT MAX(count_message) AS max_count_message, from_user_id, to_user_id FROM
(SELECT COUNT(*) AS count_message, from_user_id, to_user_id FROM messages WHERE to_user_id = 3 GROUP BY from_user_id) t;

-- Задание 2

SELECT user_id, TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age 
FROM profiles
ORDER BY age; 

SELECT user_id FROM posts_likes
WHERE like_type = 1 AND user_id IN (7, 9);

SELECT SUM(like_type) sum_liked FROM posts_likes WHERE like_type = 1
AND user_id IN (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);

-- Задание 3

SELECT user_id, gender FROM profiles 
WHERE gender IN ('f', 'm') AND user_id IN 
(SELECT user_id FROM posts_likes WHERE like_type = 1);


SELECT MAX(sum_liked), 
	CASE(gender)
		WHEN 'f' THEN 'Лайков от женщин'
		WHEN 'm' THEN 'Лайков от мужчин'
	END	AS gender	
FROM
(SELECT SUM(like_type) AS sum_liked, 'f' AS gender FROM posts_likes
WHERE like_type = 1 AND user_id IN 
(SELECT user_id FROM profiles WHERE gender = 'f')
GROUP BY gender
UNION 
SELECT SUM(like_type) AS sum_liked, 'm' AS gender FROM posts_likes
WHERE like_type = 1 AND user_id IN 
(SELECT user_id FROM profiles WHERE gender = 'm')
GROUP BY gender) t;











