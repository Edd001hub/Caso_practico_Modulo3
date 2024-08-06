-- a) Crear la base de datos con el archivo create_restaurant_db.sql

-- Restuarante

SELECT * 
From menu_items;

SELECT * 
From order_details;

-- b) Explorar la tabla “menu_items” para conocer los productos del menú.
    -- 1.- Realizar consultas para contestar las siguientes preguntas

 -- Encintrar el número de artículos en el menú.
SELECT COUNT(*) 
FROM menu_items;
--R: 32

--¿Cuál es el artículo menos caro y el más caro del menú?
SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MIN(price)FROM menu_items);
--R: 5

SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MAX(price)FROM menu_items);
--R: 19.95

-- ¿Cuantos platos americanos hay en el menú?
SELECT COUNT(*) 
FROM menu_items
WHERE category = 'American';
--R: 6

-- ¿Cuál es el precio promedio de los platos?
SELECT  avg(price)
FROM menu_items;
--R: 13.285937


--  c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados
 -- 1.- Realizar consultas para contestar las siguientes preguntas:

SELECT * 
FROM order_details;

-- ¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT(*) 
FROM order_details;
-- R: 12,234

-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?

SELECT COUNT (order_details_id), order_id
FROM order_details
GROUP BY order_id
ORDER BY 1 DESC
LIMIT 5;

--  order_details/Order_id
-- 14 / 440
-- 14 / 2675
-- 14 / 3473
-- 14 / 4305
-- 14 / 443



-- ¿Cuándo se realizó el primer pedido y el último pedido?
SELECT MIN(order_date) AS primer_pedido, MAX(order_date) AS ultimo_pedido
FROM order_details;
-- R:primer periodo 2023-01-01 último pedido 2023-03-31

-- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT COUNT(*)
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

-- R: 702

-- d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
 -- 1.- Realizar un left join entre entre order_details y menu_items con el identificadoitem_id(tabla order_details) y menu_item_id(tabla menu_items)
	 
SELECT * FROM menu_items as mn
left join order_details as od
on od.item_id = mn.menu_item_id;


-- ¿Cual es el itme_name mas vendido  y cuales fueron sus ganancias por el mismo?

SELECT item_name, count(od.order_details_id) as  recuento_ventas, sum(mn.price)
FROM menu_items as mn
left join order_details as od
on od.item_id = mn.menu_item_id
group by item_name
order by recuento_ventas desc
limit 5

-- ¿Cuál fue el tipo de comida mas vendido de entre las 4 categiras ?

SELECT category, sum(mn.price) as ventas_totales
FROM menu_items as mn
left join order_details as od
on od.item_id = mn.menu_item_id
group by category
order by ventas_totales desc;

-- ¿ Cuales fueron las ventas realizadas por mes ?

SELECT
DATE_TRUNC('month', od.order_date) AS mes,
SUM(price) AS ventas_totales
FROM menu_items as mn
left join order_details as od
on od.item_id = mn.menu_item_id
GROUP BY mes
ORDER BY ventas_totales DESC;


