-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Час створення: Гру 19 2019 р., 14:50
-- Версія сервера: 10.3.13-MariaDB
-- Версія PHP: 7.1.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `document_storage`
--

-- --------------------------------------------------------

--
-- Структура таблиці `authors`
--

CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL,
  `author_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `authors`
--

INSERT INTO `authors` (`author_id`, `author_name`) VALUES
(1, 'Артюхов Роман Вячеславович'),
(2, 'Білан Максим Олександрович'),
(3, 'Грінченко Анна Максимівна'),
(4, 'Дєєв Сергій Сергійович'),
(5, 'Злосчастьєв Данило Костянтинович'),
(6, 'Зюбіна Анна Володимирівна'),
(7, 'Огійчук Артем Олександрович'),
(8, 'Поліщук Орест Володимирович');

-- --------------------------------------------------------

--
-- Структура таблиці `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `end_period` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `end_period`) VALUES
(1, 'Журнал для заяв студентів 3-го курсу кафедри інформаційних технологій', '2019-12-29'),
(2, 'Журнал для заяв студентів 3-го курсу кафедри диференціальних рівнянь і прикладної математики', '2019-12-29'),
(3, 'Журнал для заяв студентів 3-го курсу кафедри англійської філології', '2019-12-29'),
(4, 'Журнал для доповідних записок студентів 3-го курсу кафедри англійської філології', '2019-12-29'),
(5, 'Журнал для пояснювальних записок студентів 3-го курсу кафедри англійської філології', '2019-12-29');

-- --------------------------------------------------------

--
-- Структура таблиці `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `creation_date` date DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `document_type` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `documents`
--

INSERT INTO `documents` (`id`, `name`, `creation_date`, `author_id`, `document_type`, `description`) VALUES
(1, 'Заява на отримання соціальної стипендії', '2019-09-20', 4, 1, 'група ПМ-3'),
(2, 'Заява на видачу дубліката залікової книжки', '2019-09-20', 6, 1, 'група ІПЗ-3'),
(3, 'Заява на відрахування із числа студентів за власним бажанням', '2019-12-17', 5, 1, 'група ІПЗ-3'),
(4, 'Доповідна записка про відрядження', '2019-12-18', 8, 4, '-'),
(5, 'Пояснювальна записка', '2019-12-18', 1, 2, 'група А-13');

-- --------------------------------------------------------

--
-- Структура таблиці `documents_in_process`
--

CREATE TABLE `documents_in_process` (
  `document_id` int(11) NOT NULL,
  `register_id` int(11) DEFAULT NULL,
  `staff` varchar(255) DEFAULT NULL,
  `current_state` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `documents_in_process`
--

INSERT INTO `documents_in_process` (`document_id`, `register_id`, `staff`, `current_state`) VALUES
(1, 2, 'Пилипів Володимир Михайлович', 3),
(2, 1, 'Пилипів Володимир Михайлович', 3),
(3, 1, 'Соломко Андрій Васильович', 2),
(4, 5, 'Венгринович Андрій Антонович', 1),
(5, 5, 'Яцків Наталія Яремівна', 3);

--
-- Тригери `documents_in_process`
--
DELIMITER $$
CREATE TRIGGER `trigger_update_register` BEFORE UPDATE ON `documents_in_process` FOR EACH ROW BEGIN
    UPDATE registers SET registers.document_state = NEW.current_state WHERE NEW.document_id = registers.register_id;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблиці `document_types`
--

CREATE TABLE `document_types` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `document_types`
--

INSERT INTO `document_types` (`type_id`, `type_name`) VALUES
(1, 'Заява'),
(2, 'Пояснювальна записка'),
(3, 'Службова записка'),
(4, 'Доповідна записка');

-- --------------------------------------------------------

--
-- Структура таблиці `faculties`
--

CREATE TABLE `faculties` (
  `faculty_id` int(11) NOT NULL,
  `faculty_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `faculties`
--

INSERT INTO `faculties` (`faculty_id`, `faculty_name`) VALUES
(1, 'Факультет математики та інформатики'),
(2, 'Факультет іноземних мов');

-- --------------------------------------------------------

--
-- Структура таблиці `registers`
--

CREATE TABLE `registers` (
  `register_id` int(11) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `document_author_id` int(11) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `document_state` int(11) DEFAULT NULL,
  `faculty_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `registers`
--

INSERT INTO `registers` (`register_id`, `document_id`, `document_author_id`, `registration_date`, `document_state`, `faculty_id`) VALUES
(2, 1, 4, '2019-09-21', 3, 1),
(1, 2, 6, '2019-09-21', 3, 1),
(1, 3, 5, '2019-12-18', 2, 1),
(4, 4, 8, '2019-12-20', 1, 2),
(5, 5, 1, '2019-12-20', 3, 2);

-- --------------------------------------------------------

--
-- Структура таблиці `states`
--

CREATE TABLE `states` (
  `state_id` int(11) NOT NULL,
  `state_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `states`
--

INSERT INTO `states` (`state_id`, `state_name`) VALUES
(1, 'Надходження'),
(2, 'Розгляд'),
(3, 'Підтверджено'),
(4, 'Відхилено');

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`),
  ADD UNIQUE KEY `author_id` (`author_id`),
  ADD UNIQUE KEY `author_name` (`author_name`);

--
-- Індекси таблиці `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_id` (`category_id`);

--
-- Індекси таблиці `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `document_type` (`document_type`);

--
-- Індекси таблиці `documents_in_process`
--
ALTER TABLE `documents_in_process`
  ADD KEY `document_id` (`document_id`),
  ADD KEY `register_id` (`register_id`),
  ADD KEY `current_state` (`current_state`);

--
-- Індекси таблиці `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`type_id`),
  ADD UNIQUE KEY `type_id` (`type_id`);

--
-- Індекси таблиці `faculties`
--
ALTER TABLE `faculties`
  ADD PRIMARY KEY (`faculty_id`),
  ADD UNIQUE KEY `faculty_id` (`faculty_id`);

--
-- Індекси таблиці `registers`
--
ALTER TABLE `registers`
  ADD KEY `register_id` (`register_id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `document_author_id` (`document_author_id`),
  ADD KEY `document_state` (`document_state`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Індекси таблиці `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`state_id`),
  ADD UNIQUE KEY `state_id` (`state_id`);

--
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблиці `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблиці `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблиці `documents_in_process`
--
ALTER TABLE `documents_in_process`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблиці `document_types`
--
ALTER TABLE `document_types`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблиці `faculties`
--
ALTER TABLE `faculties`
  MODIFY `faculty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблиці `states`
--
ALTER TABLE `states`
  MODIFY `state_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Обмеження зовнішнього ключа збережених таблиць
--

--
-- Обмеження зовнішнього ключа таблиці `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`document_type`) REFERENCES `document_types` (`type_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `documents_in_process`
--
ALTER TABLE `documents_in_process`
  ADD CONSTRAINT `documents_in_process_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_in_process_ibfk_2` FOREIGN KEY (`register_id`) REFERENCES `categories` (`category_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_in_process_ibfk_3` FOREIGN KEY (`current_state`) REFERENCES `states` (`state_id`) ON UPDATE CASCADE;

--
-- Обмеження зовнішнього ключа таблиці `registers`
--
ALTER TABLE `registers`
  ADD CONSTRAINT `registers_ibfk_1` FOREIGN KEY (`register_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `registers_ibfk_2` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `registers_ibfk_3` FOREIGN KEY (`document_author_id`) REFERENCES `authors` (`author_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `registers_ibfk_4` FOREIGN KEY (`document_state`) REFERENCES `states` (`state_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `registers_ibfk_5` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`faculty_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
