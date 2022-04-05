/* В первом задании при помощи сервиса генерации данных добавил записи в таблицы базы данных vk;
 * Во втором задании сделал выборку из таблицы users
 */
SELECT DISTINCT firstname
FROM users u 
ORDER BY 1;


-- Задание 3
ALTER TABLE profiles
ADD is_active VARCHAR(10) DEFAULT 'true';
UPDATE profiles 
SET is_active = 'false'
WHERE YEAR (NOW()) - YEAR (birthday) < 18;


-- Задание 4
DELETE FROM messages 
WHERE created_at > NOW(); 


