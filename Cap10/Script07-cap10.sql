# Criação de Materialized View (workaround no MySQL)

CREATE TABLE cap10.TB_VENDAS (
   id INT PRIMARY KEY AUTO_INCREMENT,
   id_vendedor INT,
   data_venda date,
   valor_venda INT
   );

INSERT INTO cap10.TB_VENDAS (id_vendedor, data_venda, valor_venda) 
VALUES (1001, "2022-01-05", 180), 
       (1002, "2022-01-05", 760), 
       (1003, "2021-01-05", 950), 
       (1004, "2022-01-05", 3200), 
       (1005, "2022-01-05", 2780);

SELECT * FROM cap10.TB_VENDAS;

SELECT id_vendedor, data_venda, SUM(valor_venda * 0.10) as comissao 
FROM cap10.TB_VENDAS 
WHERE data_venda < CURRENT_DATE 
GROUP BY id_vendedor, data_venda
ORDER BY id_vendedor;

CREATE TABLE cap10.VW_MATERIALIZED (
SELECT id_vendedor, data_venda, SUM(valor_venda * 0.10) as comissao 
FROM cap10.TB_VENDAS 
WHERE data_venda < CURRENT_DATE 
GROUP BY id_vendedor, data_venda
ORDER BY id_vendedor);

SELECT * FROM cap10.VW_MATERIALIZED;

INSERT INTO cap10.TB_VENDAS (id_vendedor, data_venda, valor_venda) 
VALUES (1004, "2022-01-05", 450), 
       (1002, "2022-01-05", 520), 
       (1007, "2021-01-05", 640), 
       (1005, "2022-01-05", 1200), 
       (1008, "2022-01-05", 1700);

SELECT * FROM cap10.VW_MATERIALIZED;

DELIMITER //
CREATE PROCEDURE cap10.SP_VW_MATERIALIZED(OUT dev INT)
BEGIN
    TRUNCATE TABLE cap10.VW_MATERIALIZED;
    INSERT INTO cap10.VW_MATERIALIZED
        SELECT id_vendedor, data_venda, SUM(valor_venda * 0.10) as comissao
        FROM cap10.TB_VENDAS
        WHERE data_venda 
        GROUP BY id_vendedor, data_venda;
END
//
DELIMITER ;

CALL cap10.SP_VW_MATERIALIZED(@dev);

SELECT * FROM cap10.VW_MATERIALIZED;



