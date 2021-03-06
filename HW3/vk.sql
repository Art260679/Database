DROP DATABASE IF EXISTS vk;

CREATE DATABASE vk;

USE vk;

DROP TABLE IF EXISTS users;

CREATE TABLE users ( id SERIAL PRIMARY KEY,
firstname VARCHAR(50),
lastname VARCHAR(50) COMMENT 'Фамиль',
-- COMMENT на случай, если имя неочевидное
 email VARCHAR(120) UNIQUE,
phone BIGINT,
INDEX users_phone_idx(phone),
INDEX users_firstname_lastname_idx(firstname,
lastname) );

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` ( user_id SERIAL PRIMARY KEY,
gender CHAR(1),
birthday DATE,
photo_id BIGINT UNSIGNED NULL,
created_at DATETIME DEFAULT NOW(),
hometown VARCHAR(100),
FOREIGN KEY (user_id) REFERENCES users(id) ON
UPDATE
	CASCADE ON
	DELETE
		restrict );

DROP TABLE IF EXISTS messages;

CREATE TABLE messages ( id SERIAL PRIMARY KEY,
from_user_id BIGINT UNSIGNED NOT NULL,
to_user_id BIGINT UNSIGNED NOT NULL,
body TEXT,
created_at DATETIME DEFAULT NOW(),
-- можно будет даже не упоминать это поле при вставке
 INDEX messages_from_user_id (from_user_id),
INDEX messages_to_user_id (to_user_id),
FOREIGN KEY (from_user_id) REFERENCES users(id),
FOREIGN KEY (to_user_id) REFERENCES users(id) );

DROP TABLE IF EXISTS friend_requests;

CREATE TABLE friend_requests (
-- id SERIAL PRIMARY KEY, -- изменили на композитный ключ (initiator_user_id, target_user_id)
 initiator_user_id BIGINT UNSIGNED NOT NULL,
target_user_id BIGINT UNSIGNED NOT NULL,
`status` ENUM('requested',
'approved',
'unfriended',
'declined'),
requested_at DATETIME DEFAULT NOW(),
confirmed_at DATETIME,
PRIMARY KEY (initiator_user_id,
target_user_id),
INDEX (initiator_user_id),
-- потому что обычно будем искать друзей конкретного пользователя
 INDEX (target_user_id),
FOREIGN KEY (initiator_user_id) REFERENCES users(id),
FOREIGN KEY (target_user_id) REFERENCES users(id) );

DROP TABLE IF EXISTS communities;

CREATE TABLE communities( id SERIAL PRIMARY KEY,
name VARCHAR(150),
INDEX communities_name_idx(name) );

DROP TABLE IF EXISTS users_communities;

CREATE TABLE users_communities( user_id BIGINT UNSIGNED NOT NULL,
community_id BIGINT UNSIGNED NOT NULL,
PRIMARY KEY (user_id,
community_id),
-- чтобы не было 2 записей о пользователе и сообществе
 FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (community_id) REFERENCES communities(id) );

DROP TABLE IF EXISTS media_types;

CREATE TABLE media_types( id SERIAL PRIMARY KEY,
name VARCHAR(255),
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON
UPDATE
	CURRENT_TIMESTAMP );

DROP TABLE IF EXISTS media;

CREATE TABLE media( id SERIAL PRIMARY KEY,
media_type_id BIGINT UNSIGNED NOT NULL,
user_id BIGINT UNSIGNED NOT NULL,
body text,
filename VARCHAR(255),
size INT,
metadata JSON,
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON
UPDATE
	CURRENT_TIMESTAMP,
	INDEX (user_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_type_id) REFERENCES media_types(id) );

DROP TABLE IF EXISTS likes;

CREATE TABLE likes( id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED NOT NULL,
media_id BIGINT UNSIGNED NOT NULL,
created_at DATETIME DEFAULT NOW() );

DROP TABLE IF EXISTS `photo_albums`;

CREATE TABLE `photo_albums` ( `id` SERIAL,
`name` varchar(255) DEFAULT NULL,
`user_id` BIGINT UNSIGNED DEFAULT NULL,
FOREIGN KEY (user_id) REFERENCES users(id),
PRIMARY KEY (`id`) );

DROP TABLE IF EXISTS `photos`;

CREATE TABLE `photos` ( id SERIAL PRIMARY KEY,
`album_id` BIGINT unsigned NOT NULL,
`media_id` BIGINT unsigned NOT NULL,
FOREIGN KEY (album_id) REFERENCES photo_albums(id),
FOREIGN KEY (media_id) REFERENCES media(id) );

DROP TABLE IF EXISTS `black_list`;
CREATE TABLE `black_list` ( 
`id` SERIAL PRIMARY KEY,
`name` varchar(50) DEFAULT NULL,
`user_id` bigint UNSIGNED DEFAULT NULL,
FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) 
);

DROP TABLE IF EXISTS `music_albums`; -- музыкальный альбом
CREATE TABLE `music_albums`(
`album_id` SERIAL PRIMARY KEY,
`album_name` varchar(50) NOT NULL DEFAULT 'album No name'
);

DROP TABLE IF EXISTS `music_tracks`; -- песни
CREATE TABLE `music_tracks` (
  `track_id` SERIAL PRIMARY KEY,
  `track_name` varchar(50) NOT NULL DEFAULT 'track No name', -- название песни
  `executor` varchar(50) NOT NULL, -- исполнитель
  `playing_time` time NOT NULL, -- время звучания
  `album_name` varchar(50) NOT NULL, 
  `genre` varchar(50) NOT NULL, -- жанр

  INDEX (`track_name`),
  INDEX (`executor`),
  FOREIGN KEY (`track_id`) REFERENCES `music_albums` (`album_id`)
);
















