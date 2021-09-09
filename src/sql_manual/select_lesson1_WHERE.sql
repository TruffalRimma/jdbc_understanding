SELECT * FROM OFFICES;

SELECT COMPANY AS КОМПАНИЯ
FROM customers;

# УБИРАЕМ ДУБЛИКАТЫ
SELECT distinct sum(SALES),sum(distinct TARGET) FROM OFFICES;

SELECT CITY, TARGET, SALES FROM OFFICES;

SELECT CITY, TARGET, SALES FROM OFFICES WHERE REGION = 'Eastern';
# ОФИСЫ В КОТОРЫХ ФАКТИЧЕСКИЕ ОБЪЕМЫ ПРОДАЖ ПРЕВЫСИЛИ ПЛАНОВЫЕ
SELECT CITY, SALES, TARGET FROM OFFICES WHERE SALES > TARGET;
# СПИСОК ВСЕХ СЛУЖАЩИХ МЕНЕДЖЕРОМ КОТОРЫХ ЯВЛЯЕТСЯ БОБ СМИТ(ИДЕНТИФИКАТОР 104)
SELECT NAME, SALES FROM SALESREPS WHERE MANAGER = 104;

# ПРЕДИКАТЫ + WHERE
# -------------------------------------------------------
SELECT CITY, TARGET, SALES
FROM OFFICES WHERE REGION = 'Eastern'
               AND SALES > TARGET
ORDER BY TARGET;

# НАЙТИ ИМЕНА ВСЕХ СЛУЖАЩИХ ПРИНЯТЫЙ НА РАБОТУ ДО 2006 ГОДА
SELECT NAME FROM SALESREPS WHERE HIRE_DATE < '2006-01-01';
# ВЫВЕСТИ СПИСОК ОФИСОВ, ФАКТИЧЕСКИЕ ОБЪЕМЫ ПРОДАЖ В КОТОРЫХ СОСТАВИЛИ МЕНЕЕ 80 ПРОЦЕНТОВ ОТ ПЛАНОВЫХ
SELECT CITY, SALES, TARGET FROM OFFICES WHERE SALES < (0.8 * TARGET);
# ВЫВЕСТИ СПИСОК ОФИСОВ, МЕНЕДЖЕРОМ КОТОРЫХ НЕ ЯВЛЯЕТСЯ СЛУЖАЩИЙ С ИДЕНТИФИКАТОРОМ 108
SELECT * FROM OFFICES WHERE MGR != 108;
SELECT * FROM OFFICES WHERE MGR <> 108;

# МЕНЯЕМ ФОРМАТ ПО УМОЛЧАНИЮ ДЛЯ ДАТ
# ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


# ДИАПАЗОН ЗНАЧЕНИЙ
# ----------------------------------------
# НАЙТИ ВСЕ ЗАКАЗЫ, СДЕЛАННЫЕ В ПОСЛЕДНЕМ КВАРТАЛЕ 2007 ГОДА
SELECT * FROM ORDERS WHERE ORDER_DATE BETWEEN '2007-10-01' AND '2007-12-31';
# ВЫВЕСТИ СПИСОК СЛУЖАЩИХ, ФАКТИЧЕСКИЕ ОБЪЕМЫ ПРОДАЖ КОТОРЫХ НЕ ПОПАДАЮТ В ДИАПАЗОН ОТ 80 ДО 120 ПРОЦЕНТОВ ПЛАНА
# ИНВЕРТИРОВАННАЯ ВЕРСИЯ ПРОВЕРКИ НА ПРИНАДЛЕЖНОСТЬ ДИАПАЗОНУ
SELECT NAME, SALES, QUOTA FROM SALESREPS WHERE SALES NOT BETWEEN (0.8 * QUOTA) AND (1.2 * QUOTA);

# IN (КАК SWITCH CASE В ЖАБЕ) - ПРОВЕРКА НА НАЛИЧИЕ ВО МНОЖЕСТВЕ
# -------------------------------------------
# ВЫВЕСТИ СПИСОК СЛУЖАЩИХ, РАБОТАЮЩИЙ В НЬЮ-ЙОРКЕ, АТЛАНТЕ
SELECT MGR FROM OFFICES WHERE CITY IN ('New York', 'Atlanta');
SELECT MGR FROM OFFICES WHERE CITY NOT IN ('New York', 'Atlanta');


# LIKE - ПРОВЕРКА НА СООТВЕТСТВИЕ ШАБЛОНУ + ПОДСТАНОВОЧНЫЕ ЗНАКИ % _ (МОЖНО КОМБИНИРОВАТЬ)
# -------------------------------------------
# ПОКАЗАТЬ ЛИМИТ КРЕДИТА ДЛЯ Smithson Corp. - ТОЛЬКО ДЛЯ СТРОК
SELECT COMPANY, CREDIT_LIMIT FROM CUSTOMERS WHERE COMPANY LIKE binary '%Ith%';
SELECT COMPANY, CREDIT_LIMIT FROM CUSTOMERS WHERE COMPANY LIKE 'Smiths_n Corp.';
SELECT COMPANY, CREDIT_LIMIT FROM CUSTOMERS WHERE COMPANY NOT LIKE 'Smiths_n %';


# IS NULL - ПРОВЕРКА НА РАВЕНСТВО NULL
# -------------------------------------------
# НАЙТИ СЛУЖАЩЕГО, КОТОРЫЙ ЕЩЕ НЕ ЗАКРЕПЛЕН ЗА ОФИСОМ
SELECT NAME FROM SALESREPS WHERE REP_OFFICE IS NULL;
SELECT NAME FROM SALESREPS WHERE REP_OFFICE IS NOT NULL;


# AND / OR / NOT - СОСТАВНЫЕ УСЛОВИЯ ОТБОРА
# -------------------------------------------
# НАЙТИ ВСЕХ СЛУЖАЩИХ, КОТОРЫЕ
# А) РАБОТАЮТ В ДЕНВЕРЕ, НЬЮ ЙОРКЕ ИЛИ ЧИКАГО
# ИЛИ Б) НЕ ИМЕЮТ МЕНЕДЖЕРА И БЫЛИ ПРИНЯТЫ НА РАБОТУ ПОСЛЕ ИЮНЯ 2006 ГОДА
# ИЛИ В) У КОТОРЫХ ПРОДАЖИ ПРЕВЫСИЛИ ПЛАНОВЫЙ ОБЪЕМ, НО НЕ ПРЕВЫСИЛИ 600 000
SELECT * FROM SALESREPS
WHERE (REP_OFFICE IN (11, 12, 22))
   OR ((MANAGER IS NULL) AND (HIRE_DATE > '2006-06-01'))
   OR (SALES BETWEEN QUOTA AND 600000.00);


SELECT AVG(SALES) FROM salesreps;

SELECT CITY, REGION, (SALES - TARGET) AS DIFFERENCE FROM OFFICES;

SELECT NAME, MONTH(HIRE_DATE), YEAR(HIRE_DATE) FROM salesreps;

# СПИСОК ОБЪЕМОВ ПРОДАЖ ДЛЯ КАЖДОГО ГОРОДА
# ИСПОЛЬЗУЕМ КОНСТАНТЫ ДЛЯ БОЛЕЕ УДОБНОГО ВЫВОДА
SELECT CITY, 'HAS SALES OF', SALES FROM offices;

