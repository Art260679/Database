

/* 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем. */
UPDATE users set created_at = now(), updated_at = now();

/* 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время
 помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.*/
UPDATE users set created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users MODIFY created_at datetime, MODIFY updated_at datetime;


/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля,
если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако, нулевые запасы должны выводиться в конце, после всех записей.*/
SELECT value FROM (SELECT value, IF (value = 0 , ~0, value) AS zero  FROM storehouses_products ORDER BY zero) AS agg;

/* 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий ('may', 'august') */
SELECT * FROM users WHERE date_format(birthday,'%M') in ('may', 'august');

/* 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN. */
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);



 -- Практическое задание теме “Агрегация данных” 
 
/* 1. Подсчитайте средний возраст пользователей в таблице users */
SELECT avg(age) FROM (SELECT year(current_timestamp) - year(birthday) AS age FROM profiles) AS Avg_age;

/* 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, 
что необходимы дни недели текущего года, а не года рождения. */
SELECT 
	count(user_id) AS `birthday_at`, 
	date_format(date_format(birthday, '2019-%m-%d'), '%W') as `day_of_the_week` 
FROM 
	profiles
GROUP BY `day_of_the_week`	
ORDER BY
	birthday_at DESC
;

/* 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы */
SELECT EXP(sum(log(value))) FROM TABLE;




