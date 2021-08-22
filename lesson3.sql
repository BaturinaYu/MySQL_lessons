USE vk;

-- посты пользователей

CREATE TABLE posts(
	id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	liked BOOLEAN,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX posts_user_id_idx (user_id),
	CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id)
	);
	
-- фото или видеоматериалы, которые пользователь прикрепил к посту

CREATE TABLE media_in_posts(
	post_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (post_id, media_id),
	KEY(post_id),
	KEY(media_id),
	FOREIGN KEY(post_id) REFERENCES posts(id),
	FOREIGN KEY(media_id) REFERENCES media(id)
	); 

-- таблица закладок пользователя, хранит ссылки на материалы

CREATE TABLE bookmarks(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	link VARCHAR(255) NOT NULL,
	KEY(user_id),
	FOREIGN KEY(user_id) REFERENCES users(id)
	);

	
