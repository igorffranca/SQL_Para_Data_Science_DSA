# Retornar id do pedido e nome do cliente
# Inner Join

SELECT P.id_pedido, C.nome_cliente
FROM cap04.tb_clientes as C
INNER JOIN cap04.tb_pedidos as P
ON C.id_cliente = P.id_cliente;

SELECT P.id_pedido, C.nome_cliente
FROM cap04.tb_clientes as C, cap04.tb_pedidos as P
WHERE P.id_cliente = C.id_cliente;

SELECT P.id_pedido, C.nome_cliente
FROM cap04.tb_clientes as C
INNER JOIN cap04.tb_pedidos as P
USING (id_cliente);

SELECT P.id_pedido, C.nome_cliente
FROM cap04.tb_clientes as C
INNER JOIN cap04.tb_pedidos as P
USING (id_cliente)
WHERE C.nome_cliente LIKE 'Ro%'
ORDER BY P.id_pedido DESC;


# Retornar id do pedido, nome do cliente e nome do vendedor
# Inner Join com 3 tabelas

SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM cap04.tb_pedidos as P
INNER JOIN cap04.tb_clientes as C
ON P.id_cliente = C.id_cliente
INNER JOIN cap04.tb_vendedor as V
ON P.id_vendedor = V.id_vendedor;

SELECT P.id_pedido, C.nome_cliente, V.nome_vendedor
FROM cap04.tb_pedidos as P, cap04.tb_clientes as C, cap04.tb_vendedor as V
WHERE P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor;


# Retornar todos os clientes, com ou sem pedido associado
# LEFT JOIN

SELECT P.id_pedido, C.nome_cliente
FROM cap04.tb_clientes as C
LEFT JOIN cap04.tb_pedidos as P
ON C.id_cliente = P.id_cliente
ORDER BY P.id_pedido;

#RIGHT JOIN

SELECT P.id_pedido, C.nome_cliente
FROM cap04.tb_pedidos as P
RIGHT JOIN cap04.tb_clientes as C
ON C.id_cliente = P.id_cliente
ORDER BY P.id_pedido;

# Retornar a data do pedido, o nome do cliente, todos os vendedores, com ou sem pedido associado
# e ordernar o resultado pelo nome do cliente

SELECT 
	CASE
		WHEN P.data_pedido IS NULL THEN 'Sem Pedido'
        ELSE P.data_pedido
	END as data_pedido, 
	CASE
		WHEN C.nome_cliente IS NULL THEN 'Sem Pedido'
        ELSE C.nome_cliente
	END as nome_cliente, V.nome_vendedor
FROM cap04.tb_pedidos as P
JOIN cap04.tb_clientes as C
ON P.id_cliente = C.id_cliente
RIGHT JOIN cap04.tb_vendedor as V
ON V.id_vendedor = P.id_vendedor
ORDER BY C.nome_cliente;


# Vamos inserir um registro na tabela de pedidos que será "órfão" e queremos retornar todos os dados de ambas as tabelas mesmo sem correspondência
INSERT INTO `cap04`.`TB_PEDIDOS` (`id_pedido`, `id_cliente`, `id_vendedor`, `data_pedido`, `id_entrega`)
VALUES (1004, 10, 6, now(), 23);

SELECT 
	CASE
		WHEN C.nome_cliente IS NULL THEN 'Cliente NÃO Cadastrado'
		ELSE C.nome_cliente
	END as nome_cliente,
	CASE
		WHEN P.id_pedido is NULL THEN 'Pedido NÃO Cadastrado'
		ELSE P.id_pedido
	END as id_pedido
FROM cap04.tb_clientes as C
LEFT JOIN cap04.tb_pedidos as P
ON C.id_cliente = P.id_cliente
UNION
SELECT 
	CASE
		WHEN C.nome_cliente IS NULL THEN 'Cliente NÃO Cadastrado'
		ELSE C.nome_cliente
	END as nome_cliente,
	CASE
		WHEN P.id_pedido is NULL THEN 'Pedido NÃO Cadastrado'
		ELSE P.id_pedido
	END as id_pedido
FROM cap04.tb_clientes as C
RIGHT JOIN cap04.tb_pedidos as P
ON C.id_cliente = P.id_cliente;

# Inserir mais um registro na tabela de clientes
INSERT INTO `cap04`.`TB_CLIENTES` (`id_cliente`, `nome_cliente`, `endereco_cliente`, `cidade_cliente`, `estado_cliente`)
VALUES (6, "Madona", "Rua 45", "Campos", "RJ");

SELECT A.nome_cliente, A.cidade_cliente, A.estado_cliente
FROM cap04.tb_clientes A, cap04.tb_clientes B
WHERE A.id_cliente <> B.id_cliente
AND A.estado_cliente = B.estado_cliente
AND A.cidade_cliente = B.cidade_cliente;


# CROSS JOIN

SELECT C.nome_cliente, P.id_pedido
FROM cap04.TB_CLIENTES as C
CROSS JOIN cap04.tb_pedidos as P;

