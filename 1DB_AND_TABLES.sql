-- Тема курсовой: "Исследование общественного мнения в регионе на основе анкетных данных"
-- БД `db_questioning` предназначена для обработки данных анкетирования 
-- по вопросам общей удовлетворённости жизнью в регионе.
-- Данный файл содержит описание таблиц и их полей.
-- В файле 2VIEWS_TRIGGERS_PROC_FUNC.sql описаны характерные выборки для БД,
-- хранимая процедура survey_results,
-- функция percent,
-- триггеры и представления.
-- Отдельно прилагается дамп БД `db_questioning`.

DROP DATABASE IF EXISTS db_questioning;
CREATE DATABASE db_questioning;

USE db_questioning;

-- Таблица `questions` содержит список вопросов анкетирования  

DROP TABLE IF EXISTS questions;
CREATE TABLE questions(
	q_number INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- номер вопроса
	text VARCHAR(300) NOT NULL,									-- текст вопроса
	radio ENUM('0', '1') NOT NULL DEFAULT '1',					-- '1' если на вопрос предусмотрен только один ответ
	another_answer ENUM('0', '1') NOT NULL DEFAULT '0'			-- флаг наличия ответа "от себя"
);

-- Таблица `answers` содержит ответы к вопросам из таблицы `questions`

DROP TABLE IF EXISTS answers;
CREATE TABLE answers(
	a_number INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- номер ответа
	text VARCHAR(300) NOT NULL									-- текст ответа
);

-- Таблица `questions_answers` содержит пары допустимых соответствий вопрос-ответ

DROP TABLE IF EXISTS questions_answers;
CREATE TABLE questions_answers(
	q_number INT UNSIGNED NOT NULL,								-- номер вопроса
	a_number INT UNSIGNED NOT NULL,								-- номер ответа
	PRIMARY KEY (q_number, a_number),
	KEY key_q_number(q_number),
	KEY key_a_number(a_number),
	CONSTRAINT fk_questions_answers_questions FOREIGN KEY (q_number) REFERENCES questions(q_number),
	CONSTRAINT fk_questions_answers_answers FOREIGN KEY (a_number) REFERENCES answers(a_number)
);

-- Таблица `districts` районов исследования 

DROP TABLE IF EXISTS districts;
CREATE TABLE districts(
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,					-- номер района исследования
	name VARCHAR(50) NOT NULL									-- наименование
);

-- Таблица `age` - справочник возрастных групп 

DROP TABLE IF EXISTS age;
CREATE TABLE age(
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- номер возрастной группы
	age VARCHAR(50) NOT NULL									-- расшифровка
);

-- Таблица `attitude` - справочник оценки отношения респондента к исследованию 

DROP TABLE IF EXISTS attitude;
CREATE TABLE attitude(
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,	-- код отношения к исследованию
	attitude VARCHAR(50) NOT NULL								-- расшифровка
);

-- Таблица `professions` - справочник профессий

DROP TABLE IF EXISTS professions;
CREATE TABLE professions(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,		-- код профессии
	name VARCHAR(100) NOT NULL									-- наименование
);

-- Таблица `interviewers` содержит список интервьюеров

DROP TABLE IF EXISTS interviewers;
CREATE TABLE interviewers(
	id SERIAL PRIMARY KEY,										-- код интервьюера
	first_name VARCHAR(50) NOT NULL,							-- имя
	last_name VARCHAR(50) NOT NULL,								-- фамилия
	birthday DATE NOT NULL,										-- дата рождения
	district_id TINYINT UNSIGNED NOT NULL,						-- район прикрепления
	area TINYINT UNSIGNED NOT NULL,								-- подотчётный участок 							
	phone CHAR(11) NOT NULL,									-- телефон
	KEY key_district_id(district_id),
	FOREIGN KEY fk_district_id(district_id) REFERENCES districts(id)
);

-- Таблица `title` содержит информацию о респонденте (пол, возрастная группа, профессия и т.д.)

DROP TABLE IF EXISTS title;
CREATE TABLE title(
	id SERIAL PRIMARY KEY,										-- номер анкеты
	gender ENUM('Ж', 'M', 'Х') NOT NULL,						-- пол респондента
	age_id TINYINT UNSIGNED NOT NULL,							-- возрастная группа
	profession_id INT UNSIGNED NOT NULL,						-- код профессии
	attitude_id TINYINT UNSIGNED NOT NULL,						-- отношение к исследованию
	interviewer_id BIGINT UNSIGNED NOT NULL,					-- номер интервьюера
	phone CHAR(11) NOT NULL,									-- телефон респондента для уточняющих вопросов
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,		-- дата ввода анкеты
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP, -- дата обновления данных
	KEY key_title_interviewer_id(interviewer_id),
	KEY key_title_age_id(age_id),
	FOREIGN KEY fk_profession_id(profession_id) REFERENCES professions(id),
	CONSTRAINT fk_title_age_id FOREIGN KEY (age_id) REFERENCES age(id),
	CONSTRAINT fk_title_attitude_id FOREIGN KEY (attitude_id) REFERENCES attitude(id),
	CONSTRAINT fk_title_interviewer_id FOREIGN KEY (interviewer_id) REFERENCES interviewers(id)
);

-- Таблица `questionnaires` содержит ответы респондентов на вопросы в анкете

DROP TABLE IF EXISTS questionnaires;
CREATE TABLE questionnaires(
	id SERIAL PRIMARY KEY,										-- идентификатор записи
	title_id BIGINT UNSIGNED NOT NULL,							-- номер анкеты
	q_number INT UNSIGNED NOT NULL,								-- номер вопроса
	a_number INT UNSIGNED NOT NULL,								-- номер ответа
	KEY key_questionnaires_title_id(title_id),
	KEY key_questionnaires_q_number(q_number),
	KEY key_questionnaires_a_number(a_number),
	CONSTRAINT fk_questionnaires_title FOREIGN KEY (title_id) REFERENCES title(id),
	CONSTRAINT fk_questionnaires_ques_ans FOREIGN KEY (q_number, a_number) REFERENCES questions_answers(q_number, a_number)
 );


-- Таблица `another_answers` содержит список ответов, вписанных респондентом в бланк анкеты, как предусмотренных 
-- составителем анкеты, так и выражающих личное мнение респондента в рамках конкретного вопроса или анкетирования в целом

DROP TABLE IF EXISTS another_answers;
CREATE TABLE another_answers(
	id SERIAL PRIMARY KEY,										-- идентификатор
	title_id BIGINT UNSIGNED NOT NULL,							-- номер анкеты
	q_number INT UNSIGNED NOT NULL,								-- номер вопроса
	text VARCHAR(500) NOT NULL,									-- текст ответа
	opinion ENUM('0', '1') NOT NULL DEFAULT '0',				-- '1' если ответ представляет из себя мнение, а не носит информационный характер
	KEY key_another_answers_title_id(title_id),
	KEY key_another_answers_q_number(q_number),
	CONSTRAINT fk_another_answers_title FOREIGN KEY (title_id) REFERENCES title(id),
	CONSTRAINT fk_another_answers_questions FOREIGN KEY (q_number) REFERENCES questions(q_number)
);

-- В таблице update_logs фиксируются изменения колонок таблицы questionnaires, 
-- хранящей информацию об ответах респондентов.

DROP TABLE IF EXISTS update_logs;
CREATE TABLE update_logs(
	id SERIAL,													-- номер записи
	table_name VARCHAR(50) NOT NULL,							-- имя таблицы, в которую были внесены изменения
	field_name VARCHAR(50) NOT NULL,							-- имя колонки
	old_value BIGINT UNSIGNED,									-- старое значение
	new_value BIGINT UNSIGNED,									-- новое значение
	updated_at DATETIME NOT NULL								-- дата-время обновления
) ENGINE=Archive;
