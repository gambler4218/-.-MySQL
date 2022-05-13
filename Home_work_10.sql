-- Создайте таблицу logs типа Archive. 
-- Пусть при каждом создании записи в таблицах users, catalogs и products 
-- в таблицу logs помещается время и дата создания записи, название таблицы, 
-- идентификатор первичного ключа и содержимое поля name.


DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	name_tbl VARCHAR(50) NOT NULL,
	str_id BIGINT NOT NULL,
	value_name VARCHAR(50) NOT NULL
) ENGINE = Archive;


SELECT * FROM users;

CREATE TRIGGER ins_users AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (created_at, name_tbl, str_id, value_name)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END;

SELECT * FROM catalogs;

CREATE TRIGGER ins_catalogs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (created_at, name_tbl, str_id, value_name)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END;


SELECT * FROM products;

CREATE TRIGGER ins_products AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (created_at, name_tbl, str_id, value_name)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END;

INSERT INTO users (id, name, birthday_at)
VALUES
	('7', 'Семён', '1994-03-15');

INSERT INTO catalogs (id, name)
VALUES
	('6', 'ЧИП');


INSERT INTO products (id, name, description, price, catalog_id)
VALUES
	('8', 'Байкал-1', 'ЧИП', '1', '6');


SELECT * FROM logs;




