-- 1. Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT * FROM messages;


SELECT m.from_user_id AS from_user_id, COUNT(*) AS total, 
u.firstname AS firstname, u.lastname AS lastname,
p.birthday AS birthday, p.hometown AS hometown
FROM messages m
JOIN users u ON u.id = m.from_user_id
JOIN profiles p ON p.user_id = m.from_user_id
WHERE m.to_user_id = 155 AND m.from_user_id != 155
GROUP BY m.from_user_id
ORDER BY total DESC LIMIT 1;


-- 2. Подсчитать общее количество лайков, 
-- которые получили пользователи младше 10 лет.


SELECT COUNT(*) AS 'likes'
FROM likes l 
JOIN profiles p
WHERE (DATEDIFF(NOW(), birthday) / 365.25) < 10 AND l.user_id = p.user_id;



-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT * FROM profiles;

SELECT user_id FROM profiles
WHERE gender = 'f';

SELECT user_id, gender FROM profiles
WHERE gender = 'm';



SELECT COUNT(*) AS 'likes', p.gender AS gender
FROM likes l 
JOIN profiles p 
WHERE l.user_id = p.user_id AND p.gender = 'f'

UNION 

SELECT COUNT(*) AS 'likes', p.gender AS gender
FROM likes l 
JOIN profiles p 
WHERE l.user_id = p.user_id AND p.gender = 'm';




		
