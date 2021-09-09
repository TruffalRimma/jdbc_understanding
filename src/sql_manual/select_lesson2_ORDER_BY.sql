# ПОКАЗАТЬ ФАКТИЧЕСКИЕ ОБЪЕМЫ ПРОДАЖ ДЛЯ КАЖДОГО ОФИСА,
# ОТСОРТИРОВАННЫЕ В АЛФАВИТНОМ ПОРЯДКЕ ПО РЕГИОНАМ, А В КАЖДОМ РЕГИОНЕ ПО ГОРОДАМ
SELECT CITY, REGION, SALES
FROM offices
ORDER BY REGION, CITY;

# DESC - СОРТИРОВКА ПО УБЫВАНИЮ
# ВЫВЕСТИ СПИСОК ОФИСОВ, ОТСОРТИРОВАННЫЙ ПО ФАКТИЧЕСКИМ ОБЪЕМАМ ПРОДАЖ В ПОРЯДКЕ УБЫВАНИЯ
SELECT *
FROM OFFICES
ORDER BY SALES DESC;

# ИСПОЛЬЗОВАНИЕ НОМЕРА СТОЛБЦА - НЕ РЕКОМЕНДУЕТСЯ
# ВЫВЕСТИ СПИСОК ВСЕХ ОФИСОВ, ОТСОРТИРОВАННЫЙ ПО РАЗНОСТИ МЕЖДУ ФАКТИЧЕСКИМ И ПЛАНОВЫМ
# ОБЪЕМАМИ ПРОДАЖ В ПОРЯДКЕ УБЫВАНИЯ
SELECT CITY, REGION, (SALES - TARGET)
FROM offices
ORDER BY 3 DESC;

# UNION / UNION ALL (СОХРАНЯЕТ ДУБЛИКАТЫ) - ОБЪЕДИНЕНИЕ РЕЗУЛЬТАТОВ НЕСКОЛЬКИХ ЗАПРОСОВ
# ВЫВЕСТИ СПИСОК ВСЕХ ТОВАРОВ, ЦЕНА КОТОРЫХ ПРЕВЫШАЕТ 2000
# ИЛИ КОТОРЫХ БЫЛО ЗАКАЗАНО БОЛЕЕ ЧЕМ НА 30 000 ЗА ОДИН РАЗ
# СПИСОК ОТСОРТИРОВАТЬ ПО НАИМЕНОВАНИЮ ПРОИЗВОДИТЕЛЯ И НОМЕРУ ТОВАРА
SELECT MFR_ID, PRODUCT_ID
FROM PRODUCTS
WHERE PRICE > 2000.00
UNION
SELECT DISTINCT MFR, PRODUCT
FROM orders
WHERE AMOUNT > 30000.00
ORDER BY 1, 2;
