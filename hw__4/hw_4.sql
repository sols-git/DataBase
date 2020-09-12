-- Практическое задание по теме “CRUD - операции”
-- 1. Повторить все действия по доработке БД vk.
-- 2. Заполнить новые таблицы.
-- 3. Подобрать сервис который будет служить основой для вашей курсовой работы.
-- 4. (по желанию) Предложить свою реализацию лайков.

SHOW DATABASES;

USE vk;
SHOW TABLES;

SELECT * FROM users LIMIT 10;

-- profiles
SELECT * FROM profiles LIMIT 10;


CREATE TEMPORARY TABLE sex (sex CHAR(1));
INSERT INTO sex VALUES ('m'), ('f');
UPDATE profiles SET sex = (SELECT sex FROM sex ORDER BY RAND() LIMIT 1);

SHOW TABLES;


-- messages
SELECT * FROM messages LIMIT 10;
-- тут с данными from_user_id и to_user_id вроде все нормально и делать рандом не надо

SHOW TABLES;
-- messages
SELECT * FROM media_types LIMIT 10;
-- тут тоже все норм

-- media
SELECT * FROM media LIMIT 10;
-- тут надо исправить media_type_id, user_id , filename, size и metadata
UPDATE media SET  media_type_id = FLOOR(1 + (RAND() * 3));
UPDATE media SET size = FLOOR(1 + (RAND() * 10000));
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));
UPDATE media SET filename = CONCAT('https://dropbox/vk/file_', size);
UPDATE media SET metadata = CONCAT(
  '{"', 
  'owner', 
  '":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
   '"}');
DESC media;   
ALTER TABLE media MODIFY COLUMN metadata JSON;


SHOW TABLES;
SELECT * FROM friendship LIMIT 10;
SELECT * FROM friendship_statuses LIMIT 10;
-- тут есть проблема с status_id, надо его поправить ну и остальные тоже можно
UPDATE friendship SET
  status_id = FLOOR(1 + (RAND() * 3)),
  user_id = FLOOR(1 + (RAND() * 1000)),
  friend_id = FLOOR(1 + (RAND() * 80))
;

SELECT * FROM friendship;

DESC friendship;

SELECT * FROM lang_statuses;
-- в замечаниях к предыдущему дз было указано на изменение названия таблицы, поэтому меняем
ALTER TABLE lang_statuses RENAME lanhuage;

-- создаем таблицу с постами
CREATE TABLE posts (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    titile TEXT NOT NULL,
    body TEXT NOT NULL,
    media_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

SELECT * FROM posts;
SELECT * FROM media;
SELECT * FROM posts;

-- заполняем ее псевдо данными, данные сгенерировал через http://filldb.info/ и вставлены копипастом из дампа (просто интересно было так попробовать)


INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (1, 8, 'Dolor at veniam voluptas error aut. Eum distinctio sed officia officiis quam enim.', 'Minima tenetur quibusdam ut. Quia voluptatem architecto est voluptates. Quaerat beatae quo porro voluptas id aperiam. Consequatur odio repellat dolores quae ratione reprehenderit provident. Aut saepe ratione dolores perspiciatis explicabo est.', 9, '1975-11-25 22:40:24', '1970-07-20 20:11:58');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (2, 1, 'Voluptatibus voluptatem occaecati soluta et voluptas. Nobis aut earum eum est odio enim sed.', 'Magnam corporis asperiores molestias commodi magnam quia. Praesentium maiores quo similique reiciendis. Saepe ratione iste molestiae ut natus sunt. Mollitia qui vero sint numquam quasi.', 9, '1999-07-27 00:52:08', '1998-06-12 08:43:52');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (3, 6, 'Libero ratione deserunt veniam iure.', 'Consequatur illum commodi error dignissimos ut qui. Aut vitae minima nesciunt vel qui nemo. Alias vero sit voluptatibus omnis pariatur. Ipsam atque deserunt deleniti dolor et molestiae voluptatem perspiciatis.', 7, '1987-01-26 08:34:55', '2016-06-11 07:05:57');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (4, 2, 'Quibusdam dolor quam eveniet accusantium.', 'Cupiditate at similique quia et facere magnam. Temporibus ut fugit ex tempore.', 6, '2013-08-04 21:24:43', '2009-07-28 13:44:40');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (5, 5, 'Id aut aut dignissimos dolore placeat tempore.', 'Occaecati blanditiis ut eaque et aut enim assumenda. Laborum dolor repellendus aspernatur. Pariatur quia voluptas reprehenderit ex dolorum veniam reprehenderit qui.', 6, '1978-07-29 23:49:46', '1980-07-06 21:20:58');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (6, 6, 'Voluptas nisi qui aperiam culpa dolor voluptatem. Voluptate delectus consectetur aut magnam qui similique.', 'Inventore qui sit et deserunt velit quam deleniti. Ducimus libero assumenda fugit nisi deserunt nisi laudantium.', 2, '1999-10-09 15:05:06', '1984-07-09 18:59:24');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (7, 5, 'Et laboriosam sunt molestias voluptatibus.', 'Et quaerat assumenda qui est. Dolor perferendis est et voluptatum dicta magnam sit. Voluptatibus architecto sint ut dolores repudiandae quaerat animi.', 5, '1987-01-25 02:51:18', '1991-06-06 09:01:53');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (8, 2, 'Voluptates ducimus non molestias voluptate dolor illum. Est commodi officiis ipsum.', 'Iusto voluptas expedita fugit aliquam pariatur dolor quia. Rerum necessitatibus eveniet consequatur nobis architecto ut.', 3, '1978-12-08 23:33:12', '2013-11-01 07:24:37');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (9, 6, 'Quis consequuntur et porro eaque cupiditate et harum. Non dolorem sequi id vero earum.', 'Ipsam accusantium eveniet tempora. Odio qui minima quam qui. Enim corrupti neque cupiditate fugiat explicabo. Ipsam eos sunt explicabo laborum iste veniam. Beatae sit ipsum quod nemo reiciendis eius suscipit itaque.', 5, '2008-05-06 09:06:36', '2005-04-18 12:02:43');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (10, 5, 'Sit ratione nam vel atque reprehenderit occaecati eum. Aut ea maxime autem enim quaerat eum.', 'Deleniti itaque nihil enim. Vitae laudantium voluptatum qui voluptatem. Laboriosam cumque iusto quod ab.', 6, '2011-07-07 05:54:00', '2002-11-03 17:10:49');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (11, 3, 'Dolores fugit quos et unde.', 'Cum est consequatur ipsam ea et provident minus. Alias non deserunt aut quaerat recusandae. Facere quae ex quos dolore voluptatem facilis.', 8, '2013-03-07 23:49:17', '1985-12-23 19:11:51');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (12, 7, 'Aut unde dolores delectus inventore delectus pariatur rerum.', 'Unde nobis qui recusandae ut quasi est omnis. Ducimus commodi ea quidem maxime et eum mollitia. Et et alias vitae iusto sit similique at.', 7, '1992-10-15 15:00:38', '2008-07-25 23:19:17');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (13, 2, 'Corporis itaque fuga nostrum cumque corrupti dolore dolores. Sed autem occaecati nam natus aspernatur ducimus beatae molestiae.', 'Beatae facere esse dolor dolores asperiores repellat consectetur. Aut quod recusandae quis laborum est eius. Corrupti accusantium ut doloremque quis.', 4, '1978-07-24 01:05:15', '1986-02-24 06:55:05');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (14, 1, 'Perspiciatis doloremque qui vero ullam ducimus.', 'Aliquid totam nisi nesciunt laborum ut explicabo excepturi. Omnis quaerat magnam tempora nam. Voluptas omnis vitae consequatur ab quas quia.', 7, '1993-08-04 23:58:36', '2002-08-25 09:05:56');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (15, 4, 'Hic eos aut optio sunt.', 'Assumenda quia amet blanditiis eligendi repellat ducimus magnam. Quia voluptas quia voluptatem assumenda hic sed. Rem velit qui laborum odit inventore neque. Architecto suscipit ullam et commodi molestias delectus.', 8, '2011-02-28 18:27:16', '1976-11-13 18:22:35');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (16, 3, 'Quia deleniti nisi quibusdam id.', 'Distinctio qui eos voluptas enim. Quisquam iure ipsum enim. Voluptatem magni dolor sit sit illum. Fuga quis officiis magni ut.', 2, '1975-02-03 22:13:18', '2000-12-08 13:29:02');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (17, 6, 'Blanditiis recusandae occaecati corrupti iste ut voluptatem.', 'Est voluptatum reiciendis voluptatem animi. Excepturi et blanditiis nihil qui ut. Quis et ea et molestiae non.', 8, '1974-08-24 00:37:40', '1977-02-25 03:19:24');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (18, 3, 'Ad consequatur in iure quaerat ut alias nisi. At rerum est odio est a ut corporis.', 'Sapiente nobis nam eum corrupti. Accusamus aut omnis recusandae aut vel atque. Sint nihil illo ratione ut.', 6, '1983-06-02 01:39:54', '1986-09-18 15:54:04');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (19, 4, 'Voluptatibus in fugiat ipsum unde veritatis ab tempore. Adipisci modi hic dolorem harum dolores.', 'Enim alias rem doloremque et soluta aut quaerat. Quibusdam qui earum qui earum. In nam qui aliquid molestiae quia doloribus tenetur. Quas soluta quo ducimus nostrum molestiae itaque neque.', 9, '1986-06-16 21:44:55', '1981-06-05 08:34:44');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (20, 5, 'Dolorem ipsum voluptates asperiores quos.', 'Asperiores dolor rerum veritatis quod deleniti. Eos deserunt nesciunt dolores sequi omnis repellendus. Aut sed aliquam praesentium tempore est officiis.', 4, '1972-04-16 03:38:53', '1986-11-25 21:04:20');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (21, 4, 'Veniam esse eligendi voluptatem ratione quaerat dolores quasi. Ducimus sed rerum sed possimus quo nulla est at.', 'Explicabo asperiores eum numquam adipisci qui. Nulla qui non quos aut optio dolorum dicta. Quis consequatur ullam qui sit. Veniam in et neque harum aut et quis.', 2, '1971-11-04 05:43:48', '1987-09-19 19:40:55');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (22, 9, 'Autem placeat nam neque amet. Commodi laborum ratione unde quae nihil praesentium error et.', 'Et quia eligendi quia non ut perferendis cumque qui. Odit soluta quia accusamus. Esse deserunt eaque est fugiat in suscipit. Qui quos ut nesciunt iure non aut eaque.', 4, '2016-03-09 00:07:32', '1986-12-23 12:52:42');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (23, 7, 'Vero quia laudantium culpa.', 'Eligendi qui aliquam dolorum mollitia. Adipisci eligendi sit veniam officia. Blanditiis rem illum hic consequatur eveniet.', 7, '2020-01-11 05:05:24', '1991-01-18 11:54:20');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (24, 7, 'Libero harum et perspiciatis qui modi repudiandae velit.', 'Non enim eum exercitationem adipisci optio. Quo rem facilis nostrum voluptas. Incidunt accusantium architecto pariatur consequatur. Expedita repellendus modi voluptate dicta maiores dignissimos et.', 4, '2011-07-20 12:59:24', '1995-09-03 02:01:09');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (25, 6, 'Saepe non fugit porro non nulla.', 'Commodi dolore magni nisi voluptatibus aut. Est itaque quidem pariatur commodi eum possimus inventore inventore. Quasi et voluptatem eaque rerum ut ex est. Voluptates magnam sunt ad illum repellendus qui. Excepturi voluptas ab est officia a rem.', 4, '2019-05-15 08:37:28', '1989-04-30 23:50:58');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (26, 7, 'Velit et odit fugit minima fugiat. Voluptas ad est sint cumque eius sequi.', 'Ea minima dolor nulla vero. Modi aliquid repellendus ut tempore. Quibusdam inventore labore consequatur rem autem.', 7, '2002-04-06 03:03:17', '1971-06-01 16:18:18');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (27, 5, 'Omnis aut laborum dicta provident sit.', 'Dolore voluptatem dolorem magnam voluptas nihil autem illo. Alias voluptatem sint est et error voluptas id libero. Omnis ut suscipit eligendi quo non. Tenetur temporibus dolorem voluptas.', 6, '1991-03-31 21:25:32', '2002-11-23 05:07:26');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (28, 2, 'A voluptas numquam omnis ut ea cum voluptatum.', 'Aliquam asperiores non aliquam quis rem pariatur quidem. Officiis enim et est impedit aut. Sunt consectetur eligendi consequatur ea suscipit velit aut.', 4, '2003-10-02 03:20:14', '2015-08-08 22:06:49');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (29, 4, 'Quibusdam cupiditate culpa voluptatem.', 'Nam ad maxime maxime illo. Quaerat sunt cupiditate vel et rem molestiae ipsa. Reiciendis non nam quo. Harum rem maxime harum itaque aut.', 3, '1986-06-14 16:26:02', '1977-04-08 09:32:04');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (30, 3, 'Dolore dignissimos expedita magni voluptatem eum aspernatur voluptatem. Ut dolor in facere quo dicta autem laboriosam.', 'Quia minima magnam voluptates. Ipsa consequatur iusto ad quidem. Cupiditate corporis beatae molestiae aliquid.', 4, '1988-12-28 14:01:33', '1970-03-09 04:36:15');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (31, 1, 'Atque omnis sit alias sequi autem dolorum earum. Dicta dolores fugit aut non et ut labore dolorem.', 'Itaque eos molestias itaque eaque qui nam. Asperiores repudiandae velit repellendus aut doloremque in. Voluptatum esse eveniet inventore architecto non ut et.', 8, '1987-11-04 09:20:33', '1998-10-27 02:32:26');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (32, 5, 'Est rerum vitae est. Facilis rerum nesciunt voluptates quam.', 'Rem quibusdam laudantium sint. Ut sed nihil similique possimus iusto. Aliquid cumque sit facere expedita iure deserunt. Ut aut tempora reprehenderit commodi hic cupiditate.', 7, '1998-08-03 10:21:17', '2006-10-12 21:14:13');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (33, 3, 'Molestiae eos omnis qui earum voluptas inventore dolore ut. Provident reprehenderit odio velit.', 'Saepe ea eos eligendi ipsam. Aut exercitationem similique dolor quia aliquam amet. Voluptatibus veritatis dolorum repellat aut. Mollitia perspiciatis laudantium minus voluptatibus nam aut provident. Aut voluptas in voluptatem aut nisi.', 5, '2003-11-06 19:47:40', '2012-08-16 12:58:19');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (34, 1, 'Atque et ab non ex minima quis soluta. Est molestiae tempore et a culpa eos praesentium.', 'Est est omnis alias commodi magni qui incidunt ullam. Dolorum ad veritatis cum vero reprehenderit velit excepturi. Possimus blanditiis illo est. Et quibusdam amet explicabo qui et.', 2, '1970-06-12 19:10:49', '1979-10-06 20:13:18');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (35, 1, 'Hic quae nostrum amet quis non sed ab.', 'Nemo id ullam ipsa. Voluptatem et dignissimos ea beatae quo nisi necessitatibus. Iure est aut eaque. Tempore ea ratione sit voluptas quod qui.', 1, '2012-07-15 16:35:18', '1979-02-07 16:41:54');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (36, 8, 'Dolores ex est neque aut eum excepturi eum. Tempore at consequatur sed delectus porro.', 'Fugiat at eaque labore at rerum. Consectetur corporis tenetur molestiae laudantium omnis sed. Aliquam corporis esse accusantium rerum deserunt.', 7, '1984-01-31 12:23:01', '1970-06-25 14:04:13');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (37, 8, 'Vitae voluptas quidem fugit dolor animi.', 'Aliquid rerum a quis autem officiis consequatur mollitia. Voluptas ut quo dignissimos quo.', 6, '1974-11-18 15:17:05', '1992-12-19 22:14:59');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (38, 3, 'Et vel voluptatem dolorum optio. Asperiores dolorem iste porro ut unde aspernatur.', 'In incidunt enim veritatis adipisci occaecati deleniti. Quidem est perferendis asperiores. Eos blanditiis assumenda enim culpa cupiditate harum ea. Quo vel fugiat et voluptatem quo et maxime.', 8, '2001-08-04 05:48:44', '1986-04-07 14:46:30');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (39, 8, 'Odit fugiat quia sit est ullam ipsum. Rerum nemo necessitatibus quia est cupiditate.', 'Excepturi reiciendis in ut iure pariatur nihil. Aut animi odit aut. Ut enim sit voluptatem et illo eius.', 8, '1993-10-03 22:20:59', '2016-09-15 07:24:40');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (40, 9, 'Corporis voluptatum culpa similique illo sint fuga. Consequuntur quae sit perferendis iusto.', 'Dignissimos consequuntur accusamus sed beatae nisi ullam. Ducimus earum sed omnis deleniti enim. Quibusdam reiciendis eos qui earum doloribus nesciunt itaque. Consequuntur cupiditate et laboriosam quaerat praesentium iste. Quo assumenda nostrum et totam qui et similique.', 5, '1976-06-09 08:56:45', '1993-12-14 06:59:51');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (41, 3, 'Culpa ab ullam quo alias nobis magnam. Vel facilis sed adipisci suscipit.', 'Et ab voluptatum neque nulla ut sunt quos. Nam porro quod hic ut. Et facilis temporibus aperiam assumenda nostrum ipsum adipisci. Aliquam minima minima hic.', 7, '1998-10-16 12:56:10', '2004-06-21 13:16:50');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (42, 6, 'Dolor quaerat magnam ad cupiditate eaque nam impedit. Optio dolor ipsam ab deleniti labore ullam.', 'Et nisi sint accusamus placeat ad. Labore qui consectetur asperiores maiores. Qui libero praesentium explicabo culpa et dicta. Possimus velit id assumenda voluptatibus iusto optio suscipit.', 5, '1981-10-16 18:44:16', '2000-08-15 18:53:33');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (43, 2, 'Voluptatem consequatur ut voluptate non provident. Voluptatem ex sed cum id omnis quod explicabo animi.', 'Id optio beatae earum natus neque. Nihil commodi sunt maiores ad. Molestiae voluptas optio ex numquam tempore ipsam enim.', 5, '2009-09-14 14:47:44', '1976-01-15 12:57:49');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (44, 9, 'Cumque natus rem impedit praesentium voluptatem.', 'Culpa praesentium fuga odit velit. Similique voluptatem mollitia dolorum officia eum. Nihil praesentium ut vitae alias.', 2, '1999-02-04 10:02:52', '2006-12-16 07:04:28');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (45, 4, 'Ipsam ipsam aliquam fugit beatae qui consectetur cumque.', 'Amet dolor inventore autem dolorem cum amet. Et provident quis consequatur nobis ut incidunt nulla. Occaecati nemo qui vero odio ut modi animi. Occaecati molestiae tempore corporis et beatae delectus libero quo.', 9, '2013-10-28 04:00:55', '1997-12-21 15:28:52');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (46, 6, 'Ipsam nobis pariatur officiis illum sequi facilis.', 'Nam animi nisi laboriosam qui in a minima provident. Maxime deleniti culpa voluptatum tempore ipsa. Dicta impedit sit enim maxime ut autem. Molestiae est deserunt quasi voluptas sint.', 7, '2000-11-10 21:07:06', '1987-04-15 11:31:13');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (47, 2, 'Asperiores nobis quia repellat odio aut.', 'Nisi laboriosam cumque tenetur eligendi ut error. Voluptatibus porro a id nulla officiis repellendus. Eos delectus esse ducimus quibusdam totam rem qui. Corporis similique sit dicta maiores nihil provident.', 1, '2019-09-14 14:22:27', '2016-05-02 02:18:14');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (48, 3, 'Exercitationem quasi delectus distinctio est.', 'Recusandae velit dignissimos quibusdam. Amet veniam qui est. Corporis ad optio iure tempora quasi. Tempora omnis architecto dolorem quia fugiat officiis laboriosam.', 1, '1990-02-04 18:48:30', '2019-11-02 12:47:50');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (49, 4, 'Amet pariatur vel laudantium eum.', 'Dolorem corrupti corporis et. Illum nesciunt deserunt error suscipit. Perferendis reprehenderit qui nostrum ex eum.', 4, '1992-02-08 11:47:56', '1999-08-03 21:23:54');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (50, 1, 'Ullam iste repellendus dignissimos error. Illo itaque aut ullam nihil aut.', 'Dolores est enim ab veniam delectus. Voluptas eos omnis eligendi atque et. Quia dolores est assumenda ex facere mollitia assumenda. Incidunt qui ipsam suscipit quaerat vitae et quia.', 5, '1995-03-24 07:19:48', '2007-09-04 00:25:44');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (51, 7, 'Molestiae aut aut aut necessitatibus voluptas eum eius. Eveniet consequuntur est eos asperiores magnam et.', 'Ea reiciendis dolorem molestiae id voluptas maiores perspiciatis. Minus sapiente nulla et quia. Rerum et nesciunt commodi non nihil aliquid exercitationem. Soluta rem libero fugiat soluta dolore. Soluta consequatur soluta veniam quibusdam.', 5, '2000-08-28 00:12:54', '2004-09-18 20:36:01');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (52, 7, 'Odio eveniet totam voluptatem.', 'Aspernatur nam animi quo quo voluptas. Voluptas ut dolores corrupti ut quis eveniet voluptas. Nihil repudiandae excepturi hic iusto architecto magnam necessitatibus.', 4, '2012-02-19 06:07:57', '2001-06-15 19:11:15');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (53, 2, 'Eum aperiam recusandae perspiciatis ea veniam. Eaque aut et quia accusantium praesentium sint.', 'Enim dolore consequatur asperiores qui ut ut hic sequi. Sit sed eligendi consectetur beatae autem nesciunt ipsam.', 3, '1979-08-04 05:40:49', '1977-06-26 14:37:27');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (54, 1, 'Commodi quia necessitatibus rem rerum ipsam magnam iure.', 'Velit enim laborum suscipit enim quo tenetur sed. Consequatur veniam iure voluptatem quae et. Harum sed sunt atque dicta debitis dolor harum.', 6, '2017-10-09 00:11:56', '2013-01-14 13:31:02');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (55, 5, 'Qui cupiditate deserunt natus impedit molestias quia. Ut perferendis earum ad voluptatem.', 'Dolorum voluptatem accusamus voluptas animi quia ut sit labore. Est dignissimos soluta molestiae sunt perferendis nobis. Nisi rerum vel libero nihil nobis repudiandae. Non voluptas assumenda beatae ex quis.', 2, '1991-08-11 20:44:10', '2003-12-01 04:35:43');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (56, 1, 'Maiores cum exercitationem debitis facere distinctio dignissimos beatae. Minus aut itaque quasi excepturi itaque aliquid.', 'Qui voluptatibus rerum dolores sint est vel. Placeat ut eos beatae dolorem accusamus. Amet quia autem qui corporis.', 7, '1975-04-28 18:14:09', '2006-05-12 16:06:11');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (57, 4, 'Animi dolorum atque ut ipsam autem fugiat.', 'Dolor soluta molestiae unde similique provident. Cupiditate molestiae maxime dolor ab omnis dolorem.', 7, '2001-07-11 09:19:23', '1982-07-22 13:00:24');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (58, 3, 'Sequi consequatur officiis nulla ut sint rerum assumenda. Libero qui suscipit non ut quia ratione.', 'Voluptatem blanditiis cumque voluptas fugit tempore quod ut. At qui quae ullam. Natus nam sapiente beatae perferendis et. A qui voluptatem molestiae est odit.', 2, '1986-11-29 00:03:38', '1997-03-07 05:18:31');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (59, 9, 'Facilis eius provident est vero.', 'Vero voluptatem rerum laudantium recusandae explicabo illum nobis. Et sit aperiam ut sequi ut eaque. Aut nihil laboriosam ut et quasi qui. Ea ipsa debitis ipsa nihil consequatur nemo nulla.', 8, '2019-03-26 17:38:45', '2015-08-22 19:11:46');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (60, 7, 'Ad maxime voluptas consequatur repellendus labore exercitationem. Recusandae inventore delectus ab.', 'Molestiae dolorum ut tempora. Consequatur vel iste perspiciatis debitis. Nihil excepturi rem eligendi qui et qui.', 1, '1990-01-18 19:33:28', '1974-03-16 18:34:01');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (61, 4, 'Voluptas tempore eum voluptatum non vel consequuntur.', 'Praesentium sed blanditiis aliquid ut omnis. Quis est possimus accusamus est. Doloremque voluptas voluptas impedit iure.', 7, '2005-03-09 15:39:49', '1981-01-14 14:38:05');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (62, 9, 'Consequatur tempora distinctio ipsam possimus qui aut aspernatur. Praesentium est ut animi sapiente rerum blanditiis nulla.', 'Non nemo aut enim quisquam vitae. Ad repudiandae quia voluptas qui rerum modi quam ipsum. Occaecati ad neque nihil iusto sit est. Consequuntur voluptate nihil voluptas dolores nesciunt aut error est.', 1, '1993-07-22 18:10:57', '1995-11-17 05:06:14');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (63, 3, 'Ut qui provident omnis asperiores sunt.', 'Blanditiis qui consequatur recusandae blanditiis est et temporibus odit. Esse nisi et sit non illo aut. Rem corporis et debitis eius iusto voluptates.', 6, '1982-01-08 16:39:47', '1998-10-14 17:35:38');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (64, 5, 'Esse sint voluptatem quam praesentium non explicabo. Dolorem porro et odit aliquid quia distinctio blanditiis aut.', 'Doloremque officiis vel ipsum in quis itaque excepturi non. Vitae officia vel amet tempora nisi tenetur. Blanditiis ut facilis non quis.', 6, '1999-06-23 01:08:52', '1990-02-07 00:54:54');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (65, 8, 'Nesciunt recusandae rem provident.', 'Mollitia alias qui ut mollitia eum. Et cupiditate eum earum eius architecto vero. Eum dicta aut et cupiditate eaque.', 5, '2004-11-10 10:15:47', '1983-02-27 15:53:58');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (66, 8, 'In quaerat officia sed recusandae.', 'Quo et nostrum sit est ipsa dignissimos cum. Quo est aliquam fugiat adipisci voluptatem. Harum nihil aut itaque natus culpa. Voluptas iste est aut ab aut ad suscipit.', 5, '1979-03-05 21:17:50', '2004-10-02 02:22:16');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (67, 7, 'Ratione in ut sed eveniet consequatur ad. Aspernatur temporibus et qui quo eveniet.', 'Est assumenda doloribus ut hic eum minima sed sint. Sunt corporis non quaerat aut sunt consequatur voluptates. Praesentium autem eum aut. Cum vel officiis iste iusto aspernatur.', 1, '1999-10-09 01:00:38', '2013-04-24 14:48:43');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (68, 3, 'Omnis magnam impedit eum sed qui impedit quis quaerat. Accusamus ab ea autem laboriosam adipisci molestiae eligendi.', 'Et dolores similique rerum optio unde. Voluptatum rerum quis et blanditiis harum voluptas est. Temporibus eos fuga ut qui ab iste officia voluptatem. Exercitationem facere suscipit doloremque.', 6, '2016-09-23 18:47:30', '2011-12-02 20:42:55');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (69, 1, 'Quae sed doloremque incidunt rerum tempore pariatur. Sapiente placeat nobis inventore fugiat eius.', 'Et dolorem voluptatem inventore placeat sapiente. Voluptate minima excepturi minus enim esse modi.', 8, '2018-07-16 05:29:02', '2017-05-28 04:18:54');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (70, 3, 'Et sint nam ducimus nihil. Ex aspernatur dolor aliquam ex quo.', 'Voluptatem et ut rerum dicta harum. Natus iste voluptas hic commodi repudiandae illum iure. Sunt optio dolor voluptatem magni.', 9, '2018-02-23 16:54:19', '1984-03-07 11:19:21');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (71, 2, 'Quia eos reprehenderit modi amet tenetur molestias aut fuga. Ipsa quibusdam voluptatem corrupti eligendi omnis.', 'Aut quia ea modi et ratione cupiditate. Et dolorem et doloremque possimus quisquam molestiae vitae pariatur. Nobis repellendus sunt atque temporibus eligendi autem atque.', 2, '1978-10-06 12:32:59', '1996-11-22 17:35:37');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (72, 5, 'Distinctio laborum et odio dolor.', 'Voluptatem et inventore illum deleniti. Voluptatum deserunt fugit debitis id et ut sit optio. Excepturi nemo et voluptatibus ea sed quia. Sint nihil non temporibus dignissimos voluptatem.', 8, '1987-03-14 07:12:41', '1987-11-05 21:42:26');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (73, 8, 'Deserunt accusamus qui amet consectetur minima doloremque molestiae.', 'Animi consequatur quas qui in et sint rerum cupiditate. Aut culpa expedita dolorum dolor a quisquam est. Cupiditate alias aliquam aut error corporis quaerat incidunt accusantium.', 6, '2007-06-07 01:36:30', '2011-07-06 17:50:46');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (74, 1, 'Maxime et dolore placeat provident.', 'Omnis veniam ex dignissimos ut et a totam eos. Ex voluptas fuga molestiae officia incidunt explicabo incidunt. Nesciunt accusantium et ea non omnis delectus soluta laborum.', 8, '1983-12-10 07:16:08', '1998-11-15 04:52:19');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (75, 3, 'Voluptatem vel molestiae quos. Id natus sequi nesciunt ut rerum quia.', 'Repellendus amet inventore reprehenderit facere aut ut voluptatum. Dolor esse sit et. Vel quis dicta sunt voluptatem pariatur quia.', 3, '1985-02-10 18:07:34', '1993-12-31 17:47:11');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (76, 2, 'Voluptatem officiis qui nesciunt ut soluta. In veniam eligendi dolorum officia quidem sed.', 'Sit non nostrum sed numquam qui vero. Soluta blanditiis vero consequuntur voluptates. Eum consectetur reiciendis commodi alias error perferendis.', 2, '1987-06-25 23:31:19', '1990-04-28 14:36:51');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (77, 1, 'Qui dignissimos corrupti voluptatem dolorem. Consequatur necessitatibus itaque in.', 'Voluptates nesciunt ut sed accusantium maiores rem ad. Facere quidem aliquid corporis voluptatem voluptas. Excepturi voluptas accusantium iste. Unde tenetur nihil vitae assumenda maxime ex sapiente earum.', 2, '1986-01-21 11:02:08', '1972-06-26 21:21:32');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (78, 1, 'Temporibus qui suscipit vel esse quo voluptatem numquam. Maiores et iste at ex eum accusamus.', 'Esse culpa quia sint. Ratione odit harum rerum eos. Sunt omnis ea enim esse aut.', 9, '1978-03-12 23:56:25', '2003-07-08 05:07:11');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (79, 2, 'Ut repudiandae corporis dolores quidem quam unde rem. Quod dolore officiis et molestiae voluptatum sed.', 'Quasi sint sed doloremque corporis omnis ut quaerat. Perferendis quia vitae natus rem. Necessitatibus est maiores et animi culpa dolore.', 3, '1991-11-24 22:50:18', '2011-04-18 02:41:00');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (80, 5, 'Odio et a eum aut sint laborum similique.', 'Omnis nostrum soluta aut blanditiis. Voluptatem iste dolores ut libero non. Inventore aliquid praesentium officiis iusto aperiam voluptas ut error. Maiores molestiae quam ut assumenda ullam repudiandae ut.', 5, '1977-12-03 15:14:46', '1993-05-25 12:53:31');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (81, 8, 'Ea voluptatibus praesentium asperiores non provident et magni similique. Qui quia quisquam hic id quia dolor.', 'Porro est natus perferendis illo culpa. Aspernatur sed assumenda consequatur natus a. Laborum dolorem et quas fugiat voluptatem. Illum ratione harum omnis minima corporis autem debitis perferendis.', 7, '2007-05-24 16:39:08', '2015-08-20 21:57:34');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (82, 9, 'Ut eaque nesciunt est vel facere architecto.', 'Esse dolorem odio amet aspernatur. Eveniet aliquid corrupti explicabo et qui. Nobis neque quis mollitia sequi soluta in at.', 7, '1979-06-09 10:00:53', '1989-09-08 05:56:07');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (83, 5, 'Quas provident maiores possimus et dolores adipisci atque.', 'Et consequatur error voluptas voluptatem quisquam. Id nostrum labore ducimus eligendi eum sit voluptas. Praesentium ab enim quidem earum laborum nam et. Minima magnam officiis libero totam sit. Qui adipisci quos molestiae quae et ab aspernatur.', 1, '1977-03-26 02:51:32', '1995-11-24 12:04:58');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (84, 9, 'Asperiores aut ut dolor. Qui odio repudiandae assumenda eligendi fuga dolore possimus.', 'Officiis necessitatibus et vel aliquid. Blanditiis molestiae iste et amet esse alias sed. Repellendus est aperiam eos ut eius consequatur. Vero inventore nisi quasi quas ut odit.', 9, '2017-06-19 20:45:46', '2012-02-20 17:37:13');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (85, 3, 'Dolore iusto in quia aliquid a at. Quis autem veritatis fugiat exercitationem voluptatibus eum.', 'Assumenda ratione est ad nam ex. Et facilis itaque dolorum porro consequatur est. Laboriosam quis est autem non.', 6, '2011-02-05 01:27:57', '2009-12-19 00:46:20');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (86, 6, 'Iste odio est laudantium deserunt sed.', 'Natus dicta nobis magni. Dolorem et temporibus quam ullam consequatur sint. Sed et eos facilis laudantium. Accusamus exercitationem maxime mollitia mollitia dolor quas accusantium.', 7, '2007-09-29 11:27:30', '1999-11-16 08:51:41');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (87, 3, 'A recusandae reprehenderit suscipit quo repellendus at.', 'Ipsa id consequuntur adipisci et quae rerum mollitia. Maiores consequatur architecto impedit sunt. Dignissimos numquam est provident libero officiis est debitis. Ullam eligendi beatae maxime in nulla qui accusamus.', 9, '1984-03-28 19:48:10', '1989-10-15 21:39:35');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (88, 1, 'Occaecati rerum distinctio veniam fugiat iure. A est aut blanditiis id vel.', 'Adipisci consequatur aut qui deleniti expedita sed. Itaque sit quibusdam accusantium omnis et. Dolore quo officia eum quia nam asperiores molestias. Ipsam itaque expedita nobis rem corrupti cupiditate vel. Vel eos consequatur qui sed et earum iusto.', 5, '1988-01-21 05:21:56', '1990-04-26 11:24:22');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (89, 8, 'Voluptatum accusamus aut eum. Blanditiis dolor et numquam consequatur perferendis tempore sapiente.', 'Et aut aut non corrupti minima et. Cumque velit necessitatibus commodi. Architecto autem corrupti odio ratione autem facilis culpa. Numquam quis nihil quisquam enim tempore consequuntur.', 6, '2017-11-11 21:03:41', '1978-04-10 00:41:51');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (90, 8, 'Id eum accusantium reprehenderit explicabo fugit mollitia vel. Sunt deserunt est eum consequatur officiis.', 'Repellendus minima et et. Magni enim eius sapiente consectetur. Repellat laborum eaque qui et dolorum voluptatem molestiae. Fugiat odio provident eos quia ratione.', 3, '2015-11-23 12:07:39', '1992-12-05 04:31:11');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (91, 2, 'Et nihil blanditiis natus enim explicabo cupiditate reiciendis impedit. Enim dolores quisquam soluta quae inventore est ipsum.', 'Magnam reprehenderit ratione unde incidunt esse consectetur maxime. Id sit consequuntur quod voluptatem enim. Impedit autem qui fugiat quo odit nostrum nobis.', 7, '1974-11-03 17:23:21', '1985-08-02 18:24:18');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (92, 5, 'Esse qui laboriosam perspiciatis ab. Iusto aut corporis maiores impedit blanditiis corrupti.', 'Quis suscipit labore enim aliquid rem. Ea rerum maxime impedit autem harum mollitia. Alias officiis quod totam ut saepe.', 4, '1993-08-24 01:51:20', '2018-07-29 06:49:10');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (93, 6, 'Officiis voluptatem et dolor excepturi totam voluptas quam.', 'Eaque fugiat ullam ab cum ut est accusamus. Aut quo nihil omnis delectus deleniti impedit. Dolore aliquid officia quae molestias. Sed aut architecto corporis aut laborum unde et.', 6, '2010-04-17 09:07:27', '2013-10-25 21:14:57');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (94, 9, 'Rem exercitationem esse culpa repellendus qui voluptatum ad.', 'Est optio impedit excepturi debitis. Eum sunt eveniet libero ratione at a non voluptas. Occaecati dicta reiciendis odit perferendis dicta ut beatae.', 7, '1982-03-22 14:02:37', '2019-10-26 05:34:18');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (95, 6, 'Sunt eum velit inventore doloribus voluptas ipsum. Omnis voluptas sunt impedit.', 'Voluptatibus quod doloribus tempore deserunt. Maxime incidunt alias ipsam ea molestias impedit. Facere voluptatem eaque ullam. Eum corrupti rem blanditiis enim illum fugit quasi. Officia repellat et consequatur adipisci saepe perspiciatis.', 9, '1985-04-26 21:43:54', '1991-06-25 00:32:38');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (96, 2, 'Dolor voluptas incidunt asperiores velit recusandae eos.', 'Dolores vitae explicabo iusto mollitia pariatur facilis minus. Quo nihil eos asperiores voluptas aliquam quos sit. Omnis et libero beatae aliquam optio qui voluptatem aut.', 6, '1996-04-19 06:51:02', '1971-09-21 16:16:48');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (97, 9, 'Architecto illo repellendus cum.', 'Quia delectus deserunt nobis repellat vitae. Cumque vel cumque dolorum nulla eos at. Distinctio sunt rem ad aut error et. Vero nobis dignissimos hic dolores nesciunt est quas ea.', 6, '1991-10-09 16:07:52', '1977-08-07 01:32:21');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (98, 1, 'Dolor ut voluptatibus doloremque ut facere.', 'Dolores vitae iste adipisci consequatur eum. Hic consequatur aut quisquam rerum fuga cupiditate voluptas laboriosam. Dolor saepe ex et omnis.', 4, '1993-10-07 06:35:06', '2007-09-19 12:14:42');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (99, 2, 'Ut quod aut magnam vel. Sunt voluptatem quia sit repellendus consequatur et.', 'Ipsa similique ea sapiente delectus. Pariatur sed esse voluptas neque magni a. Corrupti esse voluptas quaerat corrupti sit quia.', 5, '2019-08-05 15:41:44', '1976-08-23 09:36:57');
INSERT INTO `posts` (`id`, `user_id`, `titile`, `body`, `media_id`, `created_at`, `updated_at`) VALUES (100, 9, 'Occaecati similique quo voluptas architecto.', 'Corporis rerum non voluptas nostrum dolorum natus. Animi dolore quae non possimus. Voluptate nam rerum vero reprehenderit.', 2, '1975-08-06 05:05:39', '2001-02-01 23:55:26');



SELECT * FROM communities;

-- communities ограничиваем количество сообществ
DELETE FROM communities WHERE id > 20;

SHOW TABLES;

SELECT * FROM communities_users;
-- корректируем данные
UPDATE communities_users SET
  community_id = FLOOR(1 + (RAND() * 20)),
  user_id = FLOOR(1 + (RAND() * 300))
;


-- смотрим как лучше сделать реализацию лаков
-- нужно знать какой тип лайк или дизлайк, значит нужны типы
CREATE TABLE type_likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL UNIQUE
);
SELECT * FROM type_likes;
-- теперь заполним 
INSERT INTO `type_likes` (`name`) VALUES ("like");
INSERT INTO `type_likes` (`name`) VALUES ("dislike");

SELECT * FROM media;
SELECT * FROM posts;
SELECT * FROM messages;

-- создаем таблицу с лайками с учетом замечаний в лекции
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id INT UNSIGNED NOT NULL ,
  to_user_id INT UNSIGNED NOT NULL ,
  type_likes_id INT UNSIGNED,
  media_id INT UNSIGNED ,
  posts_id INT UNSIGNED ,
  messages_id INT UNSIGNED  ,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
 );
SELECT * FROM likes;
-- и заполним таблицу лайков

INSERT likes(id, from_user_id, to_user_id, type_likes_id, media_id, posts_id, messages_id, created_at) 
VALUES
  (1, 3, 1, 1, 8, 7, 6, '2002-02-21 00:34:15'),
(2, 5, 9, 8, 3, 5, 7, '2000-11-17 07:17:35'),
(3, 2, 2, 1, 7, 9, 6, '1981-07-05 04:52:04'),
(4, 6, 6, 8, 5, 7, 7, '2008-12-10 06:05:02'),
(5, 7, 6, 8, 6, 9, 7, '1971-02-11 10:29:31'),
(6, 4, 4, 8, 7, 7, 1, '1997-10-14 00:30:09'),
(7, 4, 4, 8, 7, 8, 1, '2018-07-05 11:46:10'),
(8, 2, 5, 3, 6, 1, 9, '1981-09-03 21:14:28'),
(9, 6, 4, 3, 6, 1, 5, '2002-03-13 03:44:30'),
(10, 2, 3, 4, 6, 5, 8, '1990-12-30 11:22:49'),
(11, 7, 4, 7, 4, 3, 5, '1970-07-18 16:20:03'),
(12, 1, 6, 5, 4, 5, 2, '2002-05-04 23:24:48'),
(13, 3, 2, 7, 8, 4, 9, '1998-11-25 15:46:18'),
(14, 9, 5, 8, 1, 7, 1, '1978-06-03 13:19:06'),
(15, 6, 5, 5, 7, 7, 3, '1973-05-05 22:13:53'),
(16, 5, 4, 7, 8, 8, 2, '1988-01-15 14:25:19'),
(17, 9, 6, 8, 6, 6, 6, '1979-03-20 01:33:48'),
(18, 5, 8, 9, 5, 1, 9, '1977-05-21 19:53:00'),
(19, 6, 7, 9, 9, 9, 4, '1999-03-09 05:17:20'),
(20, 3, 4, 4, 4, 3, 5, '2015-09-01 23:55:29'),
(21, 5, 3, 1, 5, 8, 1, '1997-01-24 02:02:31'),
(22, 4, 6, 5, 2, 3, 7, '2007-03-04 22:48:17'),
(23, 2, 2, 2, 4, 5, 4, '2004-10-18 18:42:07'),
(24, 5, 9, 5, 5, 7, 9, '1993-05-15 11:32:25'),
(25, 5, 1, 2, 2, 3, 7, '1981-10-15 09:16:02'),
(26, 3, 8, 2, 9, 3, 3, '2016-11-11 02:13:56'),
(27, 6, 5, 8, 6, 8, 9, '2008-04-14 06:02:47'),
(28, 1, 6, 7, 4, 8, 9, '1988-07-12 00:00:14'),
(29, 9, 3, 7, 7, 7, 3, '1982-04-24 06:03:02'),
(30, 6, 2, 2, 2, 2, 7, '1977-04-11 23:28:43'),
(31, 5, 3, 2, 7, 8, 3, '2010-12-03 15:07:43'),
(32, 3, 3, 1, 8, 9, 3, '1987-07-19 06:24:01'),
(33, 7, 6, 5, 7, 6, 4, '1977-04-26 01:53:58'),
(34, 5, 6, 7, 5, 2, 1, '2011-04-13 16:08:11'),
(35, 1, 4, 9, 7, 9, 9, '1977-05-20 20:19:56'),
(36, 6, 9, 8, 6, 6, 1, '1985-05-24 22:29:42'),
(37, 1, 8, 5, 3, 6, 9, '1998-04-23 15:32:29'),
(38, 3, 4, 1, 1, 2, 7, '2009-06-17 16:14:14'),
(39, 1, 2, 6, 9, 3, 9, '1980-10-09 05:10:04'),
(40, 8, 5, 6, 9, 8, 2, '1977-01-07 09:31:19'),
(41, 8, 6, 1, 3, 3, 2, '2015-11-10 11:55:59'),
(42, 6, 8, 7, 6, 7, 3, '1992-03-29 23:35:00'),
(43, 8, 3, 6, 7, 4, 6, '1996-10-20 23:18:31'),
(44, 9, 2, 8, 9, 4, 6, '2004-11-09 21:53:38'),
(45, 2, 5, 2, 2, 5, 5, '1992-10-15 22:34:48'),
(46, 2, 6, 7, 6, 2, 1, '2010-08-09 14:24:12'),
(47, 5, 3, 5, 4, 4, 4, '1996-12-22 07:32:34'),
(48, 4, 1, 6, 6, 1, 7, '2007-06-14 18:44:47'),
(49, 2, 8, 5, 1, 5, 7, '1987-07-02 07:04:55'),
(50, 4, 2, 8, 1, 3, 7, '1985-09-22 18:30:53'),
(51, 9, 3, 2, 1, 4, 3, '1983-10-24 10:37:22'),
(52, 3, 3, 8, 3, 6, 1, '2012-02-07 19:57:37'),
(53, 2, 4, 6, 7, 9, 8, '1974-11-08 18:12:08'),
(54, 9, 1, 1, 1, 4, 9, '1979-02-21 10:55:01'),
(55, 1, 3, 4, 9, 6, 5, '2013-08-06 14:44:54'),
(56, 8, 5, 4, 7, 4, 3, '2013-09-10 16:25:13'),
(57, 1, 7, 3, 2, 5, 8, '1976-08-09 08:58:38'),
(58, 1, 2, 6, 4, 4, 4, '2013-04-12 22:53:18'),
(59, 8, 4, 2, 3, 6, 7, '2000-04-28 00:43:09'),
(60, 1, 8, 2, 8, 5, 6, '2004-07-02 15:29:28'),
(61, 5, 9, 3, 7, 1, 1, '1994-03-11 08:01:17'),
(62, 2, 4, 9, 8, 4, 4, '2014-12-23 17:08:09'),
(63, 1, 9, 5, 6, 7, 4, '2008-01-01 23:24:30'),
(64, 2, 4, 9, 6, 5, 3, '1970-01-19 03:06:08'),
(65, 3, 3, 8, 5, 2, 6, '2014-05-05 08:01:29'),
(66, 5, 9, 3, 4, 1, 5, '1984-08-05 23:26:26'),
(67, 9, 3, 9, 2, 2, 4, '1970-11-27 10:25:45'),
(68, 3, 9, 9, 6, 5, 2, '1973-08-18 10:04:00'),
(69, 7, 4, 4, 3, 1, 1, '2012-05-10 00:16:07'),
(70, 7, 8, 4, 6, 3, 9, '2010-07-16 22:40:03'),
(71, 9, 8, 8, 7, 6, 4, '1978-07-05 03:03:33'),
(72, 1, 5, 3, 4, 6, 7, '2009-03-09 06:44:45'),
(73, 3, 1, 1, 5, 5, 2, '2014-04-26 16:21:43'),
(74, 2, 7, 6, 2, 5, 2, '2002-07-05 14:08:43'),
(75, 5, 6, 2, 1, 5, 1, '1988-03-31 14:19:26'),
(76, 6, 9, 2, 2, 8, 9, '2016-08-22 08:20:42'),
(77, 1, 8, 3, 1, 4, 6, '1973-02-26 20:39:29'),
(78, 9, 4, 6, 2, 2, 1, '1990-02-23 13:12:56'),
(79, 1, 7, 8, 2, 6, 9, '2010-08-22 11:53:30'),
(80, 2, 2, 8, 4, 6, 8, '2007-05-09 00:14:14'),
(81, 8, 8, 8, 5, 3, 5, '2017-12-26 11:12:34'),
(82, 3, 9, 2, 8, 7, 6, '2010-02-02 04:26:54'),
(83, 2, 9, 5, 1, 3, 8, '1999-11-22 20:56:18'),
(84, 6, 6, 7, 9, 5, 4, '1981-10-28 06:42:23'),
(85, 9, 5, 5, 4, 3, 9, '2004-11-08 03:31:50'),
(86, 4, 3, 8, 2, 8, 8, '1991-01-16 21:43:43'),
(87, 2, 3, 2, 2, 7, 2, '2013-12-29 13:08:03'),
(88, 1, 9, 3, 4, 3, 1, '2005-03-20 22:19:59'),
(89, 8, 6, 4, 9, 1, 6, '2002-12-01 12:06:07'),
(90, 1, 6, 7, 7, 6, 4, '2000-03-13 08:09:17'),
(91, 7, 5, 9, 1, 1, 5, '1975-06-12 08:44:19'),
(92, 6, 3, 1, 2, 9, 9, '1996-04-12 04:49:58'),
(93, 6, 9, 7, 8, 9, 2, '1975-01-03 14:12:11'),
(94, 1, 3, 8, 8, 6, 9, '1994-01-16 20:29:49'),
(95, 8, 8, 8, 9, 9, 6, '1986-07-30 23:01:42'),
(96, 2, 5, 5, 5, 3, 3, '2002-04-06 01:46:56'),
(97, 2, 8, 3, 6, 3, 1, '2005-01-05 11:24:50'),
(98, 5, 4, 8, 3, 9, 8, '1982-07-03 17:38:57'),
(99, 5, 9, 7, 2, 9, 4, '1979-05-31 20:56:12'),
(100, 1, 9, 3, 5, 6, 4, '1978-02-25 15:30:42'),
(101, 4, 1, 5, 8, 5, 7, '1989-12-29 21:33:43'),
(102, 2, 1, 4, 6, 7, 2, '1984-12-25 18:13:28'),
(103, 4, 2, 4, 7, 3, 3, '1983-11-20 10:20:57'),
(104, 4, 3, 6, 3, 4, 7, '1997-12-09 21:45:37'),
(105, 4, 2, 2, 3, 6, 2, '1989-08-26 18:27:22'),
(106, 2, 3, 2, 1, 6, 3, '1982-01-03 12:55:24'),
(107, 5, 7, 6, 9, 1, 1, '1999-08-17 10:48:54'),
(108, 9, 7, 1, 3, 8, 7, '1986-04-15 00:49:47'),
(109, 4, 2, 8, 7, 2, 1, '1992-12-13 17:33:54'),
(110, 8, 4, 8, 7, 1, 8, '2001-03-02 13:32:25'),
(111, 3, 7, 7, 8, 7, 3, '1984-05-01 02:24:51'),
(112, 8, 6, 6, 5, 5, 6, '1979-03-09 20:35:00')
;



-- В качестве сервиса для курсового проекта я склоняюсь к криптоирже, например эту https://exmo.me/
-- если это не удачная идея прошу сообщить

