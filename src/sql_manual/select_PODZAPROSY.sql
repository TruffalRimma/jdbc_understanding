# ПОДЗАПРОСЫ И ВЫРАЖЕНИЯ С ЗАПРОСАМИ------------
# ВЫВЕСТИ СПИСОК СЛУЖАЩИХ, ЧЕЙ ПЛАНОВЫЙ ОБЪЕМ ПРОДАЖ СОСТАВЛЯЕТ МЕНЕЕ 10 %
# ОТ ПЛАНОВОГО ОБЪЕМА ПРОДАЖ ВСЕЙ КОМПАНИИ
SELECT NAME FROM salesreps
WHERE QUOTA < (.1 * (SELECT SUM(TARGET) FROM offices));

SELECT (0.1 * SUM(TARGET)) FROM offices;

# ВЫВЕСТИ СПИСОК ОФИСОВ, В КОТОРЫХ ПЛАНОВЫЙ ОБЪЕМ ПРОДАЖ ПРЕВЫШАЕТ
# СУММУ ПЛАНОВЫХ ОБЪЕМОВ ПРОДАЖ ВСЕХ СЛУЖАЩИХ
SELECT CITY
FROM OFFICES
WHERE TARGET > (SELECT SUM(QUOTA) FROM salesreps
                WHERE REP_OFFICE = offices.OFFICE);
# OFFICE - ВНЕШНЯЯ ССЫЛКА

# СРАВНЕНИЕ С РЕЗУЛЬТАТОМ ПОДЗАПРОСА ---------------------
# ВЫВЕСТИ СПИСОК СЛУЖАЩИХ, У КОТОРЫХ ПЛАНОВЫЙ ОБЪЕМ ПРОДАЖ НЕ МЕНЬШЕ
# ПЛАНОВОГО ОБЪЕМА ПРОДАЖ В АТЛАНТЕ
SELECT NAME
FROM salesreps
WHERE QUOTA >= (SELECT TARGET
                FROM offices
                WHERE CITY = 'Atlanta');

# ПРОВЕРКА НА ПРИНАДЛЕЖНОСТЬ РЕЗУЛЬТАТАМ ПОДЗАПРОСА (IN) ------------
# ВЫВЕСТИ СПИСОК СЛУЖАЩИХ ТЕХ ОФИСОВ, ГДЕ ФАКТИЧЕСКИЙ ОБЪЕМ ПРОДАЖ ПРЕВЫШАЕТ ПЛАНОВЫЙ
SELECT NAME
FROM salesreps
WHERE REP_OFFICE IN (SELECT OFFICE
                     FROM offices
                     WHERE offices.SALES > offices.TARGET);

# ВЫВЕСТИ СПИСОК ВСЕХ КЛИЕНТОВ, ЗАКАЗАВШИХ ИЗДЕЛИЯ КОМПАНИИ ACI
# ПРОИЗВОДИТЕЛЬ ACI + ИДЕНТИФИКАТОР 4100) В ПЕРИОД МЕЖДУ ЯНВАРЕМ И ИЮНЕМ 2008 ГОДА
SELECT COMPANY
FROM customers
WHERE CUST_NUM IN (SELECT CUST FROM orders
                   WHERE ORDER_DATE BETWEEN '2008-01-01' AND '2008-06-01'
                     AND MFR = 'ACI' AND PRODUCT LIKE '4100_');

# ПРОВЕРКА СУЩЕСТВОВАНИЯ - EXISTS ---------------------------------------------
# ВЫВЕСТИ СПИСОК КЛИЕНТОВ, ЗАКРЕПЛЕННЫХ ЗА SUE SMITH
# КОТОРЫЕ НЕ РАЗМЕСТИЛИ ЗАКАЗЫ НА СУММУ СВЫШЕ 3000
SELECT COMPANY
FROM customers
WHERE CUST_REP = 102 AND NOT EXISTS(SELECT *
                                    FROM orders
                                    WHERE CUST = customers.CUST_NUM
                                      AND AMOUNT > 3000);

# МНОГОКРАТНОЕ СРАВНЕНИЕ - ANY = SOME / ALL -------------------
# ВЫВЕСТИ СПИСОК СЛУЖАЩИХ, ПРИНЯВШИХ ЗАКАЗ НА СУММУ, ПРЕВЫШАЮЩУЮ 10% ПЛАНА
SELECT NAME
FROM salesreps
WHERE (0.1 * salesreps.QUOTA) < SOME (SELECT AMOUNT FROM orders
                                      WHERE REP = salesreps.EMPL_NUM);

# ВЫВЕСТИ СПИСОК ОФИСОВ С ПЛАНОВЫМИ ОБЪЕМАМИ ПРОДАЖ, У ВСЕХ СЛУЖАЩИХ КОТОРЫХ
# ФАКТИЧЕСКИЙ ОБЪЕМ ПРОДАЖ ПРЕВЫШАЕТ 50 ПРОЦЕНТОВ ОТ ПЛАНА ОФИСА
SELECT CITY, TARGET
FROM OFFICES
WHERE (0.5 * offices.TARGET) < ALL (SELECT SALES
                                    FROM salesreps
                                    WHERE REP_OFFICE = offices.OFFICE);

# ВЛОЖЕННЫЕ ПОДЗАПРОСЫ ------------------------------------
# ВЫВЕСТИ СПИСОК КЛИЕНТОВ, ЗАКРЕПЛЕННЫХ ЗА СЛУЖАЩИМИ, РАБОТАЮЩИМИ В ОФИСАХ ВОСТОЧНОГО РЕГИОНА
SELECT COMPANY
FROM customers
WHERE CUST_REP IN (SELECT EMPL_NUM
                   FROM salesreps
                   WHERE REP_OFFICE = ANY (SELECT OFFICE
                                           FROM offices
                                           WHERE REGION = 'Eastern'));

# ----------------------- HAVING ПОДЗАПРОСЫ ---------------------
# ВЫВЕСТИ СПИСОК СЛУЖАЩИХ, У КОТОРЫХ СРЕДНЯЯ СТОИМОСТЬ ЗАКАЗОВ НА ТОВАРЫ,
# ИЗГОТОВЛЕННЫЕ КОМПАНИЕЙ ACI, ВЫШЕ, ЧЕМ ОБЩАЯ СРЕДНЯЯ СТОИМОСТЬ ЗАКАЗОВ
SELECT NAME, AVG(AMOUNT)
FROM salesreps, orders
WHERE EMPL_NUM = orders.REP
  AND MFR = 'ACI'
GROUP BY NAME
HAVING AVG(AMOUNT) > (SELECT AVG(AMOUNT) FROM orders);

# ----------------- UNION / EXCEPT / INTERSECT ------------------------------
# ВЫВЕСТИ СПИСОК ТОВАРОВ, ДЛЯ КОТОРЫХ ИМЕЮТСЯ ЗАКАЗЫ НА СУММУ БОЛЕЕ 30 000,
# А ТАКЖЕ ТЕХ ТОВАРОВ, КОТОРЫХ НА СКЛАДЕ ИМЕЕТСЯ НА СУММУ БОЛЕЕ 30 000
# СЛОЖЕНИЕ ТАБЛИЦ
(SELECT MFR, PRODUCT
 FROM orders
 WHERE AMOUNT > 30000)
UNION
(SELECT MFR_ID, PRODUCT_ID
 FROM products
 WHERE PRICE * QTY_ON_HAND > 30000);

# ВЫВЕСТИ СПИСОК ТОВАРОВ, ДЛЯ КОТОРЫХ ИМЕЮТСЯ ЗАКАЗЫ НА СУММУ БОЛЕЕ 30 000,
# И КОТОРЫХ ПРИ ЭТОМ НА СКЛАДЕ ИМЕЕТСЯ НА СУММУ БОЛЕЕ 30 000
# УМНОЖЕНИЕ ТАБЛИЦ
(SELECT MFR, PRODUCT
 FROM orders
 WHERE AMOUNT > 30000);
# INTERSECT
(SELECT MFR_ID, PRODUCT_ID
 FROM products
 WHERE PRICE * QTY_ON_HAND > 30000);

# ВЫВЕСТИ СПИСОК ТОВАРОВ, ДЛЯ КОТОРЫХ ИМЕЮТСЯ ЗАКАЗЫ НА СУММУ БОЛЕЕ 30 000,
# ЗА ИСКЛЮЧЕНИЕМ ТЕХ, КОТОРЫЕ СТОЯТ МЕНЕЕ 100
# ВЫЧИТАНИЕ ТАБЛИЦ
(SELECT MFR, PRODUCT
 FROM orders
 WHERE AMOUNT > 30000);
# EXCEPT
(SELECT MFR_ID, PRODUCT_ID
 FROM products
 WHERE PRICE < 100);