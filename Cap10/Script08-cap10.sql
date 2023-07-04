# Criação de Stored Procedure

DELIMITER //
CREATE PROCEDURE cap10.NOME_SP()
BEGIN

...

END 
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES1()
BEGIN
    SELECT nm_cliente, nm_cidade_cliente, ROUND(AVG(valor_venda),2) AS media_valor_venda
    FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B
    WHERE B.sk_cliente = A.sk_cliente
    GROUP BY nm_cliente, nm_cidade_cliente;
END 
//
DELIMITER ;


CALL cap10.SP_EXTRAI_CLIENTES1();


DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES2(IN media int)
BEGIN
    SELECT nm_cliente, nm_cidade_cliente, ROUND(AVG(valor_venda),2) AS media_valor_venda
    FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B
    WHERE B.sk_cliente = A.sk_cliente
    GROUP BY nm_cliente, nm_cidade_cliente
    HAVING media_valor_venda > media;
END 
//
DELIMITER ;


CALL cap10.SP_EXTRAI_CLIENTES2(500);
CALL cap10.SP_EXTRAI_CLIENTES2(800);


DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES3(OUT Contagem_Clientes int)
BEGIN
    SELECT COUNT(*)
    INTO Contagem_Clientes
    FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B
    WHERE B.sk_cliente = A.sk_cliente
    AND valor_venda > 500;
END 
//
DELIMITER ;


CALL cap10.SP_EXTRAI_CLIENTES3(@contagem);
SELECT @contagem AS CLIENTES


SELECT nk_id_cliente AS id_cliente,
       nm_cliente AS nome_cliente, 
       nm_regiao_localidade AS regiao_venda, 
       nm_marca_produto AS marca_produto,
       ROUND(AVG(valor_venda),2) AS media_valor_venda
FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B, cap10.TB_LOCALIDADE C, cap10.TB_PRODUTO D
WHERE B.sk_cliente = A.sk_cliente
  AND B.sk_localidade = C.sk_localidade
  AND B.sk_produto = D.sk_produto
  AND nm_marca_produto IN ("LG", "Apple", "Canon", "Samsung")
  AND nm_regiao_localidade LIKE "S%" OR "N%"
GROUP BY nk_id_cliente, nm_cliente, nm_regiao_localidade, nm_marca_produto
HAVING media_valor_venda > 500
   AND nk_id_cliente = "A10984EDCF10092";

SELECT ROUND(AVG(valor_venda),2) AS media_valor_venda
FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B, cap10.TB_LOCALIDADE C, cap10.TB_PRODUTO D
WHERE B.sk_cliente = A.sk_cliente
  AND B.sk_localidade = C.sk_localidade
  AND B.sk_produto = D.sk_produto
  AND nm_marca_produto IN ("LG", "Apple", "Canon", "Samsung")
  AND nm_regiao_localidade LIKE "S%" OR "N%"
GROUP BY nk_id_cliente, nm_cliente, nm_regiao_localidade, nm_marca_produto
HAVING media_valor_venda > 500
   AND nk_id_cliente = "A10984EDCF10092";


DROP PROCEDURE cap10.SP_EXTRAI_CLIENTES4;

DELIMITER //
CREATE PROCEDURE cap10.SP_EXTRAI_CLIENTES4(IN cliente VARCHAR(20), OUT desconto VARCHAR(30))
BEGIN

    DECLARE MediaValorVenda INT DEFAULT 0;

    SELECT ROUND(AVG(valor_venda),2) AS media_valor_venda
    INTO MediaValorVenda
    FROM cap10.TB_CLIENTE A, cap10.TB_VENDA B, cap10.TB_LOCALIDADE C, cap10.TB_PRODUTO D
    WHERE B.sk_cliente = A.sk_cliente
      AND B.sk_localidade = C.sk_localidade
      AND B.sk_produto = D.sk_produto
      AND nm_marca_produto IN ("LG", "Apple", "Canon", "Samsung")
      AND nm_regiao_localidade LIKE "S%" OR "N%"
    GROUP BY nk_id_cliente, nm_cliente, nm_regiao_localidade, nm_marca_produto
    HAVING media_valor_venda > 500
       AND nk_id_cliente = cliente;

    IF MediaValorVenda >= 500 AND MediaValorVenda <= 600 THEN
        SET desconto = "Plano Básico de Desconto";
    ELSEIF MediaValorVenda > 600 AND MediaValorVenda <= 800 THEN
        SET desconto = "Plano Premium de Desconto";
    ELSE
        SET desconto = "Plano Ouro de Desconto";
    END IF;
END 
//
DELIMITER ;


CALL cap10.SP_EXTRAI_CLIENTES4("A10984EDCF10092", @plano);
SELECT @plano AS CLIENTES;

CALL cap10.SP_EXTRAI_CLIENTES4("D10984EDCF10095", @plano);
SELECT @plano AS CLIENTES;

CALL cap10.SP_EXTRAI_CLIENTES4("G10984EDCF10098", @plano);
SELECT @plano AS CLIENTES;





