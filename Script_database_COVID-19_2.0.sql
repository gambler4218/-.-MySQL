DROP DATABASE IF EXISTS covid2;

CREATE DATABASE covid2;

USE covid2;


-- 1 Создаем таблицу с неуникальной информацией о пациентах

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
	id SERIAL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50) COMMENT 'Имя',
    lastname VARCHAR(50) COMMENT 'Фамилия',
    birthday DATE,
    
    INDEX (firstname, lastname)
);

-- 2 Уникальные данные пациентов

DROP TABLE IF EXISTS patient_data;
CREATE TABLE patient_data (
	patient_id SERIAL,
	gender VARCHAR(10) COMMENT 'Пол',
	phone BIGINT UNSIGNED UNIQUE,
	hometown VARCHAR(100),
    adress VARCHAR(100) COMMENT 'Улица, номер дома и квартиры',
	pasport BIGINT UNSIGNED UNIQUE COMMENT 'Серия и номер паспорта',
	snils BIGINT UNSIGNED UNIQUE COMMENT 'Номер пенсионного свидетельства',
	med_polis BIGINT UNSIGNED UNIQUE COMMENT 'Номер медицинского полиса',

	FOREIGN KEY (patient_id) REFERENCES patients(id)
);


-- 3 Разновидность мазка

DROP TABLE IF EXISTS var_mazok;
CREATE TABLE var_mazok (
	id SERIAL,
	name_mazok VARCHAR(50) COMMENT 'Экспресс-тест или ПЦР-тест'
);


-- 4 Бригады для забора мазков

DROP TABLE IF EXISTS brigade_mazok;
CREATE TABLE brigade_mazok (
	id SERIAL,
	brigade_doctor VARCHAR(50) COMMENT 'ФИО врача',
	brigade_medsister VARCHAR(50) COMMENT 'ФИО медсестры'
);


-- 5 Номер мазка и результат

DROP TABLE IF EXISTS mazoks;
CREATE TABLE mazoks (
	mazok_id SERIAL AUTO_INCREMENT,
	patient_id BIGINT UNSIGNED NOT NULL,
	var_mazok_id BIGINT UNSIGNED NOT NULL,
	mazok_result VARCHAR(50) COMMENT 'Результат мазка (положительный или отрицательный)',
	mazok_date DATE,
	brigade_id BIGINT UNSIGNED,
	
	FOREIGN KEY (var_mazok_id) REFERENCES var_mazok(id),
	FOREIGN KEY (patient_id) REFERENCES patients(id),
	FOREIGN KEY (brigade_id) REFERENCES brigade_mazok(id)
);


-- 6 Статус пациента болен или здоров

DROP TABLE IF EXISTS condition_patient;
CREATE TABLE condition_patient (
	patient_id BIGINT UNSIGNED NOT NULL,
	name_condition VARCHAR(50) COMMENT 'Пациент болен Covid-19, Здоров',
	
	FOREIGN KEY (patient_id) REFERENCES patients(id)
);


-- 7 Поликлиника по месту жительства

DROP TABLE IF EXISTS polyclinics;
CREATE TABLE polyclinics (
	id SERIAL AUTO_INCREMENT,
	polyclinic_name VARCHAR(100) COMMENT 'Поликлиника по месту прикрепления',
	patient_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- 8 Число контактов заболевших пациентов

DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (
	id SERIAL AUTO_INCREMENT,
	from_patient_id BIGINT UNSIGNED NOT NULL,
    to_patient_id BIGINT UNSIGNED NOT NULL,
    created_at DATE COMMENT 'Дата контакта',
    
    FOREIGN KEY (from_patient_id) REFERENCES patients(id),
    FOREIGN KEY (to_patient_id) REFERENCES patients(id)
);

-- 9 Бригады для забора мазков в моногоспитале

DROP TABLE IF EXISTS brigade_hospital;
CREATE TABLE brigade_hospital (
	id SERIAL,
	brigade_doctor VARCHAR(50) COMMENT 'ФИО врача',
	brigade_medsister VARCHAR(50) COMMENT 'ФИО медсестры'
);

-- 10 Моногоспитали

DROP TABLE IF EXISTS hospitals;
CREATE TABLE hospitals (
	id SERIAL AUTO_INCREMENT,
	name_hospital VARCHAR(100) COMMENT 'Название моногоспиталя',
	patient_id BIGINT UNSIGNED NOT NULL,
	hospital_date DATE COMMENT 'Дата госпитализации',
	mazok_hospital BIGINT UNSIGNED,
	brigade_id BIGINT UNSIGNED,
	
	FOREIGN KEY (patient_id) REFERENCES patients(id),
		
	FOREIGN KEY (mazok_hospital) REFERENCES mazoks(mazok_id),
		
	FOREIGN KEY (brigade_id) REFERENCES brigade_hospital(id)
	
);


	
	
	
	
	
	
	
	
	
	
	