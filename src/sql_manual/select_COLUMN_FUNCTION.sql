# ---------------------- АГРЕГИРУЮЩИЕ ФУНКЦИИ -----------------------
# СТАТИСТИЧЕСКИЕ ФУНКЦИИ --------------------------------------------
# КАКОВЫ СРЕДНИЙ ПЛАНОВЫЙ И СРЕДНИЙ ФАКТИЧЕСКИЙ ОБЪЕМЫ ПРОДАЖ У ПРОДАВЦОВ
SELECT AVG(QUOTA), AVG(SALES)
FROM salesreps;

# КАКОЙ СРЕДНИЙ ПРОЦЕНТ ВЫПОЛНЕНИЯ ПЛАНА В КОМПАНИИ
SELECT AVG(100 * (SALES/QUOTA))
FROM salesreps;

# КАКОВА СУММА ВСЕХ ЗАКАЗОВ, ПРИНЯТЫХ БИЛЛОМ АДАМСОМ?
SELECT SUM(AMOUNT)
FROM ORDERS, salesreps
WHERE NAME = 'Bill Adams' AND REP = EMPL_NUM;

# КАКОВЫ НАИБОЛЬШИЙ И НАИМЕНЬШИЙ ПЛАНОВЫЕ ОБЪЕМЫ ПРОДАЖ
SELECT MIN(QUOTA), MAX(QUOTA)
FROM salesreps;

# СКОЛЬКО ИМЕЕТСЯ ЗАКАЗОВ СТОИМОСТЬЮ БОЛЕЕ 25 000
SELECT COUNT(AMOUNT)
FROM orders
WHERE AMOUNT > 25000;

SELECT COUNT(REP_OFFICE) FROM salesreps;
SELECT COUNT(*) FROM salesreps;

# СКОЛЬКО РАЗЛИЧНЫХ ДОЛЖНОСТЕЙ СУЩЕСТВУЕТ В КОМПАНИИ
SELECT COUNT(DISTINCT TITLE) FROM salesreps;

# GROUP BY ------------------------------------------------------------
# КАКОВА СРЕДНЯЯ СТОИМОСТЬ ЗАКАЗА ДЛЯ КАЖДОГО СЛУЖАЩЕГО
SELECT REP, AVG(AMOUNT)
FROM ORDERS
GROUP BY REP;

# СКОЛЬКО СЛУЖАЩИХ РАБОТАЕТ В КАЖДОМ ОФИСЕ
SELECT REP_OFFICE, COUNT(*)
FROM salesreps
GROUP BY REP_OFFICE;

# СКОЛЬКО КЛИЕНТОВ ОБСЛУЖИВАЕТ КАЖДЫЙ СЛУЖАЩИЙ
SELECT COUNT(DISTINCT CUST_NUM) AS CLIENTS, 'CUSTOMERS FOR REPRESENTATIVE', CUST_REP
FROM customers, salesreps
GROUP BY CUST_REP
ORDER BY CLIENTS;

# WITH ROLLUP - ПОДСЧИТАТЬ ОБЩУЮ СУММУ ЗАКАЗОВ ПО КАЖДОМУ КЛИЕНТУ ДЛЯ КАЖДОГО СЛУЖАЩЕГО
# С ПРОМЕЖУТОЧНЫМИ ИТОГАМИ ДЛЯ КАЖДОГО СЛУЖАЩЕГО
SELECT REP, CUST, SUM(AMOUNT)
FROM orders
GROUP BY REP, CUST;

SELECT REP, CUST, SUM(AMOUNT)
FROM orders
GROUP BY REP, CUST WITH ROLLUP;

# HAVING ---------------------------
# СРЕДНЯЯ СТОИМОСТЬ ЗАКАЗА ДЛЯ КАЖДОГО СЛУЖАЩЕГО ИЗ ЧИСЛА ТЕХ, У КОТОРЫХ
# ОБЩАЯ СТОИМОСТЬ ЗАКАЗОВ ПРЕВЫШАЕТ 30 000
SELECT REP, AVG(AMOUNT)
FROM orders
GROUP BY REP
HAVING SUM(AMOUNT) > 30000;

# ПОКАЗАТЬ ЦЕНУ, КОЛИЧЕСТВО НА СКЛАДЕ И ОБЩЕЕ КОЛИЧЕСТВО ЗАКАЗАННЫХ ЕДИНИЦ
# ДЛЯ КАЖДОГО НАИМЕНОВАНИЯ ТОВАРА, ЕСЛИ ДЛЯ НЕГО ОБЩЕЕ КОЛИЧЕСТВО ЗАКАЗАННЫХ ЕДИНИЦ
# ПРЕВЫШАЕТ 75 ПРОЦЕНТОВ ОТ КОЛИЧЕСТВА ТОВАРА НА СКЛАДЕ
SELECT DESCRIPTION, PRICE, QTY_ON_HAND, SUM(QTY)
FROM products JOIN orders ON MFR_ID = MFR and PRODUCT_ID = PRODUCT
GROUP BY DESCRIPTION, PRICE, QTY_ON_HAND WITH ROLLUP
HAVING SUM(QTY) > (0.75 * QTY_ON_HAND)
ORDER BY QTY_ON_HAND DESC;