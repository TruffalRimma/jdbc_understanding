# ---- СОЕДИНЯЕМ ДВЕ ТАБЛИЦЫ / INNER JOIN ----------------------------------------------------

# ПЕРЕЧИСЛИТЬ ВСЕ ЗАКАЗЫ, ВКЛЮЧАЯ НОМЕР И СТОИМОСТЬ ЗАКАЗА,
# А ТАКЖЕ ИМЯ И ЛИМИТ КРЕДИТА КЛИЕНТА, СДЕЛАВШЕГО ЗАКАЗ
SELECT ORDER_NUM, AMOUNT, COMPANY, CREDIT_LIMIT
FROM ORDERS, customers
WHERE CUST = CUST_NUM;

# ВЫВЕСТИ СПИСОК ВСЕХ СЛУЖАЩИХ С ГОРОДАМИ И РЕГИОНАМИ, В КОТОРЫХ ОНИ РАБОТАЮТ
SELECT NAME, CITY, REGION
FROM SALESREPS, OFFICES
WHERE REP_OFFICE = OFFICE;
# JOIN ON
SELECT NAME, CITY, REGION
FROM SALESREPS JOIN OFFICES
                    ON REP_OFFICE = OFFICE;

# ВЫВЕСТИ СПИСОК ОФИСОВ С ИМЕНАМИ И ДОЛЖНОСТЯМИ ИХ РУКОВОДИТЕЛЕЙ
SELECT OFFICE, CITY, NAME, TITLE
FROM OFFICES, salesreps
WHERE MGR = EMPL_NUM;
# JOIN ON -------------------------
SELECT OFFICE, CITY, NAME, TITLE
FROM OFFICES JOIN salesreps
                  ON MGR = EMPL_NUM;
# ВЫВЕСТИ СПИСОК ОФИСОВ, ПЛАН ПРОДАЖ КОТОРЫХ ПРЕВЫШАЕТ 600 000,
# С ИМЕНАМИ И ДОЛЖНОСТЯМИ ИХ РУКОВОДИТЕЛЕЙ
SELECT CITY, NAME, TITLE
FROM OFFICES, salesreps
WHERE MGR = EMPL_NUM AND TARGET > 600000;
# JOIN + WHERE ----------------------------
SELECT CITY, NAME, TITLE
FROM OFFICES JOIN SALESREPS ON MGR = EMPL_NUM
WHERE TARGET > 600000;

# СВЯЗКА СОСТАВНЫХ КЛЮЧЕЙ В ОТНОШЕНИИ ПРЕДОК-ПОТОМОК
# ВЫВЕСТИ СПИСОК ВСЕХ ЗАКАЗОВ, ВКЛЮЧАЯ СТОИМОСТИ И ОПИСАНИЯ ТОВАРОВ
SELECT ORDER_NUM, AMOUNT, DESCRIPTION
FROM ORDERS, products
WHERE MFR = MFR_ID AND PRODUCT = PRODUCT_ID;
# JOIN
SELECT ORDER_NUM, AMOUNT, DESCRIPTION
FROM ORDERS JOIN products
                 ON MFR = MFR_ID AND PRODUCT = PRODUCT_ID;

# ---- СОЕДИНЯЕМ ТРИ ТАБЛИЦЫ ------------------------------------------

# ВЫВСТИ СПИСОК ЗАКАЗОВ СТОИМОСТЬЮ ВЫШЕ 25 000, ВКЛЮЧАЮЩИЙ ИМЯ СЛУЖАЩЕГО,
# ПРИНЯВШЕГО ЗАКАЗ, И ИМЯ КЛИЕНТА, СДЕЛАВШЕГО ЕГО
SELECT ORDER_NUM, AMOUNT, NAME, COMPANY
FROM ORDERS, SALESREPS, customers
WHERE REP = EMPL_NUM AND CUST = CUST_NUM
  AND AMOUNT > 25000;
# JOIN
SELECT ORDER_NUM, AMOUNT, NAME, COMPANY
FROM ORDERS JOIN SALESREPS ON REP = EMPL_NUM
            JOIN customers ON CUST = CUST_NUM
WHERE AMOUNT > 25000;
# КАСКАДНЫЙ ВАРИАНТ
SELECT ORDER_NUM, AMOUNT, NAME, COMPANY
FROM ORDERS, SALESREPS, customers
WHERE CUST = CUST_NUM AND CUST_REP = EMPL_NUM
  AND AMOUNT > 25000;

# ---- СОЕДИНЯЕМ ЧЕТЫРЕ ТАБЛИЦЫ ------------------------------------------

# ВЫВСТИ СПИСОК ЗАКАЗОВ СТОИМОСТЬЮ ВЫШЕ 25 000, ВКЛЮЧАЮЩИЙ ИМЯ КЛИЕНТА, СДЕЛАВШЕГО ЗАКАЗ,
# ИМЯ ЗАКРЕПЛЕННОГО ЗА НИМ СЛУЖАЩЕГО И ОФИС, В КОТОРОМ РАБОТАЕТ ЭТОТ СЛУЖАЩИЙ
SELECT ORDER_NUM, AMOUNT, COMPANY, NAME, CITY
FROM ORDERS JOIN CUSTOMERS ON CUST = CUST_NUM
            JOIN SALESREPS ON REP = EMPL_NUM
            JOIN OFFICES ON REP_OFFICE = OFFICE
WHERE AMOUNT > 25000;

# СРАВНЕНИЕ НЕ ПО ПРЕДКУ-ПОТОМКУ, А ПО ОДИНАКОВЫМ ТИПАМ ДАННЫХ ---------
# НАЙТИ ВСЕ ЗАКАЗЫ, ПОЛУЧЕННЫЕ В ТОТ ДЕНЬ, КОГДА НА РАБОТУ БЫЛ ПРИНЯТ НОВЫЙ СЛУЖАЩИЙ
SELECT ORDER_NUM, AMOUNT, ORDER_DATE, NAME
FROM ORDERS, SALESREPS
WHERE ORDER_DATE = HIRE_DATE
ORDER BY NAME;

# СОЕДИНЕНИЕ ПО НЕРАВЕНСТВУ
# ПЕРЕЧИСЛИТЬ ВСЕ КОМБИНАЦИИ СЛУЖАЩИХ И ОФИСОВ, ГДЕ ПЛАНОВЫЙ ОБЪЕМ ПРОДАЖ СЛУЖАЩЕГО
# БОЛЬШЕ, ЧЕМ ПЛАН КАКОГО-ЛИБО ОФИСА, НЕЗАВИСИМО ОТ МЕСТА РАБОТЫ СЛУЖАЩЕГО
SELECT DISTINCT NAME, QUOTA, CITY, TARGET
FROM SALESREPS, OFFICES
WHERE QUOTA > TARGET;