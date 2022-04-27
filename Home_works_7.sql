-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT * FROM users;

SELECT * FROM orders;

INSERT INTO orders (user_id)
VALUES 
	(3),
	(2),
	(6);
	
SELECT o.user_id, u.name, u.birthday_at FROM orders AS o JOIN users AS u
ON u.id = o.user_id;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT * FROM products;

SELECT * FROM catalogs;

SELECT products.name AS 'Наименование товара', catalogs.name AS 'Категория' FROM products JOIN catalogs
WHERE (products.description LIKE 'Процесс%') AND (catalogs.name LIKE 'Процесс%')

UNION

SELECT products.name AS 'Наименование товара', catalogs.name AS 'Категория' FROM products JOIN catalogs
WHERE (products.description LIKE 'Материнс%') AND (catalogs.name LIKE 'Материнск%');

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

CREATE TABLE flights (
	id SERIAL AUTO_INCREMENT PRIMARY KEY,
	`from` VARCHAR(50) NOT NULL,
	`to` VARCHAR(50) NOT NULL
);

INSERT INTO flights (id, `from`, `to`)
	VALUES
		(1, 'moscow', 'omsk'),
		(2, 'novgorod', 'kazan'),
		(3, 'irkutsk', 'moscow'),
		(4, 'omsk', 'irkutsk'),
		(5, 'moscow', 'kazan');

SELECT * FROM flights;
SELECT * FROM cities;

CREATE TABLE cities (
	label VARCHAR(50) NOT NULL,
	name VARCHAR(50) NOT NULL
);

INSERT INTO cities (label, name)
	VALUES
		('moscow', 'Москва'),
		('irkutsk', 'Иркутск'),
		('novgorod', 'Новгород'),
		('kazan', 'Казань'),
		('omsk', 'Омск');

SELECT flights.id AS id, (SELECT name FROM cities WHERE label = flights.`from`) AS `from`,
(SELECT name FROM cities WHERE label = flights.`to`) AS `to` FROM flights;

SELECT flights.id AS id, c.name AS `from`, ci.name AS `to`
FROM flights 
JOIN cities AS c ON c.label = flights.`from` 
JOIN cities AS ci ON ci.label = flights.`to`
ORDER BY flights.id;



