-- Задание 1

USE vk;
INSERT INTO users(firstname, lastname, email, phone, password_hash) 
VALUES ('Игорь', 'Петров', 'petrov_i@mail.ru', '9149911225', 'aaa'),
('Алексей', 'Иванов', 'ivanov_a@mail.ru', '9149916587', 'bbb'), 
('Ирина', 'Богомолова', 'bogomol_i@mail.ru', '9092621225', 'ccc'), 
('Лариса', 'Синаева', 'sinaeva_l@mail.ru', '9096582478', 'ddd'),
('Андрей', 'Шишкин', 'shishkin_a@mail.ru', '9146295816', 'eee'),
('Артём', 'Золотарь', 'zolotar_a@mail.ru', '9149918564', 'fff'),
('Мирослава', 'Никонова', 'nikonova_m@mail.ru', '9099628547', 'ggg'), 
('София', 'Иночкина', 'inochkina_s@mail.ru', '9149915483', 'hhh'),
('Иван', 'Котов', 'kotov_i@mail.ru', '9096258741', 'iii'), 
('Георгий', 'Сидоров', 'sidorov_g@mail.ru', '9146298534', 'jjj'); 


INSERT INTO profiles(user_id, gender, birthday, photo_id, city, country)
VALUES (1, 'm', DATE_SUB(NOW(), INTERVAL 23 YEAR), 1, 'Иваново', 'Россия'), 
(2, 'm', DATE_SUB(NOW(), INTERVAL '34:2' YEAR_MONTH), 2, 'Омск', 'Россия'),
(3, 'f', DATE_SUB(NOW(), INTERVAL '28:4' YEAR_MONTH), 3, 'Саратов', 'Россия'),
(4, 'f', DATE_SUB(NOW(), INTERVAL '22:1' YEAR_MONTH), 4, 'Москва', 'Россия'),
(5, 'm', DATE_SUB(NOW(), INTERVAL '36:6' YEAR_MONTH), 5, 'Новосибирск', 'Россия'),
(6, 'm', DATE_SUB(NOW(), INTERVAL '27:7' YEAR_MONTH), 6, 'Хабаровск', 'Россия'),
(7, 'f', DATE_SUB(NOW(), INTERVAL '35:3' YEAR_MONTH), 7, 'Волгодонск', 'Россия'),
(8, 'x', DATE_SUB(NOW(), INTERVAL '44:2' YEAR_MONTH), 8, 'Владивосток', 'Россия'),
(9, 'm', DATE_SUB(NOW(), INTERVAL '42:4' YEAR_MONTH), 9, 'Калининград', 'Россия'),
(10, 'x', DATE_SUB(NOW(), INTERVAL '33:5' YEAR_MONTH), 10, 'Минусинск', 'Россия');


INSERT INTO media_types
VALUES(DEFAULT, 'Фото'),
(DEFAULT, 'Видео'),
(DEFAULT, 'Аудио');

INSERT INTO media(user_id, media_types_id, file_name, file_size, created_at) 
VALUES (1, 1, 'dfg.jpg', 764, DATE_SUB(NOW(), INTERVAL 12 DAY)),
(2, 1, 'jlkj.jpg', 845, DATE_SUB(NOW(), INTERVAL '43:9' DAY_HOUR)),
(3, 1, 'kdflk.jpg', 884, DATE_SUB(NOW(), INTERVAL '22:2' DAY_HOUR)),
(4, 1, 'dfkljj.jpg', 775, DATE_SUB(NOW(), INTERVAL '33:5' DAY_HOUR)),
(5, 1, 'lrig.jpg', 844, DATE_SUB(NOW(), INTERVAL '14:3' DAY_HOUR)),
(6, 1, 'wrcj.jpg', 874, DATE_SUB(NOW(), INTERVAL '24:7' DAY_HOUR)),
(7, 1, 'lsdg.jpg', 849, DATE_SUB(NOW(), INTERVAL '5:2' DAY_HOUR)),
(8, 1, 'kjhrig.jpg', 694, DATE_SUB(NOW(), INTERVAL '4:8' DAY_HOUR)),
(9, 1, 'puoyi.jpg', 921, DATE_SUB(NOW(), INTERVAL '58:3' DAY_HOUR)),
(10, 1, 'fjwpbnf.jpg', 649, DATE_SUB(NOW(), INTERVAL '17:1' DAY_HOUR));

-- Материалы к постам-------------------

INSERT INTO media(user_id, media_types_id, file_name, file_size) 
VALUES (2, 1, 'post1.jpg', 752),
(2, 2, 'post2.mp4', 8455),
(3, 1, 'post_12.jpg', 654),
(4, 3, 'post44.mp3', 7755),
(5, 1, 'post55.jpg', 754),
(6, 2, 'Nhuhio iouuoo.mp4', 10274),
(7, 1, 'post77.jpg', 645),
(8, 3, 'Audio1.mp3', 6942),
(8, 3, 'Audio2.mp3', 4210),
(10, 1, 'post10.jpg', 642);

INSERT INTO messages(from_user_id, to_user_id, txt, is_delivered, created_at)
VALUES (2, 4, 'Привет. Как дела?', 1, DATE_SUB(NOW(), INTERVAL '10:1' DAY_HOUR)),
(4, 2, 'Всё хорошо. А у тебя?', 1, DATE_SUB(NOW(), INTERVAL '9:22' DAY_HOUR)),
(2, 4, 'Всё норм', 1, DATE_SUB(NOW(), INTERVAL '9:21' DAY_HOUR)),
(3, 8, 'Что по проекту?', 1, DATE_SUB(NOW(), INTERVAL '18:5' DAY_HOUR)),
(8, 3, 'У тебя в почте.', 1, DATE_SUB(NOW(), INTERVAL '8:14' DAY_HOUR)),
(7, 10, 'Завтра едем?', 0, DATE_SUB(NOW(), INTERVAL '2:1' DAY_HOUR)),
(10, 9, 'Перенесли на 12е', 1, DATE_SUB(NOW(), INTERVAL '28:4' DAY_HOUR)),
(9, 10, 'Печально:(', 1, DATE_SUB(NOW(), INTERVAL '28:3' DAY_HOUR)),
(10, 5, 'Как успехи?', 0, DATE_SUB(NOW(), INTERVAL '8:9' DAY_HOUR)),
(5, 10, 'Ты где? Я скучаю', 1, DATE_SUB(NOW(), INTERVAL '5:10' DAY_HOUR));

INSERT INTO friend_requests
VALUES (2, 4, 1), (3, 8, 1), (10, 7, 1), (9, 10, 1), (5, 10, 1), (1, 4, 0), (2, 5, 0), (10, 4, 0), (6, 1, 0), (7, 5, 0);

INSERT INTO communities(name, description)
VALUES ('Сообщество1', 'Описание1'),
('Сообщество2', 'Описание2'),
('Сообщество3', 'Описание3'),
('Сообщество4', 'Описание4'),
('Сообщество5', 'Описание5'),
('Сообщество6', 'Описание6'),
('Сообщество7', 'Описание7'),
('Сообщество8', 'Описание8'),
('Сообщество9', 'Описание9'),
('Сообщество10', 'Описание10');

INSERT INTO communities_users
VALUES (1, 5, DATE_SUB(NOW(), INTERVAL '65:3' YEAR_MONTH)),
(2, 3, DATE_SUB(NOW(), INTERVAL '48:4' YEAR_MONTH)),
(3, 5, DATE_SUB(NOW(), INTERVAL '52:9' YEAR_MONTH)),
(4, 6, DATE_SUB(NOW(), INTERVAL '5:15' YEAR_MONTH)),
(5, 8, DATE_SUB(NOW(), INTERVAL '20:1' YEAR_MONTH)),
(6, 10, DATE_SUB(NOW(), INTERVAL '8:7' YEAR_MONTH)),
(7, 7, DATE_SUB(NOW(), INTERVAL '9:10' YEAR_MONTH)),
(8, 1, DATE_SUB(NOW(), INTERVAL '62:2' YEAR_MONTH)),
(9, 2, DATE_SUB(NOW(), INTERVAL '33:8' YEAR_MONTH)),
(10, 1, DATE_SUB(NOW(), INTERVAL '10:10' YEAR_MONTH));


INSERT INTO posts(user_id, txt, liked, created_at)
VALUES (2, 'Drgklkklh ophkgty8er9pripti iruiytuitr yyutoofigu iurhtjr!', 4, DATE_SUB(NOW(), INTERVAL '10:10' YEAR_MONTH)),
(5, 'Ghohgiohf dsyuftd lhpkj? Safdiusd sadd cxgsfy bvbjfi. Fjfghj dfghf sdwe bd drttu njhgj.', 10, DATE_SUB(NOW(), INTERVAL '25:5' YEAR_MONTH)),
(2, 'Jcbxnvv oph kgty8er 9pripti iruiytuitr yyutoofigu iurhtjr. Smlkvjg ghoto cvjfdi jgkh.', -2, DATE_SUB(NOW(), INTERVAL '2:5' YEAR_MONTH)),
(6, 'Drgklkklh op hkgty8e r9pripti iruiyt uitr yyut oofigu iurhtjr. Afdkjfsj vcxgjf tyitoi hkgkjk.', 55, DATE_SUB(NOW(), INTERVAL '31:2' YEAR_MONTH)),
(7, 'Akklh dsaf ty8er pripti iruiytu itr yyu toof igu iurhtjr! Hjfdgdif fhjjlgjhljgk sert!!! Jvnbndfsl?', 40, DATE_SUB(NOW(), INTERVAL '12:3' YEAR_MONTH)),
(8, 'Kkklh hkgty er pripti irui ytuitr yyut oofigu iurhtjr. Jdsgfdsaf dkgfd dsbfdhsgffg duftr. Rfdkhgh dfskjfd, dsfud dsgfsd.', -20, DATE_SUB(NOW(), INTERVAL '1:16' YEAR_MONTH)),
(10, 'Nklkklh ophkgt y8 er 9 pripti irui ytuitr yyuto ofigu iurhtj df - hjdfhd djghfdhg. Xghjg fgjtiuy cxmjsd dyrer.', 145, DATE_SUB(NOW(), INTERVAL '21:1' YEAR_MONTH)),
(5, 'Ifnjghf pripti iruiy tuitr yyuto ofigu iurhtjr: jdfhgdkh vdhgut vjhg. Hjflkfdg utgir cgjhdfg, dfyhuire, dughfiur, fdhgey b fuye.', 14, DATE_SUB(NOW(), INTERVAL '4:1' YEAR_MONTH)),
(3, 'Drgk ophkgty8er9pripti iruiytuitr yyutoofigu iurhtjr. Fdsjf vjkhtr yuipyi fdjghfd.', 415, DATE_SUB(NOW(), INTERVAL '55:22' YEAR_MONTH)),
(4, 'Drg - hfdgfd ophkgty er pripti iruiytuitr yyutoofigu iurhtjr! Hdsjfljsd xzDRs sdiarf vfdjgfgjh fdg.', -4, DATE_SUB(NOW(), INTERVAL '1:10' YEAR_MONTH));

INSERT INTO media_in_posts
VALUES (1, 11), (2, 15), (3, 12), (4, 16), (5, 17), (6, 18), (6, 19), (7, 20), (9, 13), (10, 14); 

INSERT INTO bookmarks (user_id, link)
VALUES (1, 'https://vksait.ru/razdel/157886/post1'),
(1, 'https://vksait.ru/id1568746/albums/photo1.ipg'),
(2, 'https://vksait.ru/razdel/15711684/post356'),
(5, 'https://vksait.ru/razdel3/1871886/post54'),
(6, 'https://vksait.ru/id15256987/albums/photo12.ipg'),
(8, 'https://vksait.ru/id15226457/music/audio34.mp3'),
(8, 'https://vksait.ru/razdel3/1871886/post68'),
(9, 'https://vksait.ru/razdel3/1871886/post14'),
(3, 'https://vksait.ru/razdel4/9851886/post84'),
(10, 'https://vksait.ru/razdel3/1871886/post5');

-- Задание 2-------------------------------------------------------------------------------------------------

SELECT DISTINCT firstname FROM users ORDER BY firstname;

-- Задание 3-------------------------------------------------------------------------------------------------

ALTER TABLE profiles 
ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;

-- Добавляю несовершеннолетнего пользователя, чтобы проверить обновление поля is_active
-- INSERT INTO users VALUES (DEFAULT, 'Лев', 'Несовершеннолетович', 'nesov_l@mail.ru', '9165894765', 'nnn', DEFAULT);
-- INSERT INTO profiles VALUES (13, 'm', '2004-04-21', DEFAULT, 'Казань', 'Россия', DEFAULT);
-- UPDATE profiles SET is_active = 1 
-- WHERE user_id = 13;

UPDATE profiles SET is_active = 0 
WHERE datediff(NOW(), DATE_ADD(birthday , INTERVAL 18 YEAR)) < 0;

-- Проверяем внесённые изменения
SELECT concat(u.firstname, ' ', u.lastname) as name, p.is_active FROM profiles p, users u 
WHERE u.id = p.user_id ;

-- Задание 4 ---------------------------------------------------------------------------------------------------

INSERT INTO messages VALUES (DEFAULT, 4, 6, 'Текст', 0, '2021-09-01 00:00:00', DEFAULT);
INSERT INTO messages VALUES (DEFAULT, 6, 4, 'Текст2', 0, DEFAULT, '2021-09-01 00:00:00');

SELECT * FROM messages 
WHERE created_at > NOW() OR updated_at > NOW();

DELETE FROM messages 
WHERE created_at > NOW() OR updated_at > NOW();

--  Задание 5 --------------------------------------------------------------------------------------------------

-- Тема курсовой: "Исследование общественного мнения в регионе на основе анкетных данных."



