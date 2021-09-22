-- Практическое задание по теме “Оптимизация запросов”
-- Задание 1

USE shop;

-- создаём таблицу типа Archive

CREATE TABLE logs(
	id SERIAL NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	table_name VARCHAR(50) NOT NULL,
	record_id BIGINT UNSIGNED NOT NULL,
	record_name VARCHAR(255)
) ENGINE=Archive;

-- создаём триггер на вставку в таблицу logs, после добавления новой записи в users

DELIMITER //

CREATE TRIGGER users_into_archive
AFTER INSERT
	ON users FOR EACH ROW
BEGIN 
	INSERT INTO logs(table_name, record_id, record_name)
	VALUES ('users', NEW.id, NEW.name);
END//

DELIMITER ;

INSERT INTO users(name, birthday_at)
VALUES ('Алевтина Иванова', '1987-03-20');

-- создаём триггер на вставку в таблицу logs, после добавления новой записи в products

DELIMITER //

CREATE TRIGGER products_into_archive
AFTER INSERT
	ON products FOR EACH ROW
BEGIN 
	INSERT INTO logs(table_name, record_id, record_name)
	VALUES ('products', NEW.id, NEW.name);
END//

DELIMITER ;

INSERT INTO products(name, description, price, catalog_id)
VALUES ('Наименование продукта', 'Описание', 3000.50, 1);

-- создаём триггер на вставку в таблицу logs, после добавления новой записи в catalogs

DELIMITER //

CREATE TRIGGER catalogs_into_archive
AFTER INSERT
	ON catalogs FOR EACH ROW
BEGIN 
	INSERT INTO logs(table_name, record_id, record_name)
	VALUES ('catalogs', NEW.id, NEW.name);
END//

DELIMITER ;

INSERT INTO catalogs(name)
VALUES ('Наименование в каталоге');

-- проверяем содержимое таблицы logs

SELECT * FROM logs;