/*
 * Задача: "Топ-библиотек по популярности книг с разбивкой по жанрам"
 *
 * Есть четыре таблицы:
 * 1. books (id, title, author, genre)
 * 2. loans (id, book_id, library_code, borrower_id, loan_date, return_date)
 * 3. borrowers (id, name, membership_type)
 * 4. libraries (code, name, city, manager)
 *
 

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
*/

-- Таблица: books
-- Первичный ключ: id
-- Внешние ключи: нет
+----+-----------------------------------------+--------------------+----------+
| id | title                                   | author             | genre    |
+----+-----------------------------------------+--------------------+----------+
| 1  | Война и мир                             | Лев Толстой        | Classics |
| 2  | 1984                                    | Джордж Оруэлл      | Dystopia |
| 3  | Мастер и Маргарита                      | Михаил Булгаков    | Classics |
| 4  | Гарри Поттер и философский камень      | Дж. К. Роулинг     | Fantasy  |
| 5  | Три товарища                            | Эрих Мария Ремарк  | Classics |
+----+-----------------------------------------+--------------------+----------+

-- Таблица: libraries
-- Первичный ключ: code
-- Внешние ключи: нет
+----------+-------------------------------------+-------------+----------------+
| code     | name                                | city        | manager        |
+----------+-------------------------------------+-------------+----------------+
| LIB_MOW  | Центральная библиотека Москвы       | Москва      | Анна Петрова   |
| LIB_SPC  | Библиотека им. Достоевского         | СПб         | Иван Смирнов   |
| LIB_EKB  | Библиотека Урала                    | Екатеринбург| Мария Козлова  |
+----------+-------------------------------------+-------------+----------------+

-- Таблица: borrowers
-- Первичный ключ: id
-- Внешние ключи: нет
+----+-------------------+------------------+
| id | name              | membership_type  |
+----+-------------------+------------------+
| 1  | Алексей Иванов    | Premium          |
| 2  | Мария Петрова     | Standard         |
| 3  | Дмитрий Сидоров   | Premium          |
| 4  | Ольга Кузнецова   | Student          |
+----+-------------------+------------------+

-- Таблица: loans
-- Первичный ключ: id
-- Внешние ключи: 
--   book_id → books.id
--   library_code → libraries.code
--   borrower_id → borrowers.id
+----+---------+--------------+-------------+------------+-------------+
| id | book_id | library_code | borrower_id | loan_date  | return_date |
+----+---------+--------------+-------------+------------+-------------+
| 1  | 1       | LIB_MOW      | 1           | 2025-01-10 | 2025-01-20  |
| 2  | 2       | LIB_MOW      | 2           | 2025-01-12 | 2025-01-18  |
| 3  | 3       | LIB_SPC      | 3           | 2025-01-13 | 2025-01-23  |
| 4  | 4       | LIB_SPC      | 4           | 2025-01-14 | 2025-01-24  |
| 5  | 1       | LIB_MOW      | 3           | 2025-01-15 | 2025-01-25  |
| 6  | 5       | LIB_EKB      | 4           | 2025-01-16 | 2025-01-26  |
| 7  | 2       | LIB_SPC      | 1           | 2025-01-17 | 2025-01-22  |
| 8  | 1       | LIB_EKB      | 2           | 2025-01-18 | 2025-01-28  |
| 9  | 3       | LIB_MOW      | 4           | 2025-01-19 | 2025-01-29  |
| 10 | 4       | LIB_MOW      | 1           | 2025-01-20 | 2025-01-30  |
+----+---------+--------------+-------------+------------+-------------+


/*
Задча 1
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



--задача 2 Легкая
-- Найти все книги жанра 'Classics'
-- Вывести: название, автора
-- Отсортировать по названию

SELECT title as "Название книги",
       author AS "Автор книги"
FROM books
WHERE genre = 'Classics'
ORDER BY title;



--задача 2А легкая
-- Найти все книги жанра 'Classics', у которых в названии есть слово "и"
-- Вывести: название, автора, отсортировать по автору

SELECT title,author
FROM books
WHERE genre = 'Classics' AND (title LIKE 'и %' OR title LIKE '% и %' OR title LIKE '% и')
ORDER BY author;

--задача 2Б Легкая с JOIN
-- Найти все выдачи книг жанра 'Classics'
-- Вывести: название книги, дата выдачи, имя читателя
-- Отсортировать по дате выдачи
без CTE 
SELECT b.title, l.loan_date, bor.name
FROM loans l 
    JOIN books b ON l.book_id=b.id
    JOIN borrowers bor ON l.borrower_id = bor.id
WHERE b.genre = 'Classics'
ORDER BY l.loan_date ASC;

c CTE:
WITH loans_classics AS(
    SELECT b.title AS book_title,
           l.loan_date,
           bor.name AS borrower_name
    FROM loans l 
        JOIN books b ON l.book_id = b.id
        JOIN borrowers bor ON l.borrower_id = bor.id
        WHERE b.genre = 'Classics'
)
SELECT 
    book_title AS title,
    loan_date,
    borrower_name AS name 
    FROM loans_classics
    ORDER BY loan_date ASC;

--задача 2В легкая агрегация
-- Сколько всего книг каждого жанра?
-- Вывести: жанр, количество книг
-- Отсортировать по количеству (убывание)

SELECT genre AS 'Жанр', 
COUNT(*) AS 'Количество книг'
FROM books
GROUP BY genre
ORDER BY COUNT(*) DESC;



--задача 3 легкая
-- Сколько всего книг в таблице books?
-- Вывести общее количество
SELECT 
    COUNT(*) AS 'Общее количество'
    FROM books;


--задача 4 легкая
-- Найти все выдачи за январь 2025 года
-- Вывести: id выдачи, дату выдачи, дату возврата
-- Отсортировать по дате выдачи

SELECT id,
       loan_date,
       return_date
    FROM loans
    WHERE loan_date BETWEEN '2025-01-01' AND '2025-01-31' (другой вариант: WHERE loan_date >='2025-01-01' AND loan_date <='2025-01-31')
    ORDER BY loan_date ASC;                                (другой вариант: WHERE YEAR(loan_date) = '2025' AND MONTH(loan_date) = '01')

--задача 5a средняя
-- Найти читателей с премиум-подпиской, которые брали книги
-- Вывести: имя читателя, количество взятых книг
-- Отсортировать по количеству книг (убывание)
без CTE:
SELECT b.name AS reader_name,
       COUNT(l.borrower_id) AS count_books
    FROM loans l 
    JOIN borrowers b ON l.borrower_id = b.id
    WHERE b.membership_type = 'Premium'
    GROUP BY b.id, b.name
    ORDER BY COUNT(l.borrower_id) DESC;

вариантс с CTE:
WITH premium_readers AS(
    SELECT b.id AS reader_id,
           b.name AS reader_name,
           COUNT(l.borrower_id) AS count_books
    FROM loans l
        JOIN borrowers b ON b.id = l.borrower_id
   WHERE b.membership_type = 'Premium'
   GROUP BY b.id, b.name
)
SELECT reader_name,
       count_books
       FROM premium_readers
ORDER BY count_books DESC;



--задача 5b средняя
-- Найти топ-5 самых долгих выдач
-- Вывести: название книги, имя читателя, срок выдачи (в днях)
-- Отсортировать по сроку выдачи (убывание)

без CTE:
SELECT b.title,
        bor.name,
        DATEDIFF(l.return_date, l.loan_date) AS loan_duration
        FROM loans l 
        JOIN books b ON l.book_id = b.id
        JOIN borrowers bor  ON l.borrower_id = bor.id
        ORDER BY loan_duration DESC 
        LIMIT 5;

вариант c CTE:
WITH loan_longs AS (
    SELECT b.title AS book_title,
            bor.name AS client_name,
            DATEDIFF(return_date, loan_date) AS loan_duration
    FROM loans l 
        JOIN books b ON l.book_id = b.id
        JOIN borrowers bor ON l.borrower_id = bor.id
)
SELECT book_title,
       client_name,
       loan_duration 
       FROM loan_longs
ORDER BY loan_duration DESC
LIMIT 5;

--задача 5c средняя
-- В каком городе больше всего выдач?
-- Вывести: город, количество выдач
-- Отсортировать по количеству выдач (убывание)



--задача 5d средняя
-- Показать полную информацию о всех выдачах
-- Вывести: название книги, имя библиотеки, имя читателя, даты
-- Отсортировать по дате выдачи

--задача 6 средняя
-- Сколько выдач было в каждой библиотеке?
-- Вывести: название библиотеки, город, количество выдач
-- Отсортировать по количеству выдач (убывание)

--задача 7 средняя
-- Найти жанры, у которых больше 2 книг в каталоге
-- Вывести: жанр, количество книг

--задача 8 средняя ЦТЕ
-- Найти книги, которые никогда не выдавались
-- Вывести: название, автор, жанр

--задача 9 средняя ЦТЕ
-- Найти читателей, которые брали больше книг, чем средний читатель
-- Вывести: имя читателя, тип членства, количество взятых книг
-- Отсортировать по количеству книг

--задача 10 
-- Найти самый популярный день недели для выдачи книг
-- Вывести: день недели, количество выдач
-- Подсказка: DAYNAME(loan_date)