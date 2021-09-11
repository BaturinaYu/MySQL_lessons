-- Задание 1

SELECT CONCAT(u.first_name, ' ', u.last_name) AS best_friend, COUNT(*) AS count_messages FROM users u 
	JOIN messages m ON m.from_user_id = u.id
WHERE m.to_user_id = 6
GROUP BY best_friend
ORDER BY count_messages DESC LIMIT 1;

-- Задание 2

/* SELECT pl.post_id, u.first_name, TIMESTAMPDIFF(YEAR, p.birthday, NOW()) as age, pl.like_type FROM users u
	JOIN profiles p ON u.id = p.user_id 
	JOIN posts_likes pl ON u.id = pl.user_id 
WHERE pl.like_type = 1	
HAVING age < 10
ORDER BY u.first_name, pl.post_id ;*/

SELECT COUNT(*) AS baby_likes FROM users u
	JOIN profiles p ON u.id = p.user_id 
	JOIN posts_likes pl ON u.id = pl.user_id 
WHERE pl.like_type = 1 AND TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10
ORDER BY u.first_name, pl.post_id ;

-- Задание 3

/* SELECT p.gender, COUNT(*) AS count_likes FROM profiles p
	JOIN posts_likes pl ON p.user_id = pl.user_id 
WHERE pl.like_type = 1 AND p.gender IN ('f', 'm')
GROUP BY p.gender;*/

SELECT 
	CASE(p.gender)
		WHEN 'f' THEN 'Женщины'
		WHEN 'm' THEN 'Мужчины'
	END AS gender, COUNT(*) AS count_likes FROM profiles p
	JOIN posts_likes pl ON p.user_id = pl.user_id 
WHERE pl.like_type = 1 AND p.gender IN ('f', 'm')
GROUP BY p.gender
ORDER BY count_likes DESC LIMIT 1;	
	
