/*   
 База данных интернет - магазина позволяет хранить данные о товарах, группах товаров, пользователях.Отслеживать популярность 
 товаров через таблицу popularity_products.  Хранить информацию о товаре, которую пользователь отложил в корзину, а также 
 информацию о заказах, отправленных на доставку.  Кроме того, назначать пользователям группы администратор, менеджер, покупатель. 
 */

DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;





DROP TABLE IF EXISTS `product_categories`; -- категория товара
CREATE TABLE `product_categories` (
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(255) -- наименование
); 

INSERT INTO `product_categories` (`name`) VALUES ("Abercrombie & Fitch"),("Byredo"),("Chloe"),("Ex_Nihilo"),("Feraud"),("Ferrari"),("Kenzo"),("Roberto_Cavalli");


DROP TABLE IF EXISTS `products`; -- товар
CREATE TABLE `products` (
	`id_products` BIGINT UNSIGNED NOT NULL,
	`product_categories_id` BIGINT UNSIGNED NOT NULL,
	`name` VARCHAR(255) NOT NULL, -- наименование
	`description` TEXT, -- описание
	`price` DECIMAL UNSIGNED NOT NULL, -- цена
    `status` ENUM('available', 'no_available'), -- в наличии, нет в наличии
    `filepath` VARCHAR(255), -- путь к файлу (изображение товара)
	`amount_of_product` INT, -- количество товара
	
	INDEX (`price`),
	INDEX (`id_products`),
	INDEX (`name`),
	INDEX(`product_categories_id`),
	PRIMARY KEY (`id_products`, `product_categories_id`),
	FOREIGN KEY (`product_categories_id`) REFERENCES `product_categories`(`id`) 
);

INSERT INTO `products` (`id_products`, `product_categories_id`,`name`,`description`,`price`,`status`,`filepath`,`amount_of_product`) VALUES 
("1","1","instinct","men 100ml test EdT","2600.00","available","/home/art/images/11",6),("2","1","instinct_blue","men 100ml test EdT","3005.00","available","/home/art/images/12",2),
("3","2","Accord oud unisex ","100ml edp","9450.00","available","/home/art/images/13",3),("4","2","Bauldelaire men","100ml edp","9450.00","available","/home/art/images/14",1),("5","2","BBlanche Lady","100ml edp","9450.00","available","/home/art/images/15",3),
("6","3","Absolu De Parfum Lady","30ml Edp","2625.00","available","/home/art/images/16",2),("7","3","Parfum Lady ","50ml Edp","3375.00","available","/home/art/images/17",1),("8","3","Absolu","80ml Edp","4125.00","available","/home/art/images/18",3),
("9","4","Devil Tender Lady","100ml Edp","11775.00","no_available","/home/art/images/17",0),("10","4","Fleur Narcotique Unisex Mini","7.5ml Edp","1650.00","available","/home/art/images/18",5),("11","4","Viper Green Unisex","100ml Edp","18000.00","available","/home/art/images/19",2),
("12","5","Soleil De Jade Lady ","50ml Edp","1943.00","available","/home/art/images/17",3),("13","5","Soleil De Lady ","75ml Edp","2475.00","no_available","/home/art/images/19",0),
("14","6","Scuderia Light Essence ","40ml Edt","878.00","available","/home/art/images/20",3),
("15","7","Amour Lady ","100ml Edp","3750.00","available","/home/art/images/21",2),("16","7","Jeu D'amour Lady ","30ml Edp","2363.00","available","/home/art/images/22",2),("17","7","Jeu D'amour Lady ","50ml Edp","3225.00","available","/home/art/images/23",4),
("18","8","Just Lady","30ml Edt","1125.00","available","/home/art/images/24",2);


DROP TABLE IF EXISTS `basket`; -- корзина
CREATE TABLE `basket` (
	`id` SERIAL PRIMARY KEY,
	`product_id` BIGINT UNSIGNED NOT NULL,
		
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id_products`) ON UPDATE CASCADE ON DELETE RESTRICT
); 

INSERT INTO `basket` (`product_id`) VALUES (1),(1),(3),(4),(5),(6),(7),(8),(9),(10);



DROP TABLE IF EXISTS `address`; -- адрес доставки товара покупателю
CREATE TABLE `address` (
	`address_id` SERIAL PRIMARY KEY,
    `country` VARCHAR(255) NOT NULL, -- страна
	`region`VARCHAR(255) NOT NULL, -- область, край и т.д.
	`city` VARCHAR(255) NOT NULL, -- город
	`street` VARCHAR(255) NOT NULL, -- улица
	`house` INT UNSIGNED NOT NULL, -- дом
	`apartment` INT UNSIGNED NOT NULL, -- квартира
	`postal_code` INT UNSIGNED NOT NULL, -- почтовый индекс
    
	INDEX (`city`)
);    


INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Kemerovo Oblast","Kemerovo","pobediy",64,72,413071),("russia","Kaluga Oblast","Kaluga","pobediy",237,33,545136),("russia","Arkhangelsk Oblast","Severodvinsk","Minina",100,44,413023),("russia","Astrakhan Oblast","Narimanov","Oktiabrskay",17,43,672640),("russia","Sakhalin Oblast","Sakhalin","molodezhnay",8,80,570973),("russia","Yaroslavl Oblast","Yaroslavl","Gogolia",21,33,670309),("russia","Ivanovo Oblast","Ivanovo","molodezhnay",53,69,396474),("russia","Kostroma Oblast","Kostroma","Pozharskogo",46,119,513650),("russia","Rostov Oblast","Rostov","Gogolia",11,6,353286),("russia","Belgorod Oblast","Stary Oskol","Minina",237,33,417530);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Ivanovo Oblast","Ivanovo","Pozharskogo",68,4,623063),("russia","Arkhangelsk Oblast","Shenkursk","Pozharskogo",186,60,594817),("russia","Orenburg Oblast","Orenburg","Lenina",57,112,495624),("russia","Sverdlovsk Oblast","Yekaterinburg","Lenina",85,90,406853),("russia","Astrakhan Oblast","Narimanov","pobediy",123,41,368119),("russia","Voronezh Oblast","Voronezh","Minina",136,58,499787),("russia","Kostroma Oblast","Kostroma","Gorkogo",104,98,491860),("russia","Nizhny Novgorod Oblast","Nizhny","Schedrina",64,26,437997),("russia","Nizhny Novgorod Oblast","Nizhny","Schedrina",89,66,359493),("russia","Tver Oblast","Tver","Schedrina",139,33,628254);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Penza Oblast","Penza","Pozharskogo",153,99,475129),("russia","Tula Oblast","Tula","50letVLKSM",64,36,493893),("russia","Ivanovo Oblast","Ivanovo","Gorkogo",110,89,670365),("russia","Sakhalin Oblast","Sakhalin","Gorkogo",52,91,508253),("russia","Rostov Oblast","Rostov","Pozharskogo",184,31,493411),("russia","Omsk Oblast","Omsk","Schedrina",32,78,637171),("russia","Penza Oblast","Penza","Gogolia",55,69,408876),("russia","Ivanovo Oblast","Ivanovo","molodezhnay",26,64,635854),("russia","Rostov Oblast","Rostov","50letVLKSM",46,9,518544),("russia","Novgorod Oblast","Novgorod","Minina",192,112,562124);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Murmansk Oblast","Murmansk","Minina",193,35,624239),("russia","Oryol Oblast","Oryol","Lenina",193,21,324214),("russia","Volgograd Oblast","Volgograd","molodezhnay",199,116,354064),("russia","Tomsk Oblast","Tomsk","Pozharskogo",60,13,601004),("russia","Sverdlovsk Oblast","Yekaterinburg","Minina",220,110,434520),("russia","Sakhalin Oblast","Sakhalin","Lenina",176,100,363875),("russia","Arkhangelsk Oblast","Mezen","pobediy",133,91,341511),("russia","Kostroma Oblast","Kostroma","50letVLKSM",24,52,396116),("russia","Kaliningrad Oblast","Kaliningrad","Schedrina",50,66,452079),("russia","Volgograd Oblast","Volgograd","Oktiabrskay",120,49,639083);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Kirov Oblast","Kirov","pobediy",190,12,476312),("russia","Smolensk Oblast","Smolensk","Gogolia",227,91,674342),("russia","Saint Petersburg City","Saint Petersburg","Minina",168,48,613629),("russia","Novosibirsk Oblast","Novosibirsk","50letVLKSM",215,11,403827),("russia","Novgorod Oblast","Novgorod","Gorkogo",113,18,332620),("russia","Kirov Oblast","Kirov","molodezhnay",113,2,509386),("russia","Smolensk Oblast","Smolensk","Gogolia",229,33,452508),("russia","Ivanovo Oblast","Ivanovo","Minina",204,117,666784),("russia","Nizhny Novgorod Oblast","Nizhny","Minina",211,102,555404),("russia","Bryansk Oblast","Sevsk","Oktiabrskay",64,35,449186);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Novgorod Oblast","Novgorod","pobediy",163,14,487731),("russia","Yaroslavl Oblast","Yaroslavl","Lenina",120,29,562863),("russia","Nizhny Novgorod Oblast","Nizhny","pobediy",240,42,431406),("russia","Amur Oblast","Shimanovsk","molodezhnay",63,9,357262),("russia","Novosibirsk Oblast","Novosibirsk","Schedrina",34,83,591720),("russia","Novgorod Oblast","Novgorod","Gorkogo",146,28,487643),("russia","Kaluga Oblast","Kaluga","pobediy",125,29,509406),("russia","Vologda Oblast","Vologda","50letVLKSM",179,43,421245),("russia","Kostroma Oblast","Kostroma","Gogolia",27,30,672599),("russia","Smolensk Oblast","Smolensk","Gorkogo",104,89,461031);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Leningrad Oblast","Gatchina","pobediy",13,31,380172),("russia","Tyumen Oblast","Tyumen","Schedrina",206,58,644344),("russia","Saratov Oblast","Saratov","Schedrina",22,13,666849),("russia","Smolensk Oblast","Smolensk","Lenina",54,101,577950),("russia","Amur Oblast","Zavitinsk","Schedrina",145,113,403407),("russia","Bryansk Oblast","Trubchevsk","Schedrina",224,40,436006),("russia","Ulyanovsk Oblast","Ulyanovsk","Lenina",203,51,584585),("russia","Kirov Oblast","Kirov","Gorkogo",122,93,353755),("russia","Novgorod Oblast","Novgorod","molodezhnay",242,84,414483),("russia","Penza Oblast","Penza","Oktiabrskay",14,90,390091);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Volgograd Oblast","Volgograd","Lenina",164,18,674876),("russia","Novosibirsk Oblast","Novosibirsk","Gogolia",209,24,326306),("russia","Chelyabinsk Oblast","Kasli","Lenina",202,81,505376),("russia","Ulyanovsk Oblast","Ulyanovsk","Gorkogo",32,25,645133),("russia","Vladimir Oblast","Vladimir","Schedrina",218,88,671885),("russia","Belgorod Oblast","Alexeyevka","Lenina",217,1,386869),("russia","Volgograd Oblast","Volgograd","Pozharskogo",24,109,480259),("russia","Kostroma Oblast","Kostroma","Gogolia",171,118,466840),("russia","Samara Oblast","Samara","molodezhnay",26,35,571808),("russia","Pskov Oblast","Pskov","Schedrina",180,71,487441);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Kursk Oblast","Kursk","pobediy",70,22,527731),("russia","Kemerovo Oblast","Kemerovo","Gorkogo",230,22,431487),("russia","Yaroslavl Oblast","Yaroslavl","Schedrina",49,116,376199),("russia","Sverdlovsk Oblast","Yekaterinburg","Minina",96,42,674511),("russia","Volgograd Oblast","Volgograd","Gogolia",175,28,450839),("russia","Orenburg Oblast","Orenburg","Schedrina",229,10,353973),("russia","Volgograd Oblast","Volgograd","Gogolia",131,2,605987),("russia","Kursk Oblast","Kursk","Gogolia",183,28,466469),("russia","Irkutsk Oblast","Irkutsk","Minina",88,121,612374),("russia","Murmansk Oblast","Murmansk","Pozharskogo",178,100,535247);
INSERT INTO `address` (`country`,`region`,`city`,`street`,`house`,`apartment`,`postal_code`) VALUES ("russia","Sverdlovsk Oblast","Yekaterinburg","Gogolia",169,98,658718),("russia","Lipetsk Oblast","Lipetsk","Oktiabrskay",12,57,477270),("russia","Kemerovo Oblast","Kemerovo","Gorkogo",103,82,653255),("russia","Kostroma Oblast","Kostroma","Gorkogo",151,79,350154),("russia","Tver Oblast","Tver","Schedrina",119,85,572440),("russia","Penza Oblast","Penza","Gogolia",141,43,360376),("russia","Magadan Oblast","Magadan","pobediy",23,21,360626),("russia","Nizhny Novgorod Oblast","Nizhny","Schedrina",181,44,659958),("russia","Tver Oblast","Tver","Lenina",242,61,396020),("russia","Samara Oblast","Samara","Gogolia",87,120,488225);



DROP TABLE IF EXISTS `users`; -- любой пользователь администратор, покупатель и т.д.
CREATE TABLE `users` (
	`id` SERIAL PRIMARY KEY, 
	`firstname` VARCHAR(255) NOT NULL,
    `lastname` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `phone` BIGINT UNIQUE NOT NULL, 
    `registration_date` DATETIME DEFAULT NOW(),
    `gender` CHAR(1),
    `birthday` DATE,
    `login_users` VARCHAR(255) UNIQUE NOT NULL,
    `password_hash` VARCHAR(255) UNIQUE NOT NULL,
    
    INDEX (`firstname`, `lastname`),
    INDEX (`birthday`),
    FOREIGN KEY (`id`) REFERENCES `address` (`address_id`) 
);

INSERT INTO `users` (`id`,`firstname`,`lastname`,`email`,`phone`,`registration_date`,`gender`,`birthday`,`login_users`,`password_hash`) VALUES 
("1","Dane","Xandra","eget.mollis@Vivamusnon.org","+79731035504","2020-05-16 00:19:53","M","09.06.20","Yvonne","ASP57YNN9NW"),
("2","Ursa","Declan","placerat.Cras.dictum@adipiscingMauris.com","+79731035534","2019-12-27 12:09:26","F","13.06.20","Deacon","JNN99TVI7DC"),
("3","Alea","Nerea","ut@nibh.edu","+79187001713","2019-10-24 04:55:14","F","09.01.20","Amena","JVR93BKB2SK"),
("4","Avye","Shoshana","gravida.Aliquam@necquamCurabitur.edu","+79005102580","2020-10-09 18:47:43","F","05.11.19","Cleopatra","EKL95SQE8GR"),
("5","Reuben","Lacey","porttitor@tristiquealiquet.com","+79387224006","2019-07-28 16:26:00","F","26.09.19","Daphne","XIT78DHM0XC"),
("6","Ori","Steven","mi@egestas.org","+73417334149","2019-05-16 05:11:01","F","23.04.19","Chandler","NJA78WAZ2CP"),
("7","Damon","Declan","ultrices@pedeultrices.net","+79101218070","2020-09-25 00:48:34","F","21.08.19","Kimberly","AOD40KJJ4VV"),
("8","Ahmed","Imelda","natoque.penatibus@Suspendisse.net","+73901725612","2020-04-29 11:28:21","F","20.07.20","Orla","JAJ54LIS4ZJ"),
("9","Sage","Walker","sit@pretiumaliquet.com","+78736715282","2020-11-14 08:50:19","F","11.03.19","Graiden","EAH59JCP0QT"),
("10","Sheila","Adrian","non.luctus.sit@elitpretium.co.uk","+73813336078","2020-11-11 12:08:18","M","03.05.20","Burton","IUO13YHW2RW"),
("11","Taylor","Noah","Lorem.ipsum@egestasa.com","+79552044634","2020-03-08 15:24:35","F","12.08.20","Katell","QGM42CVG8BG"),
("12","Buckminster","Kristen","est.mauris@arcueuodio.co.uk","+74941338354","2020-11-11 03:42:06","M","26.11.19","Amelia","EKZ25BNE3VS"),
("13","Kylan","Keith","vulputate@intempus.org","+79326170087","2020-10-30 08:23:21","M","08.05.20","Margaret","XCY86QDS5HH"),
("14","Nola","Fulton","auctor@Aliquamfringillacursus.org","+74813112281","2021-02-07 20:29:45","M","19.01.20","Ferdinand","WTB54IQF5LV"),
("15","Roth","Colorado","et@temporaugue.net","+78693010465","2020-06-21 00:17:08","M","26.08.19","Octavia","ASP45UWS9JK"),
("16","Hannah","Tallulah","vitae.sodales@IntegermollisInteger.ca","+79343089060","2019-03-19 15:29:22","F","20.03.19","Xandra","OQC62MVY6QK"),
("17","Farrah","Pearl","ipsum@a.com","+79767821327","2019-09-09 23:19:12","M","07.10.19","Brent","TLX06HDU8FZ"),
("18","Chase","Emmanuel","Mauris.nulla@Integertincidunt.co.uk","+78211712138","2020-09-24 03:54:32","F","31.03.19","Matthew","KHB52WDM5US"),
("19","Germaine","Kay","ut@mollisneccursus.com","+79918984032","2019-11-24 17:42:42","F","21.04.20","Tasha","RSH09POD7CQ"),
("20","Kristen","Giselle","sed@montesnasceturridiculus.com","+79803025163","2020-06-29 12:56:12","M","02.02.20","Cayin","ITO33UMC1TR"),
("21","Lucy","Malik","tristique.neque.venenatis@tellusjustosit.com","+73853878641","2019-04-17 10:42:46","M","07.03.20","Karina","NWJ19JMN6WI"),
("22","Michelle","Branden","lorem@magna.ca","+79304886707","2020-03-13 04:09:49","F","02.01.21","Flynn","JCA13BBS1WB"),
("23","Keegan","Maggy","est.tempor.bibendum@necurna.edu","+79304064030","2020-12-28 00:15:33","F","06.09.20","Craig","ECP71VCJ9CD"), 
("24","Hashim","Jessica","nisl.sem@Nam.edu","+79963005823","2019-06-26 18:32:46","F","06.04.20","Berk","GGK26TQL3WH"),
("25","Caleb","Vivien","orci.lobortis@nonegestasa.org","+73845562914","2020-03-26 12:13:32","F","11.02.20","Octavius","UYR52EDI8FM"),
("26","Urielle","Lunea","rutrum.magna@Donectempor.edu","+79374389453","2019-04-04 17:27:31","F","02.06.20","Jared","WFZ17AWX2AV"),
("27","Craig","Neve","cursus.a@risus.edu","+79178145809","2019-11-10 08:45:47","F","16.06.20","Alana","TWS81KIS9LW"),
("28","Otto","Isaiah","ante.ipsum.primis@consequat.com","+79687604903","2020-06-11 18:54:07","F","19.10.19","Cleo","JSU35PZQ8AV"),
("29","Kennedy","Keefe","Sed@elementumsemvitae.edu","+73019303760","2019-07-22 06:26:11","M","14.04.20","Devin","ECT72OPW4IV"),
("30","Lacey","Drake","nascetur@nonhendreritid.co.uk","+74118176199","2020-07-18 20:20:57","M","01.03.19","Trevor","GGK91EWG3MF"),
("31","Bradley","Ashton","vitae.mauris@Duisrisusodio.ca","+78798630398","2020-01-18 13:06:43","F","27.01.20","Noel","VVP32QPK2ZO"),
("32","Ulysses","Roary","non@DonecegestasDuis.co.uk","+79813210807","2019-10-27 14:34:31","M","26.07.20","Whitney","JKI03DPT3UV"),
("33","Adam","Aaron","Nunc.pulvinar.arcu@nislQuisquefringilla.ca","+79851907261","2019-08-09 13:54:15","M","29.09.20","Aristotle","ADO51OXB1ED"),
("34","Britanney","Bethany","elit.pellentesque@mollisnec.ca","+73651921101","2020-07-24 00:24:25","F","19.09.19","Daquan","LNF11TAN2WB"),
("35","Tyrone","Abdul","auctor.Mauris.vel@CrasinterdumNunc.org","+78414423421","2019-09-24 15:17:55","F","13.08.20","Brandon","TVO96TKM8QG"),
("36","Raven","Stone","lacinia@utipsum.co.uk","+74012170554","2020-04-16 05:28:50","F","13.04.20","Simone","VJW04PNE0SE"),
("37","Carolyn","Lavinia","Sed@egetipsum.co.uk","+78445692436","2020-01-04 10:56:25","F","16.10.20","Hilary","SSV43LSR7HU"),
("38","Venus","Dominic","dui.Fusce@facilisis.org","+74711287980","2019-11-26 16:49:56","F","30.08.20","Rhea","AVS05QJJ6IW"),
("39","Sloane","Lisandra","mauris.blandit@ultricessitamet.net","+79067261838","2019-06-07 09:34:31","M","13.05.19","Murphy","LQO32EWX6ON"),
("40","Hasad","Damian","magna.tellus.faucibus@ipsumdolor.net","+79947565370","2019-12-16 11:12:38","M","03.05.19","Carissa","QPI54COW1ND"),
("41","Lillian","Candice","sit.amet@sociosqu.com","+73457502691","2020-07-16 05:37:47","M","20.04.19","Cain","CUT53EXC5KF"),
("42","Ori","Jameson","nulla@tempor.co.uk","+79607727725","2019-08-29 17:40:38","M","14.01.21","Clayton","XTL15TLE4VH"),
("43","Rhiannon","Vaughan","libero@eget.co.uk","+79265223986","2019-05-01 11:18:52","M","18.11.20","Caldwell","VDT21GHI5AI"),
("44","Mariam","Bradley","sit.amet.luctus@erateget.org","+79084036220","2021-02-08 23:36:57","M","02.07.19","Fletcher","ZSR92ESH5MN"),
("45","Alfreda","Whitney","et.tristique.pellentesque@sedtortor.org","+78631414115","2021-01-10 19:22:06","F","17.08.19","Jackson","NUA40RWM0BP"),
("46","Keely","Owen","hymenaeos@auctor.org","+79443851984","2020-04-27 10:52:21","F","06.04.20","Jordan","XBL39UCR8FN"),
("47","Pamela","Courtney","at.velit.Pellentesque@velfaucibusid.org","+78419059486","2019-12-14 15:10:54","M","05.09.19","Grant","JXK38OTV1RA"),
("48","Kenneth","Emi","tellus@posuere.net","+74713068541","2021-01-13 02:50:39","M","04.07.20","Orson","TMY33EXT8WJ"),
("49","Herrod","Chancellor","eget.massa.Suspendisse@Duisrisusodio.net","+73847910689","2020-01-23 23:11:16","M","12.04.20","Perry","JKB87TRQ7BG"),
("50","Jin","Kameko","dui.augue@lacusAliquamrutrum.com","+79015083638","2020-08-23 23:59:38","M","07.01.21","Jordann","DJE56GES7DQ");



DROP TABLE IF EXISTS `administrators`; -- администраторы
CREATE TABLE `administrators` (
	`id` SERIAL PRIMARY KEY,
	`users_id`BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (`users_id`) REFERENCES `users`(`id`) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO `administrators` (`id`,`users_id`) VALUES (1,20),(2,48),(3,19),(4,1),(5,23),(6,28),(7,30),(8,3),(9,33),(10,33);


DROP TABLE IF EXISTS `managers`; -- менеджеры
CREATE TABLE `managers` (
	`id` SERIAL PRIMARY KEY,
	`users_id`BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (`users_id`) REFERENCES `users`(`id`) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO `managers` (`id`,`users_id`) VALUES (1,5),(2,22),(3,9),(4,16),(5,3),(6,10),(7,2),(8,13),(9,4),(10,22);



DROP TABLE IF EXISTS `customers`; -- покупатели
CREATE TABLE `customers` (
	`id` SERIAL PRIMARY KEY,
	`users_id`BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (`users_id`) REFERENCES `users`(`id`) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO `customers` (`id`,`users_id`) VALUES (1,40),(2,29),(3,15),(4,12),(5,46),(6,35),(7,34),(8,18),(9,38),(10,16);
INSERT INTO `customers` (`id`,`users_id`) VALUES (11,8),(12,15),(13,39),(14,39),(15,20),(16,3),(17,14),(18,43),(19,50),(20,12);
INSERT INTO `customers` (`id`,`users_id`) VALUES (21,16),(22,29),(23,40),(24,43),(25,33),(26,17),(27,39),(28,11),(29,49),(30,26);



DROP TABLE IF EXISTS `orders`; -- заказы
CREATE TABLE `orders`(
	`id` SERIAL PRIMARY KEY,
	`order_date` DATETIME DEFAULT NOW(), -- дата заказа
	`full_price` DECIMAL UNSIGNED NOT NULL, -- сумма
	`basket_id` BIGINT UNSIGNED NOT NULL,
	`user_id` BIGINT UNSIGNED NOT NULL,
	
	 INDEX (`user_id`),
	 FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
	FOREIGN KEY (`basket_id`) REFERENCES `basket` (`product_id`)
);


INSERT INTO `orders` (`id`,`order_date`,`full_price`,`basket_id`,`user_id`) VALUES 
(1,"24.07.19","52.00",5,4),(2,"25.01.20","01.00",1,6),(3,"27.01.20","40.00",5,12),
(4,"03.01.20","22.00",5,23),(5,"19.09.19","20.00",5,32),(6,"31.08.19","54.00",10,14),
(7,"17.03.19","23.00",1,35),(8,"31.08.19","27.00",3,25),(9,"29.09.19","40.00",9,12),
(10,"28.06.19","48.00",7,1);



DROP TABLE IF EXISTS `delivery`; -- доставка
CREATE TABLE `delivery`(
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(255) NOT NULL, -- наименование
	`description` TEXT, -- описание
	`date` DATETIME DEFAULT NOW(), -- дата 
	`in_order_user_id` BIGINT UNSIGNED NOT NULL,
	
	INDEX (`name`),
	FOREIGN KEY (`in_order_user_id`) REFERENCES `orders` (`user_id`)
);

INSERT INTO `delivery` (`id`,`name`,`description`,`date`,`in_order_user_id`) VALUES 
(1,"Dane Xandra","просп. Маршала Жукова, 49, корп. 1, Москва, Россия","2020-01-04 10:56:25","4"),
(2,"Farrah Pearl","Шелапутинский пер., 6, стр. 3, Москва, Россия","2019-07-28 16:26:00","6"),
(3,"Alfreda Whitney","Большая Садовая ул., 10, Москва, Россия","2020-03-26 12:13:32","12");


DROP TABLE IF EXISTS `popularity_products`; -- популярность продуктов
CREATE TABLE `popularity_products`(
	`id` SERIAL PRIMARY KEY,
	`user_id` BIGINT UNSIGNED NOT NULL,
    `products_id` BIGINT UNSIGNED NOT NULL,
    `created_at` DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (user_id) REFERENCES users(id ) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (products_id) REFERENCES products(id_products)
);

INSERT INTO `popularity_products` (`id`,`user_id`,`products_id`,`created_at`) VALUES 
(1,49,18,"2020-10-19 01:21:57"),(2,47,10,"2019-03-13 23:46:52"),(3,46,4,"2020-10-16 12:01:41"),
(4,39,3,"2019-05-07 01:35:49"),(5,6,2,"2019-09-21 14:17:04"),(6,47,12,"2020-11-15 11:03:33"),
(7,20,9,"2020-06-03 10:56:09"),(8,5,5,"2020-03-21 16:14:11"),(9,25,1,"2019-11-17 18:07:24"),(10,5,14,"2019-12-14 14:05:06"),
(11,5,9,"2021-01-11 19:20:45"),(12,43,14,"2021-02-11 00:39:44"),(13,47,2,"2020-06-21 21:47:13"),(14,25,18,"2019-05-27 22:12:33"),
(15,4,4,"2019-03-02 15:52:50"),(16,46,5,"2019-05-23 19:28:40"),(17,39,9,"2020-08-24 05:40:34"),(18,10,1,"2019-07-22 13:09:39"),
(19,10,16,"2019-07-03 22:55:33"),(20,37,3,"2019-11-10 09:11:39"),(21,13,16,"2020-04-13 21:04:36"),(22,22,11,"2021-02-17 01:10:33"),
(23,30,9,"2019-06-28 15:56:04"),(24,28,1,"2019-09-08 05:47:43"),(25,14,5,"2019-12-02 10:41:25"),(26,3,3,"2019-06-06 14:35:41"),
(27,42,2,"2020-12-04 10:02:07"),(28,36,16,"2019-04-04 15:47:00"),(29,2,18,"2021-01-18 08:25:16"),(30,27,10,"2019-06-15 16:19:36"),
(31,14,8,"2019-09-20 00:54:48"),(32,35,1,"2020-04-25 08:15:25"),(33,7,6,"2020-10-29 10:14:29"),(34,39,12,"2020-06-24 00:06:24"),
(35,16,17,"2020-04-26 22:04:22"),(36,38,13,"2020-06-29 00:12:17"),(37,6,2,"2019-04-22 11:03:04"),(38,16,12,"2019-05-25 04:15:39"),
(39,1,13,"2019-06-20 18:53:39"),(40,48,9,"2020-06-15 01:42:51"),(41,26,12,"2019-03-17 10:31:19"),(42,9,17,"2020-11-23 01:42:03"),
(43,35,4,"2019-05-02 05:17:36"),(44,18,16,"2020-10-05 20:00:52"),(45,22,1,"2020-09-04 05:02:09"),(46,35,8,"2020-02-04 14:39:31"),
(47,30,6,"2021-02-15 22:16:37"),(48,39,10,"2020-04-03 22:48:36"),(49,43,15,"2020-07-11 02:10:21"),(50,9,4,"2020-07-25 07:19:10");





				-- скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы)

SELECT name, description, price, amount_of_product FROM products -- товар в наличии с ценами
WHERE status = 'available';

SELECT pc.name AS category, p.name, p.price
FROM  products p
  JOIN product_categories pc ON p.product_categories_id = pc.id -- товар в наличии с ценами по категориям
WHERE status = 'available';

SELECT u.birthday, CONCAT(u.firstname,' ',u.lastname)AS customer,u.email  -- дни рождения пользователей покупателей
FROM users u 
 JOIN customers c ON u.id = c.users_id 
ORDER BY u.birthday;

SELECT CONCAT(users .firstname ,' ',users .lastname )AS administrators, users.email, users.phone -- список администраторов
FROM users 
WHERE users.id IN (SELECT administrators.id FROM administrators);
 
SELECT p.name, p.price, CONCAT(u.firstname,' ',u.lastname)AS customer -- список товаров в корзине у покупателя Xandra
FROM products p 
JOIN basket b ON b.product_id = p.id_products 
JOIN orders o ON o.basket_id = b.product_id 
JOIN users u ON u.id = o.user_id and u.lastname LIKE 'Xandra';

SELECT CONCAT(u.firstname,' ',u.lastname)AS customer, a.* -- список адресов покупателей
FROM users u
 JOIN customers c ON c.users_id = u.id 
 JOIN address a ON a.address_id = u.id;

SELECT SUM(p.price) AS `amount of items`,CONCAT(u.firstname,' ',u.lastname)AS customer -- сумма товаров в корзине покупателя Steven
FROM products p 
JOIN basket b ON b.product_id = p.id_products 
JOIN orders o ON o.basket_id = b.product_id 
JOIN users u ON u.id = o.user_id and u.lastname LIKE 'Steven'
GROUP BY customer;

										-- представления

CREATE OR REPLACE VIEW `managers_list` AS
    SELECT CONCAT(users .firstname ,' ',users .lastname )AS managers, users.email, users.phone -- список менеджеров
	FROM users 
	WHERE users.id IN (SELECT managers.id FROM managers);

SELECT * FROM managers_list;


CREATE OR REPLACE VIEW `customers_list` AS
    SELECT CONCAT(users .firstname ,' ',users .lastname )AS customers, users.email, users.phone -- список покупателей
	FROM users 
	WHERE users.id IN (SELECT customers.id FROM customers);

SELECT * FROM `customers_list`;

										-- хранимые процедуры / триггеры

DROP PROCEDURE IF EXISTS `popular_products`;  -- популярные товары (необходимо ввести количество)
DELIMITER $$
CREATE PROCEDURE `popular_products`(IN quantity INT)
BEGIN
	SELECT p.name, p.price, COUNT(pp.products_id ) AS popularity
	FROM products p 
 		JOIN popularity_products pp ON p.id_products = pp.products_id 
 		JOIN users u ON u.id = pp.user_id 
	GROUP BY p.name, p.price 
	ORDER BY popularity DESC 
	LIMIT quantity;
END $$
DELIMITER ;

CALL popular_products(10);



DROP TRIGGER IF EXISTS check_user_age_before_update;  -- триггер для операции обновления профиля  (дата рождения должна быть в прошлом)
delimiter $$
CREATE TRIGGER check_user_age_before_update BEFORE UPDATE ON users
FOR EACH ROW
begin
    IF NEW.birthday >= CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update Canceled. Birthday must be in the past!';
    END IF;
END $$
delimiter ;


DROP TRIGGER IF EXISTS check_user_age_before_update;  -- триггер для корректировки возраста 
delimiter $$
CREATE TRIGGER check_user_age_before_insert BEFORE INSERT ON users
FOR EACH ROW
begin
    IF NEW.birthday > CURRENT_DATE() THEN
        SET NEW.birthday = CURRENT_DATE();
    END IF;
END $$
delimiter ;






