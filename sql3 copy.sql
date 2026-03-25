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

SELECT title,
    author
    FROM books
    WHERE genre = 'Classics'
ORDER BY title;





--задача 2А легкая
-- Найти все книги жанра 'Classics', у которых в названии есть слово "и" (маленькая)
-- Вывести: название, автора, отсортировать по автору

SELECT title,
author
FROM books
WHERE genre = 'Classics' AND (title LIKE 'и %'  OR title LIKE '% и %' ORtitle LIKE '% и')
ORDER BY author;


--задача 2Б Легкая с JOIN
-- Найти все выдачи книг жанра 'Classics'
-- Вывести: название книги, дата выдачи, имя читателя
-- Отсортировать по дате выдачи
no CTE:
SELECT
b.title,
l.loan_date,
bor.name
FROM loans l 
JOIN books b ON b.id = l.book_id
JOIN borrowers bor ON bor.id = l.borrower_id
WHERE b.genre = 'Classics'
ORDER BY l.loan_date;



--задача 2В легкая агрегация
-- Сколько всего книг каждого жанра?
-- Вывести: жанр, количество книг
-- Отсортировать по количеству (убывание)

SELECT 
genre AS "Жанр",
COUNT(*) AS "Количество книг"
FROM books
GROUP BY genre
ORDER BY "Количество книг" DESC;




--задача 3 легкая
-- Сколько всего книг в таблице books?
-- Вывести общее количество
SELECT COUNT(*) FROM books;


--задача 4 легкая
-- Найти все выдачи за январь 2025 года
-- Вывести: id выдачи, дату выдачи, дату возврата
-- Отсортировать по дате выдачи

SELECT id,
loan_date,
return_date
FROM loans
WHERE loan_date BETWEEN '2025-01-01' AND '2025-01-31'
-- WHERE YEAR(loan_date) = '2025' AND MONTH(loan_date) = '01'
-- WHERE loan_date>'2025-01-01' AND loan_date <'2025-01-31'
ORDER BY loan_date;



--задача 5a средняя
-- Найти читателей с премиум-подпиской, которые брали книги
-- Вывести: имя читателя, количество взятых книг
-- Отсортировать по количеству книг (убывание)

SELECT bor.name,
COUNT(*)
FROM loans l
JOIN borrowers bor ON l.borrower_id = bor.id
WHERE bor.membership_type = 'Premium'
GROUP by bor.name
ORDER BY COUNT(*) DESC; 



--задача 5b средняя
-- Найти топ-5 самых долгих выдач
-- Вывести: название книги, имя читателя, срок выдачи (в днях)
-- Отсортировать по сроку выдачи (убывание)
no CTE: --(оптимальный)
SELECT b.title,
bor.name,
DATEDIFF(l.return_date, l.loan_date) AS "Срок выдачи"
FROM loans l
JOIN borrowers bor ON l.borrower_id = bor.id
JOIN books b ON l.book_id = b.id
WHERE l.return_date IS NOT NULL
ORDER BY "Срок выдачи" DESC
LIMIT 5;

CTE: -- (избыточен)
WITH loan_stat AS(
    SELECT b.title,
           bor.name,
           DATEDIFF(l.return_date, l.loan_date) AS duration
    FROM loans l JOIN books b ON l.book_id = b.id
                JOIN borrowers bor ON l.borrower_id = bor.id
    WHERE l.return_date IS NOT NULL
)
SELECT title,
name,
duration
FROM loan_stat
ORDER BY duration DESC
LIMIT 5;

--задача 5c средняя
-- В каком городе больше всего выдач?
-- Вывести: город, количество выдач
-- Отсортировать по количеству выдач (убывание)
no CTE:
SELECT lib.city,
COUNT(l.library_code)  --COUNT(*)
FROM loans l
JOIN libraries lib ON l.library_code = lib.code
GROUP BY lib.city
ORDER BY COUNT(l.library_code) DESC; -- COUNT(*)


--задача 5d средняя
-- Показать полную информацию о всех выдачах
-- Вывести: название книги, имя библиотеки, имя читателя, даты
-- Отсортировать по дате выдачи

SELECT b.title,
       lib.name,
       bor.name,
       l.loan_date,
       l.return_date
FROM loans l JOIN books b ON l.book_id = b.id
             JOIN borrowers bor ON l.borrower_id = bor.id
             JOIN libraries lib ON l.library_code = lib.code
ORDER BY 4 ASC;

--задача 6 средняя
-- Сколько выдач было в каждой библиотеке?
-- Вывести: название библиотеки, город, количество выдач
-- Отсортировать по количеству выдач (убывание)

no CTE:
SELECT lib.name,
       lib.city,
       COUNT(l.library_code) AS counts
FROM loans l JOIN libraries lib ON l.library_code = lib.code
GROUP BY lib.name, lib.city
ORDER BY counts DESC;

CTE:
WITH lib_stats AS(
    SELECT lib.name,
            lib.city,
            COUNT(*) AS count_loans
    FROM loans l JOIN libraries lib ON l.library_code = lib.code
    GROUP BY lib.name, lib.city
)

SELECT name,
       city,
       count_loans
FROM lib_stats
ORDER BY 3 DESC;


--задача 7 средняя
-- Найти жанры, у которых больше 2 книг в каталоге
-- Вывести: жанр, количество книг
SELECT genre,
       COUNT(genre)
       FROM books
GROUP BY genre
HAVING COUNT(genre) > 2;



--задача 8 средняя ЦТЕ
-- Найти книги, которые никогда не выдавались
-- Вывести: название, автор, жанр
no CTE:
SELECT b.title,
       b.author,
       b.genre
FROM books b LEFT JOIN loans l ON b.id = l.book_id
WHERE l.book_id IS NULL;

CTE:
WITH books_stats AS(
    SELECT b.id,
           b.title,
           b.author,
           b.genre
    FROM books b LEFT JOIN loans l ON b.id = l.book_id
    WHERE l.book_id IS NULL
)
SELECT title,
       author,
       genre 
FROM books_stats;


--задача 9a средняя ЦТЕ
-- Найти читателей, которые брали больше книг, чем средний читатель
-- Вывести: имя читателя, тип членства, количество взятых книг
-- Отсортировать по количеству книг по убыванию

 WITH bor_stats AS(
    SELECT bor.name,
           bor.membership_type,
           COUNT(l.borrower_id) AS bor_count_loans
    FROM borrowers bor JOIN loans l ON bor.id = l.borrower_id
    GROUP BY bor.id, bor.name
 ),
    avg_loans AS(
        SELECT AVG(bor_count_loans) AS avg_loans
        FROM bor_stats
    )
SELECT b.name,
       b.membership_type,
       b.bor_count_loans
FROM bor_stats b, avg_loans a -- bor_stats b CROSS JOIN avg_loans s
WHERE b.bor_count_loans > a.avg_loans
ORDER BY 3 DESC;



--задача 9b средняя ЦТЕ
-- Найти библиотеки, в которых было больше выдач, 
-- чем в среднем по всем библиотекам
-- Вывести: название библиотеки, город, количество выдач
-- Отсортировать по количеству выдач (убывание)

WITH lib_stats AS(
    SELECT lib.code,
           lib.name,
           lib.city,
           COUNT(*) AS counts
    FROM libraries lib JOIN loans l ON l.library_code = lib.code
    GROUP BY lib.code, lib.name, lib.city
),
avg_libs AS(
    SELECT AVG(counts) AS avg_counts
    FROM lib_stats
)
SELECT l.name,
       l.city,
       l.counts
FROM lib_stats l CROSS JOIN avg_libs a
WHERE l.counts > a.avg_counts
ORDER BY l.counts DESC;
       

--задача 9с средняя ЦТЕ
-- Найти жанры книг, которые брали чаще среднего
-- (чаще, чем в среднем берут книги любого жанра)
-- Вывести: жанр, количество выдач этого жанра
-- Отсортировать по количеству выдач (убывание)

WITH book_stats AS(
    SELECT b.genre,
           COUNT(*) AS loan_book
    FROM books b JOIN loans l On b.id = l.book_id
    GROUP BY b.genre
),
 avgs AS(
        SELECT AVG(loan_book) AS avg_loan
        FROM book_stats
    )
SELECT b.genre,
       b.loan_book
FROM book_stats b CROSS JOIN avgs a
WHERE b.loan_book > a.avg_loan
ORDER BY b.loan_book DESC;


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
       ORDER BY 2 DESC
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



