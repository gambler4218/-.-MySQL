DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED PRIMARY KEY,
  name VARCHAR (255) COMMENT 'Имя пользователя'
);

CREATE DATABASE sample

# Далее нужно создать дамп

#mysqldump example > example.sql
#mysql sample < example.sql