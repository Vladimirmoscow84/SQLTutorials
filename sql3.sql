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

вариант с CTE:
WITH avg_loans AS(
    SELECT AVG(DATEDIFF(return_date, loan_date)) AS avg_loan
    FROM loans
    WHERE return_date IS NOT NULL
), 
    stats AS(
        SELECT lib.name,
               lib.city,
               lib.manager,
               b.genre,
               COUNT(*) AS count_loans,
               SUM(DATEDIFF(l.return_date, l.loan_date)) AS all_days
        FROM loans l
        JOIN libraries lib ON l.library_code = lib.code
        JOIN books b ON l.book_id = b.id
        WHERE l.return_date IS NOT NULL
        GROUP BY lib.name, lib.city, lib.manager, b.genre
    )

SELECT name,
       city,
       manager,
       genre,
       count_loans,
       all_days
FROM stats CROSS JOIN avg_loans
WHERE count_loans>1 AND all_days > avg_loan
ORDER BY all_days DESC, name ASC, genre ASC
LIMIT 10

вариант без CTE:
SELECT lib.name,
       lib.city,
       lib.manager,
       b.genre,
       COUNT(*) AS count_loans,
       SUM(DATEDIFF(l.return_date, l.loan_date)) AS all_days
FROM loans l
JOIN libraries lib ON l.library_code = lib.code
JOIN books b ON l.book_id = b.id
WHERE l.return_date IS NOT NULL
GROUP BY lib.name, lib.city, lib.manager, b.genre
HAVING COUNT(*) > 1
       AND SUM(DATEDIFF(l.return_date, l.loan_date)) > (
        SELECT AVG(DATEDIFF(return_date,loan_date))
        FROM loans 
        WHERE return_date IS NOT NULL
       )
ORDER BY all_days DESC, lib.name ASC, b.genre ASC
LIMIT 10


--задача 2 Легкая
-- Найти все книги жанра 'Classics'
-- Вывести: название, автора
-- Отсортировать по названию

SELECT title, author
FROM books
WHERE genre = 'Classics'
ORDER BY title;


--задача 2А легкая
-- Найти все книги жанра 'Classics', у которых в названии есть слово "и"
-- Вывести: название, автора, отсортировать по автору
SELECT title,
        author
FROM books
WHERE geenre = 'Classics' AND genre LIKE 'и %' OR genre LIKE '% и %' OR genre LIKE '% и' 
ORDER BY author ASC;


--задача 2Б Легкая с JOIN
-- Найти все выдачи книг жанра 'Classics'
-- Вывести: название книги, дата выдачи, имя читателя
-- Отсортировать по дате выдачи
SELECT b.title,
       l.loan_date,
       bor.name
    FROM loans l
    JOIN books b ON l.book_id = b.id
    JOIN borrowers bor ON l.borrower_id = bor.id
    WHERE b.genre  = 'Classics'
    ORDER BY l.loan_date ASC;

--задача 2В легкая агрегация
-- Сколько всего книг каждого жанра?
-- Вывести: жанр, количество книг
-- Отсортировать по количеству (убывание)

SELECT genre,
        COUNT(*)
FROM books
GROUP BY genre
ORDER BY COUNT(*) DESC;


--задача 3 легкая
-- Сколько всего книг в таблице books?
-- Вывести общее количество
SELECT COUNT(*)
FROM books;



--задача 4 легкая
-- Найти все выдачи за январь 2025 года
-- Вывести: id выдачи, дату выдачи, дату возврата
-- Отсортировать по дате выдачи
SELECT id,
       loan_date,
       return_date
FROM loans
WHERE loan_date BETWEEN '2025-01-01' AND '2025-01-31'
-- WHERE loan_date >='2025-01-01' AND loan_date <='2025-01-31'
--WHERE YEAR(loan_date) = 2025 AND MONTH(loan_date) = 1
ORDER BY loan_date ASC;


--задача средняя
-- Найти читателей с премиум-подпиской, которые брали книги
-- Вывести: имя читателя, количество взятых книг
-- Отсортировать по количеству книг (убывание)
1 var:
SELECT bor.name,
       COUNT(l.borrower_id)
FROM borrowers bor 
LEFT JOIN loans l ON bor.id = l.borrower_id
WHERE bor.membership_type = 'Premium'
GROUP BY bor.id, bor.name
ORDER BY COUNT(l.borrower_id) DESC;

2 var CTE:
WITH reader_stats AS(
    SELECT bor.name,
           COUNT(l.borrower_id) AS count_readers
    FROM borrowers bor
    LEFT JOIN loans l ON bor.id = l.borrower_id
    WHERE bor.membership_type = 'Premium'
    GROUP BY bor.id, bor.name
)
SELECT name,
       count_readers
FROM reader_stats
ORDER BY count_readers DESC;


--задача средняя
-- Найти топ-5 самых долгих выдач
-- Вывести: название книги, имя читателя, срок выдачи (в днях)
-- Отсортировать по сроку выдачи (убывание)
var 1:
SELECT b.title,
       bor.name,
       DATEDIFF(return_date, loan_date) AS loan_duration     
FROM loans l 
LEFT JOIN books b ON l.book_id = b.id
LEFT JOIN borrowers bor ON l.borrower_id = bor.id
 WHERE return_date IS NOT NULL
ORDER BY loan_duration DESC
LIMIT 5;

var 2 CTE:
WITH stat_loans AS(
    SELECT b.title,
           bor.name,
           DATEDIFF(l.return_date, l.loan_date) AS loan_duration
FROM loans l
LEFT JOIN books b ON l.book_id = b.id
LEFT JOIN borrowers bor ON l.borrower_id = bor.id
WHERE l.return_date IS NOT NULL
)
SELECT title,
       name,
       loan_duration
FROM stat_loans
ORDER BY loan_duration DESC
LIMIT 5;

--задача средняя
-- В каком городе больше всего выдач?
-- Вывести: город, количество выдач
-- Отсортировать по количеству выдач (убывание)
var 1:
SELECT lib.city,
       COUNT(*) AS count_loans
FROM loans l 
JOIN libraries lib ON l.library_code = lib.code
GROUP BY lib.city
ORDER BY count_loans DESC;


--задача 5 средняя
-- Показать полную информацию о всех выдачах
-- Вывести: название книги, имя библиотеки, имя читателя, даты
-- Отсортировать по дате выдачи
SELECT b.title,
       lib.name AS lib_name,
       bor.name AS reader_name,
       l.loan_date,
       l.return_date
FROM loans l
JOIN books b ON l.book_id = b.id
JOIN libraries lib ON l.library_code = lib.code
JOIN borrowers bor ON l.borrower_id = bor.id
ORDER BY l.loan_date ASC;



--задача 6 средняя
-- Сколько выдач было в каждой библиотеке?
-- Вывести: название библиотеки, город, количество выдач
-- Отсортировать по количеству выдач (убывание)
var 1:
SELECT lib.name,
      lib.city,
      COUNT(*) AS count_loans
FROM loans l
JOIN libraries lib ON l.library_code = lib.code
GROUP BY lib.name, lib.city
ORDER BY count_loans DESC;

var 2 CTE:
WITH lib_stats AS(
    SELECT lib.name,
           lib.city,
           COUNT(*) AS count_loans
FROM loans l JOIN libraries lib ON l.library_code = lib.code
GROUP BY lib.code, lib.name
)
SELECT name,
       city,
       count_loans
FROM lib_stats
ORDER BY count_loans DESC;

--задача 7 средняя
-- Найти жанры, у которых больше 2 книг в каталоге
-- Вывести: жанр, количество книг

SELECT genre,
       COUNT(*)
FROM books
GROUP BY genre
HAVING COUNT(*) > 2;

--задача 8 средняя ЦТЕ
-- Найти книги, которые никогда не выдавались
-- Вывести: название, автор, жанр
 var 1 CTE:
WITH book_stats AS(
    SELECT b.id,
           b.title,
           b.author,
           b.genre
FROM books b 
LEFT JOIN loans l ON b.id = l.book_id
WHERE l.book_id IS NULL
)
SELECT title,
       author,
       genre
FROM book_stats;

var 2 no CTE:
SELECT b.title,
       b.author,
       b.genre
FROM books b
LEFT JOIN loans l ON b.id = l.book_id
WHERE l.book_id IS NULL;


--задача 9 средняя ЦТЕ
-- Найти читателей, которые брали больше книг, чем средний читатель
-- Вывести: имя читателя, тип членства, количество взятых книг
-- Отсортировать по количеству книг

WITH reader_loans AS (
    SELECT bor.id,
           bor.name,
           bor.membership_type,
           COUNT(*) AS books_taken
    FROM borrowers bor
    LEFT JOIN loans l ON l.borrower_id = bor.id
    GROUP BY bor.id, bor.name, bor.membership_type
),
avg_taken AS(
    SELECT AVG(books_taken) AS avg_books
    FROM reader_loans
)
SELECT name,
       membership_type,
       books_taken
FROM reader_loans
CROSS JOIN avg_taken
WHERE books_taken>avg_books
ORDER BY books_taken DESC;


--задача 9b средняя ЦТЕ
-- Найти библиотеки, в которых было больше выдач, 
-- чем в среднем по всем библиотекам
-- Вывести: название библиотеки, город, количество выдач
-- Отсортировать по количеству выдач (убывание)

WITH lib_stats AS(
    SELECT lib.code,
            lib.name,
           lib.city,
           COUNT(l.id) AS books_taken
    FROM libraries lib
    LEFT JOIN loans l ON lib.code = l.library_code
    GROUP BY lib.code, lib.name, lib.city
),
avg_loans AS(
    SELECT AVG(books_taken) As avg_loans
    FROM lib_stats 
)
SELECT name, city, books_taken
FROM lib_stats
WHERE books_taken > avg_loans
ORDER BY books_taken DESC;




--задача 9с средняя ЦТЕ
-- Найти жанры книг, которые брали чаще среднего
-- (чаще, чем в среднем берут книги любого жанра)
-- Вывести: жанр, количество выдач этого жанра
-- Отсортировать по количеству выдач (убывание)

WITH genre_stats AS(
    SELECT
    b.genre,
    COUNT(l.id) AS books_taken
FROM books b 
LEFT JOIN loans l ON b.id = l.book_id
GROUP BY  b.genre
),
avg_loans AS(
    SELECT AVG(books_taken) AS avg_taken
    FROM genre_stats
)
SELECT genre, books_taken
FROM genre_stats
WHERE books_taken>avg_taken
ORDER BY books_taken DESC;


--задача 9a средняя ЦТЕ
-- Найти читателей, которые брали больше книг, чем средний читатель
-- Вывести: имя читателя, тип членства, количество взятых книг
-- Отсортировать по количеству книг

WITH reader_stats AS(
    SELECT bor.id,
        bor.name,
        bor.membership_type,
        COUNT(l.id) AS count_loans
FROM borrowers bor
LEFT JOIN loans l ON bor.id = l.borrower_id
GROUP BY bor.id, bor.name, bor.membership_type
),
avg_reader AS(
    SELECT AVG(count_loans) AS avg_bor
    FROM reader_stats
)
SELECT name,
       membership_type,
       count_loans
FROM reader_stats
WHERE count_loans>avg_bor
ORDER BY count_loans DESC;

--задача 10a
-- Найти самый популярный день недели для выдачи книг
-- Вывести: день недели, количество выдач
-- Подсказка: DAYNAME(loan_date)
SELECT DAYNAME(loan_date),
       COUNT(*)
FROM loans
GROUP BY DAYNAME(loan_date)
ORDER BY COUNT(*) DESC
LIMIT 1;


--задача 10b
-- Найти самый популярный МЕСЯЦ для выдачи книг
-- (в каком месяце чаще всего выдавали книги)
-- Вывести: месяц (название), количество выдач
-- Отсортировать по количеству выдач (убывание)
-- Показать только самый популярный месяц
 SELECT MONTHNAME(loan_date),
        COUNT(*)
FROM loans 
GROUP BY MONTHNAME(loan_date)
ORDER BY COUNT(*) DESC
LIMIT 1;


--Задача 11А (средняя)
-- Для каждого читателя найти:
-- 1. Общее количество взятых книг
-- 2. Дата первой выдачи
-- 3. Дата последней выдачи

-- Вывести: 
-- имя читателя, 
-- количество книг,
-- первую дату выдачи,
-- последнюю дату выдачи

-- Отсортировать по количеству книг (убывание)
-- Показать только топ-5
var 1 CTE:
WITH reader_stats AS(
    SELECT bor.id,
    bor.name,
    COUNT(l.id) AS count_loans,
    MIN(l.loan_date) AS first_loan,
    MAX(l.loan_date) AS last_loan
    FROM borrowers bor
    LEFT JOIN loans l ON bor.id = l.borrower_id
    GROUP BY bor.id, bor.name
)
SELECT name,
       count_loans,
       first_loan,
       last_loan
FROM reader_stats
ORDER BY count_loans DESC
LIMIT 5;

var 2 without CTE:
SELECT bor.name,
      COUNT(l.id) AS count_loans,
      MIN(l.loan_date) AS first_loan,
      MAX(l.loan_date) AS last_loan
FROM borrowers bor
LEFT JOIN loans l ON bor.id = l.borrower_id
GROUP BY bor.id, bor.name
ORDER BY count_loans DESC
LIMIT 5;

--Задача 11Б (сложная)
-- Для каждого читателя найти:
-- 1. Общее количество взятых книг
-- 2. Любимый жанр (который брал чаще всего)
-- 3. Дата первой и последней выдачи

-- Вывести: 
-- имя читателя, 
-- количество книг,
-- любимый жанр,
-- первую дату выдачи,
-- последнюю дату выдачи

-- Отсортировать по количеству книг (убывание)
-- Показать только топ-5
var 1 CTE:
WITH reader_stats AS(
    SELECT bor.id,
           bor.name,
           COUNT(l.id) AS count_books,
           MIN(l.loan_date) AS first_loan,
           MAX(l.loan_date) AS last_loan
FROM borrowers bor 
LEFT JOIN loans l ON bor.id = l.borrower_id
GROUP BY bor.id,bor.name
),
genre_stats AS(
   SELECT l.borrower_id,
          b.genre,
          COUNT(*) AS count_genre
    FROM loans l
    LEFT JOIN books b ON l.book_id = b.id
    GROUP BY l.borrower_id, b.genre
),
favorite_genre AS(
SELECT borrower_id,
       MIN(genre) AS fav_genre --если одинаковое значение, то берет по алфавиту
FROM genre_stats gs1
WHERE count_genre = (
    SELECT MAX(count_genre)
    FROM genre_stats gs2
    WHERE gs1.borrower_id = gs2.borrower_id
)
)
SELECT rs.name,
       rs.count_books,
       fg.fav_genre,
       rs.first_loan,
       rs.last_loan
FROM reader_stats rs
LEFT JOIN favorite_genre fg ON rs.id = fg.borrower_id
ORDER BY rs.count_books DESC
LIMIT 5;

--Задача 11В (сложная)
--Самый популярный жанр в каждой библиотеке
--Таблицы:
--libraries (code, name, city)
--books (id, title, genre)
--loans (id, book_id, library_code, loan_date)

--📌 Условие:
--Для каждой библиотеки найти:
--Общее количество выдач в этой библиотеке
--Самый популярный жанр (который брали чаще всего)
--Количество выдач этого жанра
--Дата первой и последней выдачи в этой библиотеке

--📋 Вывести:
--название библиотеки
--город
--общее количество выдач
--самый популярный жанр
--количество выдач этого жанра
--первая дата выдачи
--последняя дата выдачи

--🔢 Отсортировать:
--по общему количеству выдач (убывание)
--показать топ-5 библиотек
WITH lib_stats AS(
    SELECT lib.code,
           lib.name,
           lib.city,
           COUNT(l.id) AS count_loans,
           MIN(l.loan_date) AS first_loan,
           MAX(l.loan_date) AS last_loan
    FROM libraries lib
    LEFT JOIN loans l ON lib.code = l.library_code
    GROUP BY lib.code, lib.name,lib.city
),
genre_stats AS(
   SELECT  l.library_code,
    b.genre,
    COUNT(*) AS count_genre
    FROM loans l   
    LEFT JOIN books b ON l.book_id = b.id
    GROUP BY l.library_code, b.genre
),
top_genre AS(
    SELECT library_code,
           genre AS fav_genre
    FROM genre_stats gs1 
    WHERE count_genre = (
        SELECT MAX(count_genre)
        FROM genre_stats gs2
        WHERE gs1.library_code = gs2.library_code
    )
)
SELECT ls.name,
        ls.city,
        ls.count_loans,
        tg.fav_genre,
        ls.first_loan,
        ls.last_loan
FROM lib_stats ls
LEFT JOIN top_genre tg ON ls.code = tg.library_code
ORDER BY ls.count_loans DESC
LIMIT 5;
       
--11d (сложная)
--Самый популярный автор в каждом жанре
--Таблицы:
--books (id, title, author, genre)
--loans (id, book_id, loan_date)

--📌 Условие:
--Для каждого жанра найти:
--Общее количество выдач книг этого жанра
--Самого популярного автора (чьи книги брали чаще всего)
--Количество выдач книг этого автора в данном жанре
--Дата первой и последней выдачи книг этого жанра

--📋 Вывести:
--жанр
--общее количество выдач в жанре
--самого популярного автора
--количество выдач этого автора
--первую дату выдачи в жанре
--последнюю дату выдачи в жанре

--🔢 Отсортировать:
--по общему количеству выдач (убывание)
--показать топ-5 жанров

var CTE:
--группировка по жанрам книг (жанры с количеством взятия и крайними датами взятия)
WITH genre_stats AS(
    SELECT b.genre,
           COUNT(l.id) AS total_loans,
           MIN(l.loan_date) AS first_loan,
           MAX(l.loan_date) AS last_loan
    FROM books b
    LEFT JOIN loans l ON b.id = l.book_id
    GROUP BY b.genre
),
--группировка по жанру и авторам книг (авторы книг в определенном жанре с количеством взятия)
author_stats AS(
    SELECT b.author,
         b.genre,
         COUNT(l.id) AS author_loans
    FROM books b
    LEFT JOIN loans l ON b.id = l.book_id
    GROUP BY b.genre, b.author
),
--инфо по популярности авторов
top_authors AS(
    SELECT genre,
           author AS top_author,
           author_loans
    FROM author_stats as1
    WHERE author_loans = (
        SELECT MAX(author_loans)
        FROM author_stats as2
        WHERE as1.genre = as2.genre
    )
)
--общая информация по жанрам и авторам
SELECT gs.genre,
       gs.total_loans,
       ta.top_author,
       ta.author_loans,
       gs.first_loan,
       gs.last_loan
FROM genre_stats gs 
LEFT JOIN top_authors ta ON gs.genre = ta.genre
ORDER BY gs.total_loans DESC
LIMIT 5;


--Задача 12 (средняя)
-- Найти топ-5 самых популярных книг
-- (которые брали чаще всего)

-- Вывести: 
-- название книги, 
-- автор,
-- жанр,
-- количество выдач

-- Отсортировать по количеству выдач (убывание)
-- Показать только топ-5
var CTE:
WITH book_stats AS(
    SELECT b.id,
           b.title,
           b.author,
           b.genre,
           COUNT(l.id) AS count_loans
    FROM books b
    LEFT JOIN loans l ON b.id = l.book_id
    GROUP BY b.id, b.title, b.author, b.genre
)
SELECT title,
       author,
       genre,
       count_loans
FROM book_stats
ORDER BY count_loans DESC
LIMIT 5;

var NO CTE;
SELECT b.title,
       b.author,
       b.genre,
       COUNT(l.id) AS count_loans
FROM books b
LEFT JOIN loans l ON b.id = l.book_id
GROUP BY b.id, b.title, b.author, b.genre
ORDER BY count_loans DESC
LIMIT 5;


--Задача 13 (средняя)
-- Для каждого жанра найти:
-- 1. Общее количество книг в каталоге
-- 2. Общее количество выдач книг этого жанра
-- 3. Среднее количество выдач на одну книгу в жанре

-- Вывести:
-- жанр,
-- количество книг в жанре,
-- количество выдач,
-- среднее выдач на книгу (округлить до 2 знаков)

-- Отсортировать по среднему количеству выдач на книгу (убывание)

var CTE:
WITH book_stats AS(
    SELECT b.genre,
    COUNT(*) AS count_genre_books,
    COUNT(l.id) AS count_genre_loans
FROM books b 
LEFT JOIN loans l ON b.id = l.book_id
GROUP BY b.genre 
)
SELECT genre,
       count_genre_books,
       count_genre_loans,
       ROUND((count_genre_loans * 1.0/count_genre_books),2) AS avg_loan_per_book
FROM book_stats
ORDER BY avg_loan_per_book DESC;

var NO CTE;
SELECT b.genre,
       COUNT(*) AS count_genre_books,
       COUNT(l.id) AS count_genre_loans,
       ROUND(COUNT(l.id) *1.0/COUNT(*), 2) AS avg_genre_loans
FROM books b 
LEFT JOIN loans l ON b.id = l.book_id
GROUP BY b.genre
ORDER BY avg_genre_loans DESC;

--Задача 14 (средняя)
-- Проанализировать активность читателей по типам членства
-- (Premium, Standard и т.д.)

-- Для каждого типа членства найти:
-- 1. Количество читателей
-- 2. Общее количество взятых книг
-- 3. Среднее количество книг на читателя
-- 4. Процент читателей, которые брали книги

-- Вывести:
-- тип членства,
-- количество читателей,
-- общее количество книг,
-- среднее книг на читателя (округлить до 1 знака),
-- процент активных читателей (округлить до 1 знака)

-- Отсортировать по среднему количеству книг (убывание)

var NO CTE:
SELECT bor.membership_type,
       COUNT(*) AS count_bor,
       COUNT(l.id) AS count_loans,
       ROUND(COUNT(l.id) *1.0/count(*), 1) AS avg_bor_loans,
       ROUND(COUNT(CASE WHEN l.id IS NOT NULL THEN 1 END) *100.0 / COUNT(*),1) AS percent_bor
FROM borrowers bor 
LEFT JOIN loans l ON bor.id = l.borrower_id
GROUP BY bor.membership_type 
ORDER BY avg_bor_loans DESC;

var CTE:
WITH readers_stats AS(
    SELECT bor.membership_type,
    COUNT(*) AS readers_count,
    COUNT(l.id) AS count_loans,
    ROUND(COUNT(l.id)*1.0/COUNT(*),1) AS avg_loans,
    ROUND(COUNT(CASE WHEN l.id IS NOT NULL THEN 1 END) * 100.0/COUNT(*), 1) percent
FROM borrowers bor
LEFT JOIN loans l ON bor.id = l.borrower_id
GROUP BY bor.membership_type
)
SELECT membership_type,
      readers_count,
      count_loans,
      avg_loans,
      percent
FROM readers_stats
ORDER BY avg_loans DESC;


