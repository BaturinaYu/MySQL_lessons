-- Тема курсовой: "Исследование общественного мнения в регионе на основе анкетных данных"
-- БД `db_questioning` предназначена для обработки данных анкетирования 
-- по вопросам общей удовлетворённости жизнью в регионе.

CREATE DATABASE db_questioning;

USE db_questioning;

-- Таблица `questions` содержит список вопросов анкетирования  

CREATE TABLE questions(
	q_number INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	text VARCHAR(300) NOT NULL,
	radio ENUM('0', '1') NOT NULL DEFAULT '1',
	another_answer ENUM('0', '1') NOT NULL DEFAULT '0'
);

-- Таблица `answers` содержит ответы к вопросам из таблицы `questions`

CREATE TABLE answers(
	a_number INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	text VARCHAR(300) NOT NULL
);

-- Таблица `questions_answers` содержит пары допустимых соответствий вопрос-ответ

CREATE TABLE questions_answers(
	q_number INT UNSIGNED NOT NULL,
	a_number INT UNSIGNED NOT NULL,
	PRIMARY KEY (q_number, a_number),
	KEY key_q_number(q_number),
	KEY key_a_number(a_number),
	CONSTRAINT fk_questions_answers_questions FOREIGN KEY (q_number) REFERENCES questions(q_number),
	CONSTRAINT fk_questions_answers_answers FOREIGN KEY (a_number) REFERENCES answers(a_number)
);

-- Таблица `districts` районов исследования 

CREATE TABLE districts(
	id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

-- Таблица `age` - справочник возрастных групп 

CREATE TABLE age(
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	age VARCHAR(50) NOT NULL
);

-- Таблица `attitude` - справочник оценки отношения респондента к исследованию 

CREATE TABLE attitude(
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	attitude VARCHAR(50) NOT NULL
);

-- Таблица `professions` - справочник профессий

CREATE TABLE professions(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

-- Таблица `interviewers` содержит список интервьюеров

CREATE TABLE interviewers(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthday DATE NOT NULL,
	district_id TINYINT UNSIGNED NOT NULL,
	area TINYINT UNSIGNED NOT NULL,
	phone CHAR(11) NOT NULL,
	KEY key_district_id(district_id),
	FOREIGN KEY fk_district_id(district_id) REFERENCES districts(id)
);

-- Таблица `title` содержит информацию о респонденте (пол, возрастная группа, профессия и т.д.)

CREATE TABLE title(
	id SERIAL PRIMARY KEY,
	gender ENUM('Ж', 'M', 'Х') NOT NULL,
	age_id TINYINT UNSIGNED NOT NULL,
	profession_id INT UNSIGNED NOT NULL,
	attitude_id TINYINT UNSIGNED NOT NULL,
	interviewer_id BIGINT UNSIGNED NOT NULL,
	phone CHAR(11) NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
	KEY key_title_interviewer_id(interviewer_id),
	KEY key_title_age_id(age_id),
	FOREIGN KEY fk_profession_id(profession_id) REFERENCES professions(id),
	CONSTRAINT fk_title_age_id FOREIGN KEY (age_id) REFERENCES age(id),
	CONSTRAINT fk_title_attitude_id FOREIGN KEY (attitude_id) REFERENCES attitude(id),
	CONSTRAINT fk_title_interviewer_id FOREIGN KEY (interviewer_id) REFERENCES interviewers(id)
);

-- Таблица `questionnaires` содержит ответы респондентов на вопросы в анкете

CREATE TABLE questionnaires(
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED NOT NULL,
	q_number INT UNSIGNED NOT NULL,
	a_number INT UNSIGNED NOT NULL,
	KEY key_questionnaires_title_id(title_id),
	KEY key_questionnaires_q_number(q_number),
	KEY key_questionnaires_a_number(a_number),
	CONSTRAINT fk_questionnaires_title FOREIGN KEY (title_id) REFERENCES title(id),
	CONSTRAINT fk_questionnaires_ques_ans FOREIGN KEY (q_number, a_number) REFERENCES questions_answers(q_number, a_number)
 );


-- Таблица `another_answers` содержит список ответов, вписанных респондентом в бланк анкеты, как предусмотренных 
-- составителем анкеты, так и выражающих личное мнение респондента в рамках конкретного вопроса или анкетирования в целом

CREATE TABLE another_answers(
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED NOT NULL,
	q_number INT UNSIGNED NOT NULL,
	text VARCHAR(500) NOT NULL,
	opinion ENUM('0', '1') NOT NULL DEFAULT '0',
	KEY key_another_answers_title_id(title_id),
	KEY key_another_answers_q_number(q_number),
	CONSTRAINT fk_another_answers_title FOREIGN KEY (title_id) REFERENCES title(id),
	CONSTRAINT fk_another_answers_questions FOREIGN KEY (q_number) REFERENCES questions(q_number)
);






