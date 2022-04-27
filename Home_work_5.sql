-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
SELECT * FROM users;
UPDATE users 
	SET created_at = NOW(), updated_at = NOW();

-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

ALTER TABLE users 
	MODIFY COLUMN created_at DATETIME, 
	MODIFY COLUMN updated_at DATETIME;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

INSERT INTO storehouses_products (storegouse_id, product_id, value)
VALUES
	(2, 5, 7),
	(3, 4, 9),
	(4, 1, 0),
	(5, 3, 20),
	(6, 7, 40),
	(7, 2, 0),
	(8, 6, 35);
	
SELECT * FROM storehouses_products;

SELECT value FROM storehouses_products;

SELECT value FROM storehouses_products 
-- ORDER BY IF(value = 0, 1, 0), value;
ORDER BY CASE WHEN value = 0 THEN 1 ELSE 0 END, value;

-- Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT name, birthday_at FROM users;

SELECT name,
	CASE 
		WHEN MONTH(birthday_at) = 5 THEN 'may'
		WHEN MONTH(birthday_at) = 8 THEN 'august'
	END AS month_birthday_at FROM users
	WHERE MONTH(birthday_at) = 5 OR MONTH(birthday_at) = 8;

-- Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs
WHERE id IN (5, 1, 2);

SELECT * FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY CASE
	WHEN id = 5 THEN 0
	WHEN id = 1 THEN 1
	WHEN id = 2 THEN 2
END;


-- Агрегация данных
-- Подсчитайте средний возраст пользователей в таблице users
SELECT name, birthday_at FROM users;

SELECT
	ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 2) AS age
FROM users;



-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT COUNT(name) AS number_birthday,
	DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_birthday
FROM users GROUP BY week_day_birthday ORDER BY number_birthday;



-- Подсчитайте произведение чисел в столбце таблицы

CREATE TABLE tbl (
	value INT UNSIGNED
);

INSERT INTO tbl 
	VALUES (1), (2), (3), (4), (5);

SELECT * FROM tbl;

SELECT ROUND(EXP(SUM(LN(value))), 0) AS total FROM tbl; 


