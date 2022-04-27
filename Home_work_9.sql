-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
-- Используйте транзакции.

SELECT * FROM shop.users;
SELECT * FROM sample.users;

TRUNCATE sample.users;

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;

-- 2. Создайте представление, которое выводит название name 
-- товарной позиции из таблицы products и соответствующее 
-- название каталога name из таблицы catalogs.

CREATE VIEW table_p_c (name_p, name_c) AS 
SELECT p.name, c.name 
FROM products p JOIN catalogs c ON p.catalog_id = c.id;

SELECT * FROM table_p_c;


-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
-- возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
-- фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

CREATE FUNCTION hello ()
RETURNS TINYTEXT DETERMINISTIC
BEGIN 
	DECLARE time_now INT;
	SET time_now = HOUR(NOW());
	CASE
		WHEN time_now BETWEEN 6 AND 11 THEN RETURN 'Доброе утро';
		WHEN time_now BETWEEN 12 AND 17 THEN RETURN 'Добрый день';
		WHEN time_now BETWEEN 18 AND 23 THEN RETURN 'Добрый вечер';
		WHEN time_now BETWEEN 0 AND 5 THEN RETURN 'Доброй ночи';
	END CASE;
END;

SELECT hello ();


-- 2. В таблице products есть два текстовых поля: 
-- name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей 
-- или оба поля были заполнены. При попытке присвоить 
-- полям NULL-значение необходимо отменить операцию.

CREATE TRIGGER null_trigger BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка ввода';
	END IF;
END;














