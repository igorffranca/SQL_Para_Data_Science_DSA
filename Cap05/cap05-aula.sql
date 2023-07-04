# Media do valor dos pedidos por cidade com INNER JOIN

SELECT 
	CASE
		WHEN round(avg(P.valor_pedido),2) IS NULL THEN 0
		ELSE round(avg(P.valor_pedido),2)
	END as media, C.cidade_cliente
FROM cap05.tb_pedidos P RIGHT JOIN cap05.tb_clientes C 
ON P.id_cliente = C.id_cliente
GROUP BY C.cidade_cliente
ORDER BY media DESC;

# Soma (total) do valor dos pedidos

SELECT SUM(P.valor_pedido) AS total, C.cidade_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C 
WHERE P.id_cliente = C.id_cliente
GROUP BY C.cidade_cliente
ORDER BY total DESC;

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (12, "Bill Gates", "Rua 14", "Santos", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (13, "Jeff Bezos", "Rua 29", "Osasco", "SP");

#insere mais 3 pedidos

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1016, 11, 5, now(), 27, 234.09);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1017, 12, 4, now(), 22, 678.30);

INSERT INTO `cap05`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`, `valor_pedido`)
VALUES (1018, 13, 4, now(), 22, 978.30);

# Soma (total) do valor dos pedidos por cidade e estado

SELECT SUM(P.valor_pedido) AS total, C.cidade_cliente, C.estado_cliente
FROM cap05.tb_pedidos P, cap05.tb_clientes C 
WHERE P.id_cliente = C.id_cliente
GROUP BY C.cidade_cliente, C.estado_cliente
ORDER BY C.estado_cliente DESC;


INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (14, "Melinda Gates", "Rua 14", "Barueri", "SP");

INSERT INTO `cap05`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (15, "Barack Obama", "Rua 29", "Barueri", "SP");

# Exercicio

# Soma(total) do valor dos pedidos por cidade e estado com RIGHT JOIN e CASE

SELECT CASE 
		WHEN SUM(P.valor_pedido) IS NULL THEN 0 
		ELSE SUM(P.valor_pedido) END AS total, C.cidade_cliente, C.estado_cliente
FROM cap05.tb_pedidos P RIGHT JOIN cap05.tb_clientes C
ON P.id_cliente = C.id_cliente
GROUP BY C.cidade_cliente, C.estado_cliente
ORDER BY total DESC;

# Suponha que a comissao de cada vendedor seja de 10%, quanto cada vendedor ganhou nas vendas no
# estado do Ceara?
# Retorne 0 se nao houve ganho de comissao

SELECT 
	CASE
		WHEN round(sum(P.valor_pedido*0.1),2) IS NULL THEN 0
        ELSE round(sum(P.valor_pedido*0.1),2)
	END as comissao, V.nome_vendedor,
    CASE
		WHEN C.estado_cliente IS NULL THEN 'Não atua no CE'
        ELSE C.estado_cliente
	END as estado_cliente
FROM cap05.tb_pedidos P 
INNER JOIN cap05.tb_clientes C
RIGHT JOIN cap05.tb_vendedor V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
AND C.estado_cliente = 'CE'
GROUP BY V.nome_vendedor, C.estado_cliente
ORDER BY C.estado_cliente;

# Maior valor
SELECT max(valor_pedido) as maximo
FROM cap05.tb_pedidos;

# Menos valor
SELECT min(valor_pedido) as maximo
FROM cap05.tb_pedidos;

#Numero de pedidos
SELECT COUNT(DISTINCT id_cliente) FROM cap05.tb_pedidos;

# Numero de pedidos de clientes do CE
SELECT C.nome_cliente, C.cidade_cliente, COUNT(C.id_cliente) as total_pedidos
FROM cap05.tb_pedidos P, cap05.tb_clientes C 
WHERE C.id_cliente = P.id_cliente
AND C.estado_cliente = 'CE'
GROUP BY C.nome_cliente, C.cidade_cliente;

# Algum vendedor participou de vendas cujo valor pedido tenha sido superior a 600 no estado de SP?
SELECT V.nome_vendedor, C.estado_cliente AS ESTADO, P.valor_pedido AS VALOR
FROM cap05.tb_pedidos P, cap05.tb_clientes C, cap05.tb_vendedor V
WHERE C.id_cliente = P.id_cliente
AND V.id_vendedor = P.id_vendedor
AND C.estado_cliente = 'SP'
AND P.valor_pedido > 600
ORDER BY P.valor_pedido;

# Algum vendedor participou de vendas em que a media do valor_pedido por estado do cliente foi superior a 800?
SELECT V.nome_vendedor, C.estado_cliente AS ESTADO, round(avg(P.valor_pedido),2) AS MEDIA
FROM cap05.tb_pedidos P, cap05.tb_clientes C, cap05.tb_vendedor V
WHERE C.id_cliente = P.id_cliente
AND V.id_vendedor = P.id_vendedor
GROUP BY C.estado_cliente, V.nome_vendedor
HAVING media > 800
ORDER BY V.nome_vendedor;

# Qual estado teve mais de 5 pedidos?

SELECT C.estado_cliente, count(P.id_pedido) as total_pedidos
FROM cap05.tb_pedidos P INNER JOIN cap05.tb_clientes C
ON C.id_cliente = P.id_cliente
GROUP BY C.estado_cliente
HAVING total_pedidos > 5;

#Faturamento total por ano

SELECT sum(faturamento) as faturamento_total, ano
FROM cap05.tb_vendas
GROUP BY ano WITH ROLLUP
HAVING faturamento_total > 13000
ORDER BY ano;