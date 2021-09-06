-- Задание 1

SELECT name FROM users
WHERE EXISTS (SELECT 1 FROM orders WHERE user_id = users.id);

-- Задание 2

SELECT p.id, p.name, c.name FROM products p 
LEFT JOIN catalogs c ON p.catalog_id = c.id ;

-- Задание 3

USE flights;

CREATE TABLE flights(
	id SERIAL PRIMARY KEY,
	from_ VARCHAR(50),
	to_ VARCHAR(50)
);

INSERT flights(from_, to_) VALUES
('moskow', 'omsk'), ('novgorod', 'kazan'),
('irkutsk', 'moskow'), ('omsk', 'irkutsk'),
('moskow', 'kazan');

CREATE TABLE cities(
	label VARCHAR(50) PRIMARY KEY,
	name VARCHAR(50)
);

INSERT cities
VALUES ('moskow', 'Москва'), ('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'), ('kazan', 'Казань'), ('omsk', 'Омск');

SELECT f.id, c.name, c2.name FROM flights f, cities c, cities c2
WHERE f.from_ = c.label AND f.to_ = c2.label;

