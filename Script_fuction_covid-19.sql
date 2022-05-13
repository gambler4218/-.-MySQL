-- База данных ковид-19 выполняет такие операции как регистрация пациентов, 
-- заполнение данных по мазкам, подсчет заболевших, 
-- определение численности заболевших по населенным пунктам и многое другое.
SELECT * FROM patients;

SELECT * FROM patient_data;

SELECT * FROM var_mazok;

SELECT * FROM mazoks;

SELECT * FROM brigade_mazok;

SELECT * FROM brigade_hospital;

SELECT * FROM condition_patient;

SELECT * FROM polyclinics;

SELECT * FROM hospitals;

SELECT * FROM contacts;	

-- Можем получить подробную информацию по любому пациенту


SELECT firstname, lastname, (SELECT gender FROM patient_data WHERE patient_id = 3) AS gender, 
(SELECT hometown FROM patient_data WHERE patient_id = 3) AS hometown, 
(SELECT adress FROM patient_data WHERE patient_id = 3) AS adress, 
(SELECT mazok_id FROM mazoks WHERE patient_id = 3) AS mazok_id, 
(SELECT mazok_result FROM mazoks WHERE patient_id = 3) AS mazok_result, 
(SELECT mazok_date FROM mazoks WHERE patient_id = 3) AS mazok_date, 
(SELECT polyclinic_name FROM polyclinics WHERE patient_id = 3) AS polyclinic_name 
FROM patients WHERE id = 3;


SELECT p.firstname, p.lastname, pd.gender, pd.hometown, pd.adress, m.mazok_id, m.mazok_result,
m.mazok_date, p2.polyclinic_name 
FROM patients p
JOIN patient_data pd ON p.id = pd.patient_id 
JOIN mazoks m ON p.id = m.patient_id 
JOIN polyclinics p2 ON p.id = p2.patient_id 
WHERE p.id = 9;

-- Отсортировать пациентов по полу

SELECT gender, COUNT(*) AS total
FROM patient_data pd 
GROUP BY gender;

-- Сортировка пациентов по месту прикрепления к медицинской организации

SELECT polyclinic_name, COUNT(*) AS total
FROM polyclinics
GROUP BY polyclinic_name;

-- Количество и разновидность мазков

SELECT vm.name_mazok, m.mazok_result, COUNT(*) AS total
FROM mazoks m
JOIN var_mazok vm ON vm.id = m.var_mazok_id 
GROUP BY m.mazok_result, vm.name_mazok;


-- Список заболевших COVID-19

CREATE VIEW plus_mazok (patient_id, id_mazok, result_mazok, date_mazok)
AS SELECT patient_id, mazok_id, mazok_result, mazok_date 
FROM mazoks WHERE mazok_result LIKE 'положител%';

SELECT * FROM plus_mazok;

-- Подробный список заболевших

CREATE VIEW patient_covid (id, firstname, lastname, birthday, 
phometown, adress, name_condition)
AS SELECT p.id, p.firstname, p.lastname, p.birthday, 
pd.hometown, pd.adress, cp.name_condition
FROM patients p JOIN patient_data pd ON p.id = pd.patient_id 
JOIN condition_patient cp ON p.id = cp.patient_id 
WHERE cp.name_condition LIKE 'болен%'
ORDER BY p.id;

-- Триггер срабатывает, когда в таблицу мазков попадает информация 
-- о том что у пациента положительный мазок и его требуется госпитализировать

CREATE TRIGGER gospital_patient AFTER INSERT ON mazoks
FOR EACH ROW  
BEGIN 
	IF (NEW.mazok_result = 'положительный') THEN
		INSERT INTO hospitals (patient_id, hospital_date)
		VALUES (NEW.patient_id, DATE_FORMAT(NOW(), '%y-%m-%d'));
	END IF;
END;



