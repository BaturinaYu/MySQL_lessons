-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
-- Задание 1

USE shop;
UPDATE users SET created_at = NOW(), updated_at = NOW();
-- SELECT * FROM users;

-- Задание 2
-- дата вида 20.10.2017 8:10
-- создаём таблицу с полями created_at и updated_at с типом VARCHAR(20)
/*DROP TABLE IF EXISTS users1;
CREATE TABLE users1 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(20),
  updated_at VARCHAR(20)
) COMMENT = 'Покупатели';

INSERT INTO users1 (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '24.04.2017 4:12', '24.04.2017 4:12'),
  ('Александр', '1985-05-20', '25.06.2018 15:24', '25.06.2018 15:24'),
  ('Сергей', '1988-02-14', '26.12.2018 19:45', '26.12.2018 19:45'),
  ('Иван', '1998-01-12', '16.01.2019 21:48', '16.01.2019 21:48'),
  ('Мария', '1992-08-29', '10.02.2020 09:50', '10.02.2020 09:50');*/


UPDATE users1 SET created_at = CONVERT(REPLACE(created_at, SUBSTRING_INDEX(created_at, ' ', 1), CONCAT(
SUBSTRING(created_at, 7, 4), '-', 
SUBSTRING(created_at, 4, 2), '-', 
SUBSTRING(created_at, 1, 2))), DATETIME);

UPDATE users1 SET updated_at = CONVERT(REPLACE(updated_at, SUBSTRING_INDEX(updated_at, ' ', 1), CONCAT(
SUBSTRING(updated_at, 7, 4), '-', 
SUBSTRING(updated_at, 4, 2), '-', 
SUBSTRING(updated_at, 1, 2))), DATETIME);

ALTER TABLE users1 MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users1 MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Задание 3

SELECT * FROM storehouses_products 
ORDER BY IF(value = 0, 1, 0), value;

-- Задание 5

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);

-- Практическое задание теме “Агрегация данных”
-- Задание 1

SELECT AVG(YEAR(NOW())-YEAR(birthday_at)) as AVG_age
FROM users;

-- Задание 2

SELECT DAYOFWEEK(birthday_at) AS n, 
CASE 
	WHEN DAYOFWEEK(birthday_at) = 1 THEN 'Понедельник'
	WHEN DAYOFWEEK(birthday_at) = 2 THEN 'Вторник'
	WHEN DAYOFWEEK(birthday_at) = 3 THEN 'Среда'
	WHEN DAYOFWEEK(birthday_at) = 4 THEN 'Четверг'
	WHEN DAYOFWEEK(birthday_at) = 5 THEN 'Пятница'
	WHEN DAYOFWEEK(birthday_at) = 6 THEN 'Суббота'
	WHEN DAYOFWEEK(birthday_at) = 7 THEN 'Воскресенье'  END as day, 
COUNT(DAYOFWEEK(birthday_at)) AS count 
FROM users
GROUP BY n, day
ORDER BY n;

-- Задание 3

SELECT ROUND(EXP(SUM(LOG(value))),1)
FROM storehouses_products;







