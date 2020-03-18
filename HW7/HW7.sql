-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

  SELECT name FROM users WHERE id IN (SELECT user_id FROM orders);


-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name, c.name
FROM products AS p, catalogs AS c
WHERE p.name = `Intel` AND c.id = p.catalog_id;

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
select id,
	(select name from cities where label = flights.`from`) as `from`,
	(select name from cities where label = flights.`to`) as `to`
from 
	flights;
	
