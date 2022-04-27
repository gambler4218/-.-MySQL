-- 1. Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT * FROM messages;


SELECT from_user_id, COUNT(*) AS total, 
(SELECT firstname FROM users WHERE id = from_user_id) AS fistnane,
(SELECT lastname FROM users WHERE id = from_user_id) AS lastname,
(SELECT birthday FROM profiles WHERE user_id = from_user_id) AS birthday,
(SELECT hometown FROM profiles WHERE user_id = from_user_id) AS hometown
FROM messages
WHERE to_user_id = 155 AND from_user_id != 155
GROUP BY from_user_id
ORDER BY total DESC LIMIT 1;


-- 2. Подсчитать общее количество лайков, 
-- которые получили пользователи младше 10 лет.


SELECT COUNT(*) AS 'likes' FROM likes 
WHERE user_id IN (SELECT user_id FROM profiles
WHERE (DATEDIFF(NOW(), birthday) / 365.25) < 10);  


-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT user_id FROM profiles
WHERE gender = 'f';

SELECT user_id, gender FROM profiles
WHERE gender = 'm';

SELECT COUNT(*) AS 'likes_f', (SELECT gender FROM profiles WHERE user_id IN (SELECT user_id FROM profiles
WHERE gender = 'f') LIMIT 1) AS gender FROM likes
WHERE user_id IN (SELECT user_id FROM profiles
WHERE gender = 'f')

UNION

SELECT COUNT(*) AS 'likes_f', (SELECT gender FROM profiles WHERE user_id IN (SELECT user_id FROM profiles
WHERE gender = 'm')LIMIT 1) AS gender FROM likes
WHERE user_id IN (SELECT user_id FROM profiles
WHERE gender = 'm');



		
