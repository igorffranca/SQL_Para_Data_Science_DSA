

SELECT * FROM cap11.TB_CLIENTES;

SELECT * FROM cap11.TB_CLIENTES WHERE id = 1;

FLUSH STATUS;

SELECT * FROM cap11.TB_CLIENTES WHERE id = 1;

SHOW SESSION STATUS LIKE "Handler%";

SELECT * FROM cap11.TB_CLIENTES WHERE nome = 'Bob Silva';

SELECT * FROM cap11.TB_CLIENTES WHERE nome = 'Bob Silva' OR nome = 'Zinedine Zidane';

SELECT cap11.TB_CLIENTES.nome, cap11.TB_PEDIDOS.data_pedido, cap11.TB_PEDIDOS.valor
FROM cap11.TB_CLIENTES
JOIN cap11.TB_PEDIDOS ON (cap11.TB_CLIENTES.id = cap11.TB_PEDIDOS.id_cliente)
WHERE cap11.TB_CLIENTES.nome = 'Zico Miranda';

SELECT id as ID FROM cap11.TB_CLIENTES  
UNION ALL  
SELECT id_cliente as ID FROM cap11.TB_PEDIDOS; 

SELECT id AS ID FROM cap11.TB_CLIENTES  
UNION ALL  
SELECT id_cliente AS ID FROM cap11.TB_PEDIDOS
ORDER BY ID;

SELECT
	IF(GROUPING(ano), 'Total de Todos os Anos', ano) AS ano,
	IF(GROUPING(pais), 'Total de Todos os Países', pais) AS pais,
	IF(GROUPING(produto), 'Total de Todos os Produtos', produto) AS produto,
	SUM(faturamento) faturamento 
FROM cap05.TB_VENDAS
GROUP BY ano, pais, produto WITH ROLLUP;

SELECT estado_cliente, nome_vendedor, CEILING(AVG(valor_pedido)) AS media
FROM cap05.TB_PEDIDOS P INNER JOIN cap05.TB_CLIENTES C INNER JOIN cap05.TB_VENDEDOR V
ON P.id_cliente = C.id_cliente
AND P.id_vendedor = V.id_vendedor
GROUP BY estado_cliente, nome_vendedor
HAVING media > 800
ORDER BY nome_vendedor;

SELECT COALESCE(B.regional_office, "Total") AS "Escritório Regional",
       COALESCE(A.sales_agent, "Total") AS "Agente de Vendas",
       SUM(A.close_value) AS Total
FROM cap08.TB_PIPELINE_VENDAS AS A, cap08.TB_VENDEDORES AS B
WHERE A.sales_agent = B.sales_agent
AND A.deal_stage = "Won"
GROUP BY B.regional_office, A.sales_agent WITH ROLLUP;



