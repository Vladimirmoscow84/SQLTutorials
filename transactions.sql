-- Последний баланс клиента
-- 
-- Таблица: Transactions
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | transaction_id   | int     |
-- | account_id       | int     |
-- | type             | varchar |
-- | amount           | int     |
-- | transaction_date | date    |
-- +------------------+---------+
-- 
-- - (transaction_id) — это первичный ключ.
-- - (account_id, transaction_date) — уникальная комбинация.
-- - Тип type может быть 'deposit' или 'withdraw'.
-- - Баланс каждого счёта начинается с 0.
-- 
-- Задание
-- 
-- Найдите баланс счёта для каждого account_id на дату 2022-12-31, учитывая все транзакции до этой даты.
-- Если по счёту не было транзакций до этой даты, баланс равен 0.
-- Верните account_id и balance.
-- Верните результат в любом порядке.
--
-- Пример
-- 
-- Ввод:
-- +----------------+------------+----------+--------+------------------+
-- | transaction_id | account_id | type     | amount | transaction_date |
-- +----------------+------------+----------+--------+------------------+
-- | 1              | 1          | deposit  | 2000   | 2022-11-01       |
-- | 2              | 1          | withdraw | 1000   | 2022-11-10       |
-- | 3              | 2          | deposit  | 3000   | 2022-12-01       |
-- | 4              | 2          | withdraw | 2000   | 2023-01-01       |
-- | 5              | 3          | deposit  | 1000   | 2023-01-01       |
-- +----------------+------------+----------+--------+------------------+
--
-- Вывод:
-- +------------+---------+
-- | account_id | balance |
-- +------------+---------+
-- | 1          | 1000    |
-- | 2          | 3000    |
-- | 3          | 0       |
-- +------------+---------+
--
-- Решение

WITH account_list AS(
    SELECT DISTINCT(account_id)
    FROM transactions
),
balances AS(
   SELECT account_id,
    SUM(
        CASE 
            WHEN type = 'deposit' THEN amount
            WHEN type = 'withdraw' THEN -amount
            ELSE 0
        END
    ) AS balance
    FROM transactions
    WHERE transaction_date<='2022-12-31'
    GROUP BY account_id
)
SELECT a.account_id,
       COALESCE(b.balance,0) As balance
FROM account_list a
LEFT JOIN balances b ON a.account_id = b.account_id
ORDER BY 1;