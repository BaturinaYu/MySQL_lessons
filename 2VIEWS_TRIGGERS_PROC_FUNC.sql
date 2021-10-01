USE db_questioning;

-- Представление setting_title выводит ответы на вопросы каждого респондента с указанием пола и возрастной группы

CREATE OR REPLACE VIEW setting_title(title_id, question, answer, gender, age) 
AS
SELECT t.id, q2.`text` AS question, a2.`text`  AS answer , t.gender, a.age FROM title t
JOIN age a 
	ON t.age_id = a.id 
JOIN questionnaires q 
	ON t.id = q.title_id 
JOIN questions q2 
	ON q.q_number = q2.q_number 
JOIN answers a2 
	ON q.a_number = a2.a_number ;

-- Представление setting_another_answers выводит собственные ответы респондентов с указанием номера анкеты и номера вопроса

CREATE OR REPLACE VIEW setting_another_answers(title_id, n_question, question, answer, gender, age, profession) 
AS	
SELECT t.id, q.q_number , q.`text` , aa.`text` , t.gender , a.age , p.name FROM another_answers aa 
JOIN questions q 
	ON aa.q_number = q.q_number 
JOIN title t 
	ON aa.title_id = t.id 
JOIN age a 
	ON t.age_id = a.id 
JOIN professions p 
	ON t.profession_id = p.id ;

-- Представление questions_list это отсортированный список вопросов с предложенными ответами

CREATE OR REPLACE VIEW questions_list(`number`, question, answers)
AS
SELECT q.q_number , q.`text` AS question , a.`text` AS answers FROM questions_answers qa 
JOIN questions q 
	ON qa.q_number = q.q_number
JOIN answers a 
	ON qa.a_number = a.a_number;

-- Представление setting_attitude выводит информацию о том, сколько респондентов выбрали 
-- тот или иной вариант ответа по каждому вопросу. Записи таблицы сгруппированы 
-- по отношению респондента к опросу.

CREATE OR REPLACE VIEW setting_attitude(question_number, question, answer, count_respondents, attitude)
AS 
SELECT q2.q_number , q2.`text` , a.`text`, COUNT(*) AS count_respondents, a2.attitude FROM title t 
JOIN attitude a2 
	ON t.attitude_id = a2.id 
JOIN questionnaires q 
	ON t.id = q.title_id 
JOIN questions q2 
	ON q.q_number = q2.q_number 
JOIN answers a 
	ON q.a_number = a.a_number
GROUP BY a2.id, q.q_number , q.a_number 
ORDER BY a2.id, q.q_number , q.a_number ;

-- Триггер add_update_log действует после изменений, внесённых в поля таблицы questionnaires
-- с номерами вопросов и ответов. Если значение любого из этих полей изменено, 
-- вносится соответствующая запись в таблицу add_update_log, 
-- а также обновляется значение поля updated_at таблицы title на текущее значение даты-времени.

DROP TRIGGER IF EXISTS add_update_log;
DELIMITER //

CREATE TRIGGER add_update_log AFTER UPDATE ON questionnaires
FOR EACH ROW
BEGIN
	SET @f = 0;
	IF NEW.q_number <> OLD.q_number THEN 
		INSERT INTO update_logs(table_name, field_name, old_value, new_value, updated_at)
		VALUES ('questionnaires', 'q_number', OLD.q_number, NEW.q_number, CURRENT_TIMESTAMP);
		SET @f = 1;
	END IF;
	IF NEW.a_number <> OLD.a_number THEN 
		INSERT INTO update_logs(table_name, field_name, old_value, new_value, updated_at)
		VALUES ('questionnaires', 'a_number', OLD.a_number, NEW.a_number, CURRENT_TIMESTAMP);
		SET @f = 1;
	END IF;
	IF @f = 1 THEN
		UPDATE title SET updated_at=CURRENT_TIMESTAMP
		WHERE id = OLD.title_id;
	END IF;
END//

DELIMITER ;

-- Триггер update_title_id_error выводит сообщение об ошибке при попытке
-- изменить идентификатор анкеты в таблице title

DROP TRIGGER IF EXISTS update_title_id_error;
DELIMITER //

CREATE TRIGGER update_title_id_error BEFORE UPDATE ON questionnaires
FOR EACH ROW
BEGIN
	IF NEW.title_id <> OLD.title_id THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
	END IF;
END//

DELIMITER ;

-- Функция percent служит для расчёта доли каждого варианта ответа на вопрос
-- от общего количества ответов в процентах

DROP FUNCTION IF EXISTS percent;

DELIMITER //
CREATE  FUNCTION percent(value1 INT, value2 INT) RETURNS FLOAT DETERMINISTIC
BEGIN 
	IF value2 <> 0 THEN
		RETURN value1/ value2 * 100;
	ELSE
		RETURN 0;
	END IF;
END//

DELIMITER ;

-- Процедура survey_results выводит отчёт с результатами анкетирования:
-- количеством ответов по каждому вопросу с разбивкой по вариантам ответа 
-- и указанием доли каждого варианта в массе ответов в процентах

DROP PROCEDURE IF EXISTS survey_results;
DELIMITER //
CREATE PROCEDURE survey_results(IN dist_num TINYINT)
BEGIN
	DECLARE all_a, cnt_a, qn INT;
 	DECLARE done, i INT;
	DECLARE txt VARCHAR(300);
	
	DROP TABLE IF EXISTS ex;
	CREATE TEMPORARY TABLE ex(id BIGINT, q_number INT, a_number INT);
    
	IF dist_num <> 0 THEN
		INSERT INTO ex
		SELECT q.title_id, q.q_number, q.a_number FROM title t
		JOIN interviewers i ON t.interviewer_id = i.id 
		JOIN questionnaires q ON t.id = q.title_id 
		WHERE i.district_id = dist_num;
	ELSE
		INSERT INTO ex
		SELECT q.title_id, q.q_number, q.a_number FROM questionnaires q;
	END IF;
	
	DROP TABLE IF EXISTS export;
	CREATE TEMPORARY TABLE export(txt VARCHAR(300), total INT, all_ans INT);

	SELECT COUNT(*) FROM questions INTO done;
	SET i := 0;
	WHILE i <= done DO
		SELECT q.q_number , q.`text` 
		FROM questions q
		ORDER BY q.q_number LIMIT i, 1 
		INTO qn, txt;
		INSERT INTO export(txt) VALUES (txt);
	
		SELECT COUNT(*) FROM
			(SELECT DISTINCT title_id FROM questionnaires q 
			JOIN ex ON ex.id = q.title_id 
			WHERE q.q_number = qn) t INTO all_a;
		
		IF all_a <> 0 THEN
			INSERT INTO export
			SELECT a.`text` , SUM(
			CASE 
				WHEN ex.id IS NULL THEN 0
				ELSE 1 END) AS cnt, all_a
			FROM questions_answers qa 
			LEFT JOIN ex ON qa.q_number = ex.q_number AND qa.a_number = ex.a_number
			JOIN answers a ON qa.a_number = a.a_number 
			WHERE qa.q_number = qn 
			GROUP BY qa.q_number, qa.a_number;
		END IF;
		SET i := i+1;
	END WHILE;	

	SELECT e.txt, e.total, IF(e.all_ans IS NULL, e.all_ans, ROUND(percent(e.total, e.all_ans), 2)) AS percent 
	FROM export e;

	DROP TABLE ex;
	DROP TABLE export;
END; //

DELIMITER ;

-- Типичные выборки БД db_questioning ---------------------------------------------------------------------------------------

-- Вывести список анкет респондентов, не давших ответ на некоторые вопросы,
-- указав номера этих вопросов

SELECT DISTINCT t.id AS anket_id, qa.q_number AS question_number 
FROM title t 
JOIN questions_answers qa
LEFT JOIN questionnaires q 
	ON qa.q_number = q.q_number AND q.title_id = t.id 
WHERE q.q_number IS NULL
ORDER BY t.id, qa.q_number ;

-- Вывести те анкеты из вышеотобранных, которые имеют ответы в таблице another_answers,
-- в которую записываются ответы респондентов "от себя". Указать какие из них предусматривают
-- самостоятельный ответ в рамках анкетирования (флаг another_answer в таблице вопросов questions в потожении '1').

SELECT DISTINCT t.id AS anket_id, qa.q_number AS question_number, aa.`text` AS answer, q2.another_answer AS another_check 
FROM title t 
JOIN questions_answers qa
JOIN questions q2 
	ON qa.q_number = q2.q_number 
LEFT JOIN questionnaires q 
	ON qa.q_number = q.q_number AND q.title_id = t.id 
JOIN another_answers aa 
	ON qa.q_number = aa.q_number AND t.id = aa.title_id 
WHERE q.q_number IS NULL
ORDER BY t.id, qa.q_number ;

-- Вывести самые популярные ответы по каждому из вопросов, с учётом уровня доброжелательности респондентов

SELECT question_number, question, answer, MAX(count_respondents) AS maximum
FROM setting_attitude
WHERE attitude = 'Положительное'
GROUP BY question;









 