                                     -- Практическое задание по теме “Оптимизация запросов”
                                     
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
	`created_at` DATETIME DEFAULT (NOW),
	`table_name` VARCHAR(45) NOT NULL,
	`pr_id` BIGINT(20) NOT NULL,
	`name_value` VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


 
DROP TRIGGER IF EXISTS log_users;  --  TRIGGER users 
delimiter $$
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, pr_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END $$
delimiter ;



DROP TRIGGER IF EXISTS log_catalogs;  -- TRIGGER catalogs
delimiter $$
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, pr_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END $$
delimiter ;


DROP TRIGGER IF EXISTS log_products;  -- TRIGGER products
delimiter $$
CREATE TRIGGER log_products AFTER INSERT ON products  
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, pr_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END $$
delimiter ;



                                    -- Практическое задание по теме “NoSQL”

-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
SADD ip "127.0.0.1"
SADD ip "127.0.0.1"
SCARD ip 


-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
-- поиск электронного адреса пользователя по его имени.
SET Art Art@mail.ru
SET Art@mail Art
GET Art
GET Art@mail.ru


-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

use catalogs
db.catalogs.insertMany([{"name": "Процессоры"}, {"name": "Мат.платы"}, {"name": "Видеокарты"}])





