DROP DATABASE IF EXISTS covid;

CREATE DATABASE covid;

USE covid;

-- 1 Создаем таблицу с неуникальной информацией о пациентах

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
	id SERIAL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(50) COMMENT 'Имя',
    lastname VARCHAR(50) COMMENT 'Фамилия',
    birthday DATE,
    
    INDEX (firstname, lastname)
);

-- 2 Уникальные данные пациентов patient_id, gender, phone, hometown, adress, pasport, snils, med_polis, polyclinic_id 

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
	polyclinic_id BIGINT UNSIGNED COMMENT 'Поликлиника по месту прикрепления',
	
	
	FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- 6 Разновидность мазка

DROP TABLE IF EXISTS var_mazok;
CREATE TABLE var_mazok (
	var_mazok_id SERIAL,
	name_mazok VARCHAR(50) COMMENT 'Экспресс-тест или ПЦР-тест'
);

-- 7 Число контактов заболевших пациентов

DROP TABLE IF EXISTS contacts;
CREATE TABLE contacts (
	id SERIAL,
	from_patient_id BIGINT UNSIGNED NOT NULL,
    to_patient_id BIGINT UNSIGNED NOT NULL,
    created_at DATE COMMENT 'Дата контакта',
    
    FOREIGN KEY (from_patient_id) REFERENCES patients(id),
    FOREIGN KEY (to_patient_id) REFERENCES patients(id)
);

-- 8 Бригады для забора мазков в поликлинике

DROP TABLE IF EXISTS brigade_polyclinic;
CREATE TABLE brigade_polyclinic (
	brigade_id SERIAL,
	brigade_doctor VARCHAR(50) COMMENT 'ФИО врача',
	brigade_medsister VARCHAR(50) COMMENT 'ФИО медсестры'
);

-- 9 Бригады для забора мазков в моногоспитале

DROP TABLE IF EXISTS brigade_hospital;
CREATE TABLE brigade_hospital (
	brigade_id SERIAL,
	brigade_doctor VARCHAR(50) COMMENT 'ФИО врача',
	brigade_medsister VARCHAR(50) COMMENT 'ФИО медсестры'
);

-- 10 Статус пациента

DROP TABLE IF EXISTS condition_patient;
CREATE TABLE condition_patient (
	id SERIAL,
	name_condition VARCHAR(50) COMMENT 'Пациент болен ОРВИ, Covid-19, Здоров'
);

-- 5 Номер мазка и результат

DROP TABLE IF EXISTS mazoks;
CREATE TABLE mazoks (
	mazok_number SERIAL AUTO_INCREMENT,
	patient_id BIGINT UNSIGNED NOT NULL,
	variant_mazok_id BIGINT UNSIGNED NOT NULL,
	mazok_result VARCHAR(50) COMMENT 'Результат мазка',
	mazok_date DATE,
	
	FOREIGN KEY (variant_mazok_id) REFERENCES var_mazok(var_mazok_id),
	FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- 3 Поликлиника по месту жительства

DROP TABLE IF EXISTS polyclinics;
CREATE TABLE polyclinics (
	id BIGINT UNSIGNED NOT NULL,
	polyclinic_name VARCHAR(100) COMMENT 'Поликлиника по месту прикрепления',
	polyclinic_patient_id BIGINT UNSIGNED,
	patient_condition BIGINT UNSIGNED,
	mazok_polyclinic BIGINT UNSIGNED,
	brigade_number BIGINT UNSIGNED,
	
	
	FOREIGN KEY (polyclinic_patient_id) REFERENCES patients(id),
		
	FOREIGN KEY (mazok_polyclinic) REFERENCES mazoks(mazok_number),
		
	FOREIGN KEY (brigade_number) REFERENCES brigade_polyclinic(brigade_id),
	FOREIGN KEY (patient_condition) REFERENCES condition_patient(id)
);

/* Хочу добавить внешний ключ чтобы связать patient_data и polyclinics, 
 * но polyclinics(id) не может иметь вид SERIAL, 
 * так как к одной поликлинике могут быть прикреплены несколько пациентов

ALTER TABLE covid.patient_data 
ADD CONSTRAINT patient_data_fk 
FOREIGN KEY (policlinic_id) REFERENCES covid.polyclinics(id);
 */

ALTER TABLE covid.polyclinics 
ADD 
FOREIGN KEY (polyclinic_patient_id) REFERENCES covid.patient_data(patient_id);

-- 4 Моногоспитали

DROP TABLE IF EXISTS hospitals;
CREATE TABLE hospitals (
	id BIGINT UNSIGNED NOT NULL,
	hospital_covid VARCHAR(100) COMMENT 'Название моногоспиталя',
	patient_covid_id BIGINT UNSIGNED,
	patient_condition BIGINT UNSIGNED,
	hospital_date DATE COMMENT 'Дата госпитализации',
	mazok_hospital BIGINT UNSIGNED,
	brigade_number BIGINT UNSIGNED,
	
	FOREIGN KEY (patient_covid_id) REFERENCES patients(id),
		
	FOREIGN KEY (mazok_hospital) REFERENCES mazoks(mazok_number),
		
	FOREIGN KEY (brigade_number) REFERENCES brigade_hospital(brigade_id),
	FOREIGN KEY (patient_condition) REFERENCES condition_patient(id)
);


SELECT * FROM patients p;
SELECT * FROM patient_data pd;
SELECT * FROM var_mazok vm;
SELECT * FROM contacts;
SELECT * FROM mazoks;
SELECT * FROM brigade_polyclinic;
SELECT * FROM brigade_hospital;
SELECT * FROM condition_patient;
SELECT * FROM polyclinics p;
SELECT * FROM hospitals;







