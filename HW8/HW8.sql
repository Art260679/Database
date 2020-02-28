     /*Практическое задание по теме “Транзакции, переменные, представления*/

-- 1. В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
INSERT INTO sample.users (`id`) SELECT `id` FROM shop.users WHERE `id` = 1;
COMMIT;


-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы 
-- products и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW vw AS 
  SELECT products.name AS p_name, catalogs.name AS c_name 
    FROM products,catalogs 
      WHERE products.id = catalogs.id;
      
   -- (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
   -- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
  
     
 PREPARE del_products FROM 'DELETE FROM products ORDER BY created_at LIMIT ?';
SET @ROWS = (SELECT COUNT(*)-5 FROM products);
EXECUTE del_products USING @ROWS;  


 								/* Практическое задание по теме “Администрирование MySQL*/ 
     
-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

-- shop_read доступны только запросы на чтение данных
DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '1234';
GRANT SELECT ON shop.* TO 'shop_reader'@'localhost';


-- shop - доступны любые операции в пределах базы данных shop
DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY '1234';
GRANT ALL ON shop.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop.* TO 'shop'@'localhost';

-- 2. (по желанию) Есть таблица (accounts), включающая в себя три столбца: id, name, password,
-- которые содержат первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
-- предоставляющее доступ к столбцам id и name. Создайте пользователя user_read,
-- который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username.


CREATE OR REPLACE VIEW username(user_id, user_name) AS 
	SELECT id, name FROM accounts2;


-- пользователь 'shop_reader'@'localhost' с доступом только к одному представлению username;
DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '1234';
GRANT SELECT ON shop.username TO 'shop_reader'@'localhost';
     
     
          
     
     
     							/* Практическое задание по теме “Хранимые процедуры и функции, триггеры*/
     

-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

     
DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '12:00:00') THEN
		SELECT 'Доброе утро';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '18:00:00') THEN
		SELECT 'Добрый день';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '00:00:00') THEN
		SELECT 'Добрый вечер';
	ELSE
		SELECT 'Доброй ночи';
	END IF;
END //
delimiter ;

CALL hello();



-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
-- значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля
-- были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS null_Trggr;
delimiter $$
CREATE TRIGGER null_Trggr BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NULL в обоих полях!';
	END IF;
END $$
delimiter ;




