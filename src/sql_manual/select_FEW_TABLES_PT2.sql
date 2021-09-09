# КВАЛИФИЦИРОВАННЫЕ ИМЕНА СТОЛБЦОВ
# ПОКАЗАТЬ ИМЯ, ОФИС И ОБЪЕМ ПРОДАЖ КАЖДОГО СЛУЖАЩЕГО
SELECT NAME, CITY, salesreps.SALES
FROM SALESREPS JOIN OFFICES ON REP_OFFICE = OFFICE;

# * - ВСЕ СТОЛБЦЫ ИЗ ВСЕХ ТАБЛИЦ
# СООБЩИТЬ ВСЮ ИНФОРМАЦИЮ О СЛУЖАЩИХ И ОФИСАХ, В КОТОРЫХ ОНИ РАБОТАЮТ
SELECT * FROM SALESREPS, OFFICES
WHERE REP_OFFICE = offices.OFFICE;

# САМОСОЕДИНЕНИЯ
# ВЫВЕСТИ СПИСОК ВСЕХ СЛУЖАЩИХ И ИХ РУКОВОДИТЕЛЕЙ
SELECT EMPS.NAME, MGRS.NAME
FROM salesreps EMPS, salesreps MGRS
WHERE EMPS.MANAGER = MGRS.EMPL_NUM;

# ДЕКАРТОВО ПРОИЗВЕДЕНИЕ
# ПОКАЗАТЬ ВСЕ ВОЗМОЖНЫЕ КОМБИНАЦИИ СЛУЖАЩИХ И ГОРОДОВ
SELECT NAME, CITY FROM salesreps, offices;

# OUTER JOIN - ВНЕШНИЕ СОЕДИНЕНИЯ ---------------------------------------------
# ВЫВЕСТИ СПИСОКСЛУЖАЩИХ И ГОРОДОВ, ГДЕ ОНИ РАБОТАЮТ
SELECT NAME, CITY, REGION
FROM SALESREPS INNER JOIN OFFICES
                          ON REP_OFFICE = OFFICE;
SELECT NAME, CITY, REGION
FROM SALESREPS LEFT JOIN OFFICES
                         ON REP_OFFICE = OFFICE;
# UNION - добавь для FULL JOIN / OUTER НЕ ОБЯЗАТЕЛЬНО
SELECT NAME, CITY, REGION
FROM SALESREPS RIGHT OUTER JOIN OFFICES
                                ON REP_OFFICE = OFFICE;

# CROSS JOIN - ДЕКАРТОВО ПРОИЗВЕДЕНИЕ - ВСЕ ВОЗМОЖНЫЕ КОМБИНАЦИИ - БЕЗ NULL
SELECT DISTINCT NAME, CITY, REGION
FROM SALESREPS CROSS JOIN OFFICES;

# UNION JOIN -
SELECT NAME, CITY, REGION
FROM SALESREPS LEFT JOIN OFFICES
                         ON REP_OFFICE = OFFICE
UNION ALL
SELECT NAME, CITY, REGION
FROM SALESREPS RIGHT OUTER JOIN OFFICES
                                ON REP_OFFICE = OFFICE;