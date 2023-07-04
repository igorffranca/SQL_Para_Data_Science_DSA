CREATE DATABASE exec04;

USE exec04;

# TABELAS

CREATE TABLE exec04.channels(
	channel_id int null,
	channel_name varchar(50) null,
	channel_type varchar(100) null
);

CREATE TABLE exec04.drivers(
	driver_id int null,
	driver_modal varchar(50) null,
	driver_type varchar(100) null
);

CREATE TABLE exec04.hub(
	hub_id int null,
	hub_name varchar(100) null,
	hub_city varchar(50) null,
	hub_state varchar(50) null,
	hub_latitude varchar(50) null,
	hub_longitude varchar(50) null
);

CREATE TABLE exec04.payments(
	payment_order_id int null,
	payment_id int null,
	payment_amount decimal(10,2) null,
	payment_fee decimal(10,2) null,
	payment_method varchar(50) null,
	payment_status varchar(50) null

);

CREATE TABLE exec04.stores(
	store_id int null,
	hub_id int null,
	store_name varchar(100) null,
	store_segment varchar(100) null,
	store_plan_price decimal(10,2) null,
	store_latitude varchar(50) null,
	store_longitude varchar(50)
);

CREATE TABLE exec04.deliveries(
	delivery_id int null,
	delivery_order_id int null,
	driver_id int null,
	delivery_distance_meters int null,
	delivery_status varchar(50) null
);

CREATE TABLE exec04.orders(
	order_id int null,
	store_id int null,
	channel_id int null,
	payment_order_id int null,
	delivery_order_id int null,
	order_status varchar(50) null,
	order_amount int null,
	order_delivery_fee int null,
	order_delivery_cost varchar(100) null,
	order_created_hour int null,
	order_created_minute int null,
	order_created_day int null,
	order_created_month int null,
	order_created_year int null,
	order_moment_created varchar(100) null,
	order_moment_accepted varchar(100) null,
	order_moment_ready varchar(100) null,
	order_moment_collected varchar(100) null,
	order_moment_in_expedition varchar(100) null,
	order_moment_delivering varchar(100) null,
	order_moment_delivered varchar(100) null,
	order_moment_finished varchar(100) null,
	order_metric_collected_time varchar(100) null,
	order_metric_paused_time varchar(100) null,
	order_metric_production_time varchar(100) null,
	order_metric_walking_time varchar(100) null,
	order_metric_expedition_speed_time varchar(100) null,
	order_metric_transit_time varchar(100) null,
	order_metric_cycle_time varchar(100) null
);


LOAD DATA LOCAL INFILE 'C:/Users/igorf/Documents/MEGA/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_5/Delivery_Center_Food&Goods_orders_in_Brazil/channels.csv' INTO TABLE `exec04`.`channels` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/igorf/Documents/MEGA/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_5/Delivery_Center_Food&Goods_orders_in_Brazil/deliveries.csv' INTO TABLE `exec04`.`deliveries` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/igorf/Documents/MEGA/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_5/Delivery_Center_Food&Goods_orders_in_Brazil/drivers.csv' INTO TABLE `exec04`.`drivers` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/igorf/Documents/MEGA/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_5/Delivery_Center_Food&Goods_orders_in_Brazil/hubs.csv' INTO TABLE `exec04`.`hub` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/igorf/Documents/MEGA/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_5/Delivery_Center_Food&Goods_orders_in_Brazil/orders.csv' INTO TABLE `exec04`.`orders` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/igorf/Documents/MEGA/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_5/Delivery_Center_Food&Goods_orders_in_Brazil/payments.csv' INTO TABLE `exec04`.`payments` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/igorf/Documents/MEGA/Faculdade/Cursos/Formacao_Analista_de_dados/SQL_para_Data_Science/Capitulo_5/Delivery_Center_Food&Goods_orders_in_Brazil/stores.csv' INTO TABLE `exec04`.`stores` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY "" LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Exercicios

# 1-Qual o número de hubs por cidade?

SELECT count(hub_id) as contagem, hub_city
FROM exec04.hub
GROUP BY hub_city
ORDER BY contagem DESC;

# 2-Qual o número de pedidos (orders) por status?

SELECT count(order_id) as 'Qtd de Pedidos', order_status
FROM exec04.orders 
GROUP BY order_status
ORDER BY order_status DESC;

# 3-Qual o número de lojas (stores) por cidade dos hubs?

SELECT count(S.store_id) as 'Qtd de Stores', H.hub_city
FROM exec04.stores S, exec04.hub H
WHERE S.hub_id = H.hub_id
GROUP BY H.hub_city
ORDER BY count(S.store_id);

# 4-Qual o maior e o menor valor de pagamento (payment_amount) registrado?

SELECT min(payment_amount) as menor, round(max(payment_amount),2) as maior
FROM exec04.payments;

# 5-Qual tipo de driver (driver_type) fez o maior número de entregas?

SELECT count(DL.delivery_id) as 'Qtd de entregas', driver_type as tipo
FROM exec04.drivers D, exec04.deliveries DL
GROUP BY tipo
ORDER BY count(delivery_id);

# 6-Qual a distância média das entregas por tipo de driver (driver_modal)?

SELECT round(avg(DL.delivery_distance_meters),2) as distancia, D.driver_modal
FROM exec04.deliveries DL, exec04.drivers D
WHERE DL.driver_id = D.driver_id 
GROUP BY D.driver_modal;

# 7-Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?

SELECT round(avg(O.order_amount),2) as media, S.store_name
FROM exec04.orders O, exec04.stores S
WHERE O.store_id = S.store_id
GROUP BY S.store_name
ORDER BY media DESC;

# 8-Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?

SELECT count(O.order_id) as contagem, CASE WHEN S.store_name is NULL THEN 'Nao Associados' ELSE S.store_name END as store_name
FROM exec04.orders O LEFT JOIN exec04.stores S
ON O.store_id = S.store_id
GROUP BY store_name
ORDER BY contagem;

# 9-Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?

SELECT sum(O.order_amount) as soma, C.channel_name
FROM exec04.orders O, exec04.channels C
WHERE O.channel_id = C.channel_id
GROUP BY C.channel_name
HAVING C.channel_name = 'FOOD PLACE';

# 10-Quantos pagamentos foram cancelados (chargeback)?

SELECT count(payment_order_id) as 'Qtd de pagamentos', payment_status
FROM exec04.payments
GROUP BY payment_status
HAVING payment_status = 'chargeback';

# 11-Qual foi o valor médio dos pagamentos cancelados (chargeback)?

SELECT round(avg(payment_amount),2) as 'Qtd de pagamentos', payment_status
FROM exec04.payments
GROUP BY payment_status
HAVING payment_status = 'chargeback';


# 12-Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?

SELECT round(avg(payment_amount),2) as media, payment_method
FROM exec04.payments
GROUP BY payment_method
ORDER BY media DESC;

# 13-Quais métodos de pagamento tiveram valor médio superior a 100?

SELECT round(avg(payment_amount),2) as media, payment_method
FROM exec04.payments
GROUP BY payment_method
HAVING media > 100
ORDER BY media;

# 14-Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?

SELECT round(avg(O.order_amount),2) as media, H.hub_state, S.store_segment, C.channel_type
FROM exec04.orders O 
INNER JOIN exec04.hub H 
INNER JOIN exec04.stores S 
INNER JOIN exec04.channels C
ON O.store_id = S.store_id
AND O.channel_id = C.channel_id
AND S.hub_id = H.hub_id
GROUP BY H.hub_state, S.store_segment, C.channel_type;

# 15-Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?

SELECT round(avg(O.order_amount),2) as media, H.hub_state, S.store_segment, C.channel_type
FROM exec04.orders O 
INNER JOIN exec04.hub H 
INNER JOIN exec04.stores S 
INNER JOIN exec04.channels C
ON O.store_id = S.store_id
AND O.channel_id = C.channel_id
AND S.hub_id = H.hub_id
GROUP BY H.hub_state, S.store_segment, C.channel_type
HAVING media > 450;

NENHUM

#  16-Qual  o  valor  total  de  pedido  (order_amount)  por  estado  do  hub  (hub_state), segmento  da  loja  (store_segment)  e  tipo  de  canal  (channel_type)?  Demonstre  os  totais intermediários eformate o resultado.

SELECT round(sum(O.order_amount),2) as soma, 
	IF(GROUPING(H.hub_state), 'Total Hub State', H.hub_state) as hub_state, 
	IF(GROUPING(S.store_segment), 'Total Segmento', S.store_segment) as store_segment,
	IF(GROUPING(C.channel_type), 'Total Tipo de Canal', C.channel_type) as channel_type
FROM exec04.orders O  
INNER JOIN exec04.hub H 
INNER JOIN exec04.stores S 
INNER JOIN exec04.channels C
ON O.store_id = S.store_id
AND O.channel_id = C.channel_id
AND S.hub_id = H.hub_id
GROUP BY H.hub_state, S.store_segment, C.channel_type WITH ROLLUP;

#  17-Quando  o  pedido  era  do  Hub  do  Rio  de  Janeiro  (hub_state),  segmento  de  loja 'FOOD',  tipo  de  canal  Marketplace  e  foi  cancelado,  qual  foi  a  média  de  valor  do  pedido (order_amount)?

SELECT round(avg(O.order_amount),2) as media, H.hub_state, S.store_segment, C.channel_type, O.order_status
FROM exec04.orders O 
INNER JOIN exec04.hub H 
INNER JOIN exec04.stores S 
INNER JOIN exec04.channels C
ON O.store_id = S.store_id
AND O.channel_id = C.channel_id
AND S.hub_id = H.hub_id
GROUP BY H.hub_state, S.store_segment, C.channel_type, O.order_status
HAVING S.store_segment = 'FOOD' AND H.hub_state = 'RJ' AND C.channel_type = 'MARKETPLACE' AND O.order_status = 'CANCELED'
ORDER BY media;

# 18-Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?

SELECT round(sum(O.order_amount),2) as total, S.store_segment, C.channel_type, H.hub_state
FROM exec04.orders O 
INNER JOIN exec04.stores S 
INNER JOIN exec04.channels C
INNER JOIN exec04.hub H
ON O.store_id = S.store_id
AND O.channel_id = C.channel_id
AND H.hub_id = S.hub_id
AND S.store_segment = 'GOOD' AND C.channel_type = 'MARKETPLACE' AND O.order_status = 'CANCELED'
GROUP BY S.store_segment, C.channel_type,  H.hub_state
HAVING  total > 100000
ORDER BY total;

#  19-Em  que  data  houve  a  maior  média  de  valor  do  pedido  (order_amount)?  Dica: Pesquise e use a função SUBSTRING().

SELECT SUBSTRING(order_moment_created, 1, 9) as data_pedido, ROUND(avg(order_amount),2) as media
FROM exec04.orders
GROUP BY data_pedido
ORDER BY media DESC;

# 20-Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)? Dica: Use a função SUBSTRING().

SELECT SUBSTRING(order_moment_created, 1, 9) as data_pedido, order_amount
FROM exec04.orders
WHERE order_amount = 0
GROUP BY data_pedido;


SELECT
	IF(GROUPING(store_latitude, 'Nulo', store_latitude)) as store_latitude
FROM exec04.stores
GROUP BY store_latitude;
