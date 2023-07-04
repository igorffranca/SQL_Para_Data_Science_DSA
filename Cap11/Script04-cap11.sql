# Script 04 - Otimização da Query 2

# Query 2
# Retorna os nomes dos clientes, cidades dos clientes, valor do pedido e vendedores que fizeram o atendimento, de clientes 
# do estado de SP cujo valor do pedido foi maior que a média de pedidos realizados às 12 hs.
SELECT nome_cliente, cidade_cliente, valor_pedido, nome_vendedor
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_VENDEDOR V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'SP'
AND valor_pedido > (SELECT AVG(valor_pedido) FROM cap05.TB_PEDIDOS WHERE HOUR(data_pedido) = 11)
ORDER BY nome_cliente;

Custo Geral: 4.23

Tempos de Execução:

Execution time: 0:00:0.00067091
Execution time: 0:00:0.00048700

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD INDEX `ix_data` (`data_pedido` ASC) VISIBLE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
DROP INDEX `ix_data`;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD COLUMN `hora_pedido` VARCHAR(2) NULL AFTER `valor_pedido`;

SELECT SUBSTRING(t2.data_pedido, 12 , 2) FROM `cap05`.`TB_PEDIDOS` t2;

SELECT t2.data_pedido, SUBSTRING(t2.data_pedido, 12 , 2) FROM `cap05`.`TB_PEDIDOS` t2;

SET SQL_SAFE_UPDATES = 0;

UPDATE `cap05`.`TB_PEDIDOS` t1, `cap05`.`TB_PEDIDOS` t2 
SET t1.hora_pedido = SUBSTRING(t2.data_pedido, 12 , 2)
WHERE t1.id_pedido = t2.id_pedido;

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD INDEX `id_hora_pedido` (`hora_pedido` ASC) VISIBLE;

SELECT nome_cliente, cidade_cliente, valor_pedido, nome_vendedor
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_VENDEDOR V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'SP'
AND valor_pedido > (SELECT AVG(valor_pedido) FROM cap05.TB_PEDIDOS WHERE hora_pedido = 11)
ORDER BY nome_cliente;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
DROP INDEX `id_hora_pedido`;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
ADD FULLTEXT INDEX `ix_hora_pedido` (`hora_pedido`) VISIBLE;

ALTER TABLE `cap05`.`TB_PEDIDOS` 
DROP INDEX `ix_hora_pedido`;

CREATE TABLE cap05.TB_REPORT AS
SELECT nome_cliente, cidade_cliente, valor_pedido, nome_vendedor
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_VENDEDOR V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'SP'
AND valor_pedido > (SELECT AVG(valor_pedido) FROM cap05.TB_PEDIDOS WHERE hora_pedido = 11)
ORDER BY nome_cliente;

DROP TABLE cap05.TB_REPORT;

CREATE TABLE cap05.TB_REPORT (id INT AUTO_INCREMENT PRIMARY KEY) AS
SELECT nome_cliente, cidade_cliente, valor_pedido, nome_vendedor
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_VENDEDOR V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND estado_cliente = 'SP'
AND valor_pedido > (SELECT AVG(valor_pedido) FROM cap05.TB_PEDIDOS WHERE hora_pedido = 11)
ORDER BY nome_cliente;

SELECT * FROM cap05.TB_REPORT;

Custo Geral: 0.45

Tempos de Execução:

Execution time: 0:00:0.00027895
Execution time: 0:00:0.00019100


Resumo:

-- Antes da Otimização:

Custo Geral: 4.23

Tempos de Execução:

Execution time: 0:00:0.00067091
Execution time: 0:00:0.00048700

-- Depois da Otimização:

Custo Geral: 0.45

Tempos de Execução:

Execution time: 0:00:0.00027895
Execution time: 0:00:0.00019100









