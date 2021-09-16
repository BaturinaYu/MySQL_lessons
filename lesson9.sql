-- Практическое задание по теме “Транзакции, переменные, представления”
-- Задание 1 ------------------------------------------------------------------------------------------------------------

/*SELECT * FROM shop.users 
WHERE shop.users.id = 1;

SELECT * FROM sample.users;*/

START TRANSACTION;

INSERT INTO sample.users 
SELECT * FROM shop.users 
WHERE shop.users.id = 1;

DELETE FROM shop.users
WHERE shop.users.id = 1;

COMMIT;

/*SELECT * FROM shop.users 
WHERE shop.users.id = 1;

SELECT * FROM sample.users 
WHERE sample.users.id = 1;*/

-- Задание 2 

USE shop;

CREATE VIEW prod_cat AS
SELECT p.name AS product, c.name AS catalog_name FROM products p
	JOIN catalogs c ON p.id = c.id ;

SELECT * FROM prod_cat;

-- задание 3

SELECT v.days,
	CASE(o.created_at)
		WHEN o.created_at THEN 1
		ELSE 0
	END AS exist_in_table	
FROM 
(SELECT adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) days FROM
 (SELECT 0 t0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
 (SELECT 0 t1 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
 (SELECT 0 t2 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
 (SELECT 0 t3 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
 (SELECT 0 t4 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
LEFT JOIN orders o ON v.days = DATE(o.created_at) 
WHERE v.days BETWEEN '2018-08-01' AND '2018-08-31'
ORDER BY v.days;

-- Задание 4 

CREATE TEMPORARY TABLE temp (user_id INT UNSIGNED, created_at DATETIME, updated_at DATETIME);
INSERT INTO temp 
SELECT user_id, created_at, updated_at FROM orders 
ORDER BY created_at DESC LIMIT 5;

TRUNCATE TABLE orders;

INSERT INTO orders(user_id, created_at, updated_at) 
SELECT * FROM temp
ORDER BY created_at;

SELECT * FROM orders;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Задание 1 -------------------------------------------------------------------------------------------------------------

SET GLOBAL log_bin_trust_function_creators=TRUE;

USE shop;

-- DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello()
    RETURNS VARCHAR(50) NOT DETERMINISTIC
    BEGIN
        SELECT 
			CASE
				WHEN TIME(NOW()) BETWEEN CAST('06:00:00' AS TIME) AND CAST('12:00:00' AS TIME) THEN 'Доброе утро'
				WHEN TIME(NOW()) BETWEEN CAST('12:00:01' AS TIME) AND CAST('18:00:00' AS TIME) THEN 'Добрый день'
				WHEN TIME(NOW()) BETWEEN CAST('18:00:01' AS TIME) AND CAST('00:00:00' AS TIME) THEN 'Добрый вечер'
				WHEN TIME(NOW()) BETWEEN CAST('00:00:01' AS TIME) AND CAST('05:59:59' AS TIME) THEN 'Доброй ночи'
			END 
		INTO @hll;
		RETURN @hll;
    END //

DELIMITER ;

SELECT hello();

-- Задание 2

DROP TRIGGER IF EXISTS before_insert_products;

DELIMITER //

CREATE TRIGGER before_insert_products BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF COALESCE(NEW.name, NEW.description) IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert impossible';	
	END IF;
END//

DELIMITER ;

INSERT INTO products(name, description) 
VALUES ('Name1', 'Description1');
INSERT INTO products(name, description) 
VALUES (NULL, 'Description1');
INSERT INTO products(name, description) 
VALUES ('Name1', NULL);
INSERT INTO products(name, description) 
VALUES (NULL, NULL);

SELECT * FROM products p ;

-- Задание 3

DROP PROCEDURE IF EXISTS fibonacci; 
DELIMITER //

CREATE PROCEDURE fibonacci(IN n INT)
BEGIN
	IF n = 0 THEN
		SELECT 0 AS 'result';
	ELSEIF n = 1 THEN
		SELECT 1 AS 'result';
	ELSEIF n > 1 THEN
		DROP TABLE IF EXISTS t;
		CREATE TEMPORARY TABLE t(func INT UNSIGNED);
		INSERT INTO t VALUES (0), (1);
		SET @i = 2;
		WHILE @i <= n DO
			SELECT SUM(func) FROM (SELECT func FROM t ORDER BY func DESC LIMIT 2) t2 INTO @sum_t;
			INSERT INTO t VALUES (@sum_t);
			SET @i = @i + 1;
		END WHILE;
		SELECT func AS 'result' FROM t ORDER BY func DESC LIMIT 1;
	END IF;
END//

DELIMITER ;

CALL fibonacci(6);







	


