# Criação de View

SELECT * 
FROM cap10.TB_VENDA
WHERE valor_venda > 500;

CREATE VIEW cap10.VW_VENDAS_MAIOR_500 AS
SELECT * 
FROM cap10.TB_VENDA
WHERE valor_venda > 500;

SELECT * FROM cap10.VW_VENDAS_MAIOR_500;

SELECT nm_cliente, nm_cidade_cliente, nm_localidade, nm_marca_produto, nr_dia, nr_mes, valor_venda
FROM cap10.TB_VENDA F, 
     cap10.TB_CLIENTE C, 
     cap10.TB_LOCALIDADE L, 
     cap10.TB_PRODUTO P,
     cap10.TB_TEMPO T
WHERE C.sk_cliente = F.sk_cliente
  AND L.sk_localidade = F.sk_localidade
  AND P.sk_produto = F.sk_produto
  AND T.sk_data = F.sk_data
  AND valor_venda > 500;

CREATE OR REPLACE VIEW cap10.VW_VENDAS_MAIOR_500 AS
SELECT nm_cliente, nm_cidade_cliente, nm_localidade, nm_marca_produto, nr_dia, nr_mes, valor_venda
FROM cap10.TB_VENDA F, 
     cap10.TB_CLIENTE C, 
     cap10.TB_LOCALIDADE L, 
     cap10.TB_PRODUTO P,
     cap10.TB_TEMPO T
WHERE C.sk_cliente = F.sk_cliente
  AND L.sk_localidade = F.sk_localidade
  AND P.sk_produto = F.sk_produto
  AND T.sk_data = F.sk_data
  AND valor_venda > 500;

SELECT * FROM cap10.VW_VENDAS_MAIOR_500;


