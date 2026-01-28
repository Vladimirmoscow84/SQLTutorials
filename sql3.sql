/*
 * Задача: "Топ-библиотек по популярности книг с разбивкой по жанрам"
 *
 * Есть четыре таблицы:
 * 1. books (id, title, author, genre)
 * 2. loans (id, book_id, library_code, borrower_id, loan_date, return_date)
 * 3. borrowers (id, name, membership_type)
 * 4. libraries (code, name, city, manager)
 *
 * Цель:
 * Написать один запрос, который возвращает:
 * - название библиотеки (name из libraries)
 * - город (city из libraries)
 * - имя менеджера (manager из libraries)
 * - жанр книги (genre из books)
 * - количество выдач (loans) в этом жанре в этой библиотеке
 * - общий срок выдачи книг (в днях) по этому жанру в этой библиотеке
 * Только те библиотеки + жанры, где:
 * - количество выдач > 1
 * - общий срок выдачи > среднего по всем библиотекам и жанрам
 * Отсортировать:
 * - по общему сроку выдачи по убыванию
 * - по названию библиотеки по возрастанию
 * - по жанру по возрастанию
 * Вывести ТОП-10
 */
 

-- Создание таблиц
CREATE TABLE books (
    id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100)
);

CREATE TABLE libraries (
    code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    manager VARCHAR(255)
);

CREATE TABLE borrowers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    membership_type VARCHAR(50)
);

CREATE TABLE loans (
    id INT PRIMARY KEY,
    book_id INT,
    library_code VARCHAR(10),
    borrower_id INT,
    loan_date DATE,
    return_date DATE
);

-- Вставка тестовых данных
INSERT INTO libraries (code, name, city, manager) VALUES
('LIB_MOW', 'Центральная библиотека Москвы', 'Москва', 'Анна Петрова'),
('LIB_SPC', 'Библиотека им. Достоевского', 'СПб', 'Иван Смирнов'),
('LIB_EKB', 'Библиотека Урала', 'Екатеринбург', 'Мария Козлова');

INSERT INTO borrowers (id, name, membership_type) VALUES
(1, 'Алексей Иванов', 'Premium'),
(2, 'Мария Петрова', 'Standard'),
(3, 'Дмитрий Сидоров', 'Premium'),
(4, 'Ольга Кузнецова', 'Student');

INSERT INTO books (id, title, author, genre) VALUES
(1, 'Война и мир', 'Лев Толстой', 'Classics'),
(2, '1984', 'Джордж Оруэлл', 'Dystopia'),
(3, 'Мастер и Маргарита', 'Михаил Булгаков', 'Classics'),
(4, 'Гарри Поттер и философский камень', 'Дж. К. Роулинг', 'Fantasy'),
(5, 'Три товарища', 'Эрих Мария Ремарк', 'Classics');

INSERT INTO loans (id, book_id, library_code, borrower_id, loan_date, return_date) VALUES
(1, 1, 'LIB_MOW', 1, '2025-01-10', '2025-01-20'), -- 10 дней
(2, 2, 'LIB_MOW', 2, '2025-01-12', '2025-01-18'), -- 6 дней
(3, 3, 'LIB_SPC', 3, '2025-01-13', '2025-01-23'), -- 10 дней
(4, 4, 'LIB_SPC', 4, '2025-01-14', '2025-01-24'), -- 10 дней
(5, 1, 'LIB_MOW', 3, '2025-01-15', '2025-01-25'), -- 10 дней
(6, 5, 'LIB_EKB', 4, '2025-01-16', '2025-01-26'), -- 10 дней
(7, 2, 'LIB_SPC', 1, '2025-01-17', '2025-01-22'), -- 5 дней
(8, 1, 'LIB_EKB', 2, '2025-01-18', '2025-01-28'), -- 10 дней
(9, 3, 'LIB_MOW', 4, '2025-01-19', '2025-01-29'), -- 10 дней
(10, 4, 'LIB_MOW', 1, '2025-01-20', '2025-01-30'); -- 10 дней