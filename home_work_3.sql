DROP TABLE IF EXISTS black list;
CREATE TABLE black list(
	user_id BIGINT UNSIGNED NOT NULL,
	firstname VARCHAR (50),
	lastname VARCHAR (50),
	
	FOREIGN KEY (user_id) REFERENCES users(id),
);

DROP TABLE IF EXISTS music;
CREATE TABLE music(
	id SERIAL,
	music_author VARCHAR (50) NOT NULL,
	music_title VARCHAR (50) NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (media_id) REFERENCES media(id),
);

DROP TABLE IF EXISTS users_adress;
CREATE TABLE users_adress(
	user_id BIGINT UNSIGNED NOT NULL,
	country VARCHAR (50) NOT NULL,
	region VARCHAR (50) NOT NULL,
	city VARCHAR (50) NOT NULL,
	street VARCHAR (50) NOT NULL,
	number_house VARCHAR (50) INT UNSIGNED NOT NULL,
	number_flat VARCHAR (50) INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
);