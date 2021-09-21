-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: db_questioning
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `age`
--

DROP TABLE IF EXISTS `age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `age` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `age`
--

LOCK TABLES `age` WRITE;
/*!40000 ALTER TABLE `age` DISABLE KEYS */;
INSERT INTO `age` VALUES (1,'до 29 лет'),(2,'30 - 39 лет'),(3,'40 - 49 лет'),(4,'50 - 59 лет'),(5,'60 лет и старше');
/*!40000 ALTER TABLE `age` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `another_answers`
--

DROP TABLE IF EXISTS `another_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `another_answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint unsigned NOT NULL,
  `q_number` int unsigned NOT NULL,
  `text` varchar(500) NOT NULL,
  `opinion` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `key_another_answers_title_id` (`title_id`),
  KEY `key_another_answers_q_number` (`q_number`),
  CONSTRAINT `fk_another_answers_questions` FOREIGN KEY (`q_number`) REFERENCES `questions` (`q_number`),
  CONSTRAINT `fk_another_answers_title` FOREIGN KEY (`title_id`) REFERENCES `title` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `another_answers`
--

LOCK TABLES `another_answers` WRITE;
/*!40000 ALTER TABLE `another_answers` DISABLE KEYS */;
INSERT INTO `another_answers` VALUES (2,6,15,'не здорова','0'),(8,659,11,'доставка товаров в отдаленные пункты края','0'),(9,659,13,'никто','0'),(11,1017,15,'я не здорова, но жива','0'),(12,1024,14,'дурных указов правительства','0'),(15,1059,15,'приобрела бесценный опыт','0'),(16,1061,14,'войны','0'),(17,1174,14,'своего бессилия','0'),(19,1214,15,'затрудняюсь ответить','0'),(21,1275,10,'увеличить финансирование на выделение субсидий для выезжающих из районов крайнего севера','0'),(22,1275,11,'не могу получить сертификат ГЖС','0'),(23,1280,10,'недостаток досуга','0'),(24,1280,14,'гражданской войны','0');
/*!40000 ALTER TABLE `another_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `a_number` int unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`a_number`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (1,'Значительно улучшился'),(2,'Немного улучшился'),(3,'Не изменился'),(4,'Немного ухудшился'),(5,'Значительно ухудшился'),(6,'Да, вполне удовлетворен'),(7,'Скорее удовлетворен'),(8,'Скорее не удовлетворен'),(9,'Не удовлетворен'),(10,'Станет лучше'),(11,'Останется такой же, как сегодня'),(12,'Ухудшится'),(13,'Планирую на несколько лет вперед'),(14,'Строю планы на короткий срок (2-3 месяца)'),(15,'Пока не строю планов, ситуация в стране нестабильна'),(16,'Никогда не строю планов, все делаю спонтанно, живу сегодняшним днем'),(17,'Да'),(18,'Скорее да'),(19,'Скорее нет'),(20,'Нет'),(21,'Прекрасное настроение'),(22,'Нормальное, ровное состояние'),(23,'Испытываю напряжение, раздражение'),(24,'Испытываю страх, тоску'),(25,'С надеждой, оптимизмом'),(26,'Спокойно, но без оптимизма'),(27,'С тревогой и неуверенностью'),(28,'С отчаянием'),(29,'Высокий, материальных затруднений нет'),(30,'Сравнительно высокий, хотя некоторые покупки не по карману'),(31,'Средний, денег хватает лишь на основные продукты и одежду'),(32,'Низкий, денег не хватает на продукты, лекарства, одежду'),(33,'Очень низкий, живу в крайней нужде'),(34,'Живу в режиме постоянной экономии'),(35,'Пришлось недавно (пару месяцев назад) начать экономить'),(36,'Недавно (пару месяцев назад) перестал экономить'),(37,'Никогда не экономлю'),(38,'Откажусь от покупок и расходов'),(39,'Постараюсь в ближайшее время сэкономить, \"ужаться\", но все-таки накопить требуемую сумму'),(40,'Постараюсь занять необходимую сумму, взять кредит и все-таки осуществить необходимые оплаты'),(41,'5000 руб. и менее'),(42,'5001 - 10 000 руб.'),(43,'10 001 - 15 000 руб.'),(44,'15 001 - 20 000 руб.'),(45,'20 001 - 25 000 руб.'),(46,'25 001 - 30 000 руб.'),(47,'30 001 - 35 000 руб.'),(48,'35 001 - 40 000 руб.'),(49,'40 001 - 45 000 руб.'),(50,'45 001 - 50 000 руб.'),(51,'50 001 - 60 000 руб.'),(52,'60 001 - 70 000 руб.'),(53,'свыше 70 000 руб.'),(54,'в предыдущем месяце у меня дохода не было'),(55,'отказ от ответа'),(56,'не знаю, затрудняюсь ответить'),(57,'Не сталкиваюсь'),(58,'Часто'),(59,'Редко'),(60,'Допускаю'),(61,'Исключаю'),(62,'Государственные органы края, Губернатор края'),(63,'Местные органы власти: Глава администрации, Глава района, Глава города'),(64,'Трудовой коллектив, в котором Вы работаете'),(65,'Общественные организации'),(66,'Состоятельные (богатые) знакомые'),(67,'Друзья'),(68,'Родственники'),(69,'Родители'),(70,'Взрослые дети'),(71,'Муж (жена)'),(72,'Могу рассчитывать только на собственные силы'),(73,'Поможет случай'),(74,'Благоприятная'),(75,'Нормальная, терпимая'),(76,'Сложная,трудная'),(77,'Нетерпимая'),(78,'Удовлетворен'),(79,'Стабильное'),(80,'Не стабильное'),(81,'Хорошем'),(82,'Удовлетворительном'),(83,'Плохом'),(84,'Безусловно положительно'),(85,'Скорее положительно'),(86,'Скорее отрицательно'),(87,'Безусловно отрицательно'),(88,'Ничего не знаю о его деятельности'),(89,'Нужен новый губернатор'),(90,'Чтобы Губернатором оставался нынешний руководитель'),(91,'\"Правильной\"'),(92,'Скорее \"правильной\", чем \"неправильной\"'),(93,'Скорее \"неправильной\", чем \"правильной\"'),(94,'\"Неправильной\"'),(95,'Одобряю'),(96,'Не одобряю'),(97,'Результаты их деятельности по улучшению качества оказания медицинской помощи населению'),(98,'Результаты их деятельности  по созданию условий для занятия физической культурой и спортом'),(99,'Результаты их деятельности  по улучшению состояния общего образования'),(100,'Результаты их деятельности  по улучшению качества оказываемых населению жилищно-коммунальных услуг'),(101,'Результаты их деятельности  по обеспечению безопасности населения в целом'),(102,'Результаты их деятельности по обепечению безопасности населения от чрезвычайных ситуаций, характерных для места Вашего проживания'),(103,'Отношение к деятельности руководителя исполнительной власти субъекта Российской Федерации'),(104,'Доверяю'),(105,'Не доверяю'),(106,'Не замечаю'),(107,'Усиливается'),(108,'Остается неизменным '),(109,'Ослабевает'),(110,'Деятельность экстремистских организаций'),(111,'Терроризм'),(112,'Наплыв трудовых мигрантов'),(113,'Новый виток мирового финансового кризиса'),(114,'природные катаклизмы'),(115,'Риск безработицы'),(116,'Деятельность религиозных сект'),(117,'Несчастный случай'),(118,'Техногенные катастрофы'),(119,'Потеря здоровья, тяжелое заболевание'),(120,'Низкий доход'),(121,'Другое'),(122,'Другое (напишите)'),(123,'Затрудняюсь ответить');
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attitude`
--

DROP TABLE IF EXISTS `attitude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attitude` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `attitude` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attitude`
--

LOCK TABLES `attitude` WRITE;
/*!40000 ALTER TABLE `attitude` DISABLE KEYS */;
INSERT INTO `attitude` VALUES (1,'Положительное'),(2,'Нейтральное'),(3,'Негативное'),(4,'Агрессивное');
/*!40000 ALTER TABLE `attitude` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districts` (
  `id` tinyint unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (0,'Край'),(1,'Город1'),(2,'Город2'),(3,'Город3'),(4,'Район1'),(5,'Район2'),(6,'Район3'),(7,'Район4'),(8,'Район5'),(9,'Район6'),(10,'Район7'),(11,'Район8'),(12,'Район9'),(13,'Район10'),(14,'Район11');
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interviewers`
--

DROP TABLE IF EXISTS `interviewers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interviewers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birthday` date NOT NULL,
  `district_id` tinyint unsigned NOT NULL,
  `area` tinyint unsigned NOT NULL,
  `phone` char(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `key_district_id` (`district_id`),
  CONSTRAINT `interviewers_ibfk_1` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interviewers`
--

LOCK TABLES `interviewers` WRITE;
/*!40000 ALTER TABLE `interviewers` DISABLE KEYS */;
INSERT INTO `interviewers` VALUES (1,'Олеся','Ибрагимова','1984-05-20',1,1,'89146296655'),(2,'Анна','Головина','1988-04-11',3,1,'89096845215'),(3,'Алевтина','Сидорова','1972-02-16',6,1,'89627895462'),(4,'Ильдар','Приусов','1992-11-01',12,1,'89145786235');
/*!40000 ALTER TABLE `interviewers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professions`
--

DROP TABLE IF EXISTS `professions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professions`
--

LOCK TABLES `professions` WRITE;
/*!40000 ALTER TABLE `professions` DISABLE KEYS */;
INSERT INTO `professions` VALUES (1,'Рабочий промышленности, строительства, транспорта и др.'),(2,'Работник сельского хозяйства, фермер'),(3,'Инженер, специалист технического профиля'),(4,'Работник образования'),(5,'Работник здравоохранения'),(6,'Работник сферы культуры и искусства'),(7,'Работник торговли, пищевой промышленности'),(8,'Работник сферы бытового обслуживания'),(9,'Работник рыбохозяйственного комплекса'),(10,'Работник турристической компании'),(11,'Военнослужащий'),(12,'Работник правоохранительных органов'),(13,'Работник в сфере ЖКХ и энергетики'),(14,'Работник в транспортной сфере'),(15,'Работник в сфере информационных технологий'),(16,'Работник органов государственной (муниципальной) службы'),(17,'Предприниматель'),(18,'Студент, учащийся вуза, техникума, колледжа, училища'),(19,'Не работающий пенсионер'),(20,'Занимаюсь домашним хозяйством'),(21,'Временно не работающий, ищу работу'),(22,'Безработный'),(23,'Другое (напишите)');
/*!40000 ALTER TABLE `professions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaires`
--

DROP TABLE IF EXISTS `questionnaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaires` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title_id` bigint unsigned NOT NULL,
  `q_number` int unsigned NOT NULL,
  `a_number` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `key_questionnaires_title_id` (`title_id`),
  KEY `key_questionnaires_q_number` (`q_number`),
  KEY `key_questionnaires_a_number` (`a_number`),
  KEY `fk_questionnaires_ques_ans` (`q_number`,`a_number`),
  CONSTRAINT `fk_questionnaires_ques_ans` FOREIGN KEY (`q_number`, `a_number`) REFERENCES `questions_answers` (`q_number`, `a_number`),
  CONSTRAINT `fk_questionnaires_title` FOREIGN KEY (`title_id`) REFERENCES `title` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaires`
--

LOCK TABLES `questionnaires` WRITE;
/*!40000 ALTER TABLE `questionnaires` DISABLE KEYS */;
INSERT INTO `questionnaires` VALUES (1,1,1,2),(2,1,2,7),(3,1,3,123),(4,1,4,13),(5,1,5,18),(6,1,10,38),(7,1,11,52),(8,1,13,60),(9,1,14,67),(10,1,15,75),(11,6,1,2),(12,6,2,7),(13,6,3,123),(14,6,4,14),(15,6,5,19),(16,6,10,39),(17,6,11,51),(18,6,13,60),(19,6,14,71),(20,6,15,75),(21,392,1,123),(22,392,2,123),(23,392,3,10),(24,392,4,123),(25,392,5,20),(26,392,10,38),(27,392,11,51),(28,392,13,123),(29,392,14,68),(30,392,15,76),(31,421,1,3),(32,421,2,8),(33,421,3,11),(34,421,4,14),(35,421,5,19),(36,421,10,40),(37,421,11,51),(38,421,13,60),(39,421,15,76),(40,605,1,3),(41,605,2,8),(42,605,3,123),(43,605,4,14),(44,605,5,18),(45,605,10,40),(46,605,11,47),(47,605,13,60),(48,605,14,72),(49,605,15,75),(50,642,1,3),(51,642,2,7),(52,642,3,11),(53,642,4,16),(54,642,5,18),(55,642,10,40),(56,642,11,53),(57,642,13,61),(58,642,14,67),(59,642,15,75),(60,659,1,3),(61,659,2,9),(62,659,3,123),(63,659,4,123),(64,659,5,19),(65,659,10,40),(66,659,11,54),(67,659,13,61),(68,659,14,68),(69,659,15,76),(70,661,1,4),(71,661,2,9),(72,661,3,11),(73,661,4,123),(74,661,5,19),(75,661,10,38),(76,661,11,43),(77,661,13,123),(78,661,14,71),(79,661,15,77),(80,1017,1,1),(81,1017,2,7),(82,1017,3,11),(83,1017,4,14),(84,1017,5,17),(85,1017,10,38),(86,1017,11,45),(87,1017,13,61),(88,1017,14,71),(89,1017,15,75),(90,1024,1,3),(91,1024,2,8),(92,1024,3,123),(93,1024,4,15),(94,1024,5,19),(95,1024,10,40),(96,1024,11,49),(97,1024,13,61),(98,1024,15,75),(99,1040,1,2),(100,1040,2,7),(101,1040,3,10),(102,1040,4,13),(103,1040,5,18),(104,1040,10,40),(105,1040,11,49),(106,1040,13,61),(107,1040,15,75),(108,1046,1,3),(109,1046,2,9),(110,1046,3,123),(111,1046,4,16),(112,1046,5,18),(113,1046,10,39),(114,1046,11,45),(115,1046,13,61),(116,1046,14,67),(117,1046,15,75),(118,1059,1,2),(119,1059,2,6),(120,1059,3,123),(121,1059,4,14),(122,1059,5,19),(123,1059,10,39),(124,1059,11,45),(125,1059,13,60),(126,1059,14,72),(127,1059,15,75),(128,1061,1,4),(129,1061,2,8),(130,1061,3,12),(131,1061,4,14),(132,1061,5,20),(133,1061,10,39),(134,1061,11,45),(135,1061,13,60),(136,1061,14,72),(137,1061,15,77),(138,1174,1,4),(139,1174,2,9),(140,1174,3,11),(141,1174,4,13),(142,1174,5,19),(143,1174,10,39),(144,1174,11,47),(145,1174,13,60),(146,1174,15,76),(147,1189,1,2),(148,1189,2,9),(149,1189,3,10),(150,1189,4,15),(151,1189,5,18),(152,1189,10,40),(153,1189,11,55),(154,1189,13,61),(155,1189,15,76);
/*!40000 ALTER TABLE `questionnaires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `q_number` int unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(300) NOT NULL,
  `radio` enum('0','1') NOT NULL DEFAULT '1',
  `another_answer` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`q_number`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Как изменился Ваш уровень жизни за последние 2 года?','1','0'),(2,'Удовлетворены ли Вы своим уровнем жизни в настоящее время?','1','0'),(3,'Как, по вашему мнению, изменится ли Ваша жизнь в ближайшие годы?','1','0'),(4,'Одни люди стараются планировать свою жизнь на несколько лет вперед. Другие строят планы только на короткий срок. А как поступаете Вы?','1','0'),(5,'Если говорить в целом, чувствуете ли вы уверенность в завтрашнем дне?','1','0'),(10,'Допустим, вам необходимо сделать крупную покупку, заплатить  за учебу, отдать долг и др., но имеющихся у вас средств для этого недостаточно. Как вы, скорее всего, поступите в такой ситуации?','1','0'),(11,'Укажите, пожалуйста, хотя бы приблизительно, Ваш личный доход в предыдущем месяце.','1','0'),(13,'Вы лично допускаете или исключаете для себя возможность принять участие в каких-либо акциях протеста?','1','0'),(14,'Кто, по вашему мнению, может помочь Вам в случае тяжелой жизненной ситуации?','1','0'),(15,'Какова нынешняя экономическая ситуация лично для Вас?','1','0');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions_answers`
--

DROP TABLE IF EXISTS `questions_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions_answers` (
  `q_number` int unsigned NOT NULL,
  `a_number` int unsigned NOT NULL,
  PRIMARY KEY (`q_number`,`a_number`),
  KEY `key_q_number` (`q_number`),
  KEY `key_a_number` (`a_number`),
  CONSTRAINT `fk_questions_answers_answers` FOREIGN KEY (`a_number`) REFERENCES `answers` (`a_number`),
  CONSTRAINT `fk_questions_answers_questions` FOREIGN KEY (`q_number`) REFERENCES `questions` (`q_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions_answers`
--

LOCK TABLES `questions_answers` WRITE;
/*!40000 ALTER TABLE `questions_answers` DISABLE KEYS */;
INSERT INTO `questions_answers` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,123),(2,6),(2,7),(2,8),(2,9),(2,123),(3,10),(3,11),(3,12),(3,123),(4,13),(4,14),(4,15),(4,16),(4,123),(5,17),(5,18),(5,19),(5,20),(5,123),(10,38),(10,39),(10,40),(10,123),(11,41),(11,42),(11,43),(11,44),(11,45),(11,46),(11,47),(11,48),(11,49),(11,50),(11,51),(11,52),(11,53),(11,54),(11,55),(11,56),(13,60),(13,61),(13,123),(14,62),(14,63),(14,64),(14,65),(14,66),(14,67),(14,68),(14,69),(14,70),(14,71),(14,72),(14,73),(14,122),(15,74),(15,75),(15,76),(15,77),(15,123);
/*!40000 ALTER TABLE `questions_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `title`
--

DROP TABLE IF EXISTS `title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `title` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `gender` enum('Ж','М','Х') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `age_id` tinyint unsigned NOT NULL,
  `profession_id` int unsigned NOT NULL,
  `attitude_id` tinyint unsigned NOT NULL,
  `interviewer_id` bigint unsigned NOT NULL,
  `phone` char(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `key_title_interviewer_id` (`interviewer_id`),
  KEY `key_title_age_id` (`age_id`),
  KEY `fk_title_attitude_id` (`attitude_id`),
  KEY `fk_profession_id` (`profession_id`),
  CONSTRAINT `fk_title_age_id` FOREIGN KEY (`age_id`) REFERENCES `age` (`id`),
  CONSTRAINT `fk_title_attitude_id` FOREIGN KEY (`attitude_id`) REFERENCES `attitude` (`id`),
  CONSTRAINT `fk_title_interviewer_id` FOREIGN KEY (`interviewer_id`) REFERENCES `interviewers` (`id`),
  CONSTRAINT `title_ibfk_1` FOREIGN KEY (`profession_id`) REFERENCES `professions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `title`
--

LOCK TABLES `title` WRITE;
/*!40000 ALTER TABLE `title` DISABLE KEYS */;
INSERT INTO `title` VALUES (1,'М',1,12,1,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(6,'Ж',3,9,1,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(392,'Ж',4,4,4,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(421,'М',4,11,1,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(605,'М',3,5,1,2,'89146278888','2021-09-17 19:22:50','2021-09-20 16:26:38'),(642,'Ж',2,17,1,2,'89146278888','2021-09-17 19:22:50','2021-09-20 16:26:38'),(659,'Ж',3,11,2,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(661,'М',3,23,3,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(1017,'Ж',4,8,1,4,'89146278888','2021-09-17 19:22:50','2021-09-20 16:26:38'),(1024,'М',5,13,1,3,'89146278888','2021-09-17 19:22:50','2021-09-20 16:26:38'),(1040,'М',2,23,2,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:59:25'),(1046,'Ж',5,23,2,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(1059,'Ж',4,3,2,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(1061,'М',3,5,2,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(1174,'М',4,16,2,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(1189,'Ж',3,9,2,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:47:13'),(1214,'М',1,23,1,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:48:13'),(1222,'Ж',1,23,1,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:48:13'),(1275,'Ж',4,23,1,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:48:13'),(1280,'М',2,23,1,1,'89146278888','2021-09-17 19:22:50','2021-09-17 21:48:13');
/*!40000 ALTER TABLE `title` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-21 13:11:09
