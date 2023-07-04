# Criação de Functions

# As funções são normalmente usadas para cálculos, enquanto os procedimentos armazenados são normalmente 
# usados para executar a lógica de negócios.

CREATE PROCEDURE proc_name ([parametros])
BEGIN
corpo_da_procedure
END


CREATE FUNCTION func_name ([parametros])
RETURNS data_type      
BEGIN
corpo_da_funcao
END


# Uma função determinística sempre retorna o mesmo resultado com os mesmos parâmetros de entrada no mesmo estado 
# do banco de dados. Por exemplo: POW, SUBSTR(), UCASE(). 
# Uma função não determinística não retorna necessariamente sempre o mesmo resultado com os mesmos parâmetros 
# de entrada no mesmo estado do banco de dados.


DELIMITER //

CREATE FUNCTION func_name ( numero INT )
RETURNS INT
DETERMINISTIC
BEGIN

   

END 
//
DELIMITER ;



ALTER TABLE cap10.TB_CLIENTE 
DROP COLUMN limite_credito;


ALTER TABLE cap10.TB_CLIENTE 
ADD COLUMN limite_credito INT NULL AFTER desc_cep;


UPDATE cap10.TB_CLIENTE
SET limite_credito = 1000
WHERE sk_cliente = 1;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 0
WHERE sk_cliente = 3;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 2500
WHERE sk_cliente = 4;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 15000
WHERE sk_cliente = 6;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 60000
WHERE sk_cliente = 7;



DELIMITER //

CREATE FUNCTION cap10.FN_NIVEL_CLIENTE(credito DECIMAL(10,2)) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE nivel_cliente VARCHAR(20);

    IF credito > 50000 THEN
        SET nivel_cliente = 'PLATINUM';
    ELSEIF (credito <= 50000 AND credito > 10000) THEN
        SET nivel_cliente = 'GOLD';
    ELSEIF credito <= 10000 THEN
        SET nivel_cliente = 'SILVER';
    END IF;
   
    RETURN (nivel_cliente);
END
//
DELIMITER ;


SELECT nm_cliente, 
       cap10.FN_NIVEL_CLIENTE(limite_credito) AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;


SELECT nm_cliente, 
       limite_credito,
       cap10.FN_NIVEL_CLIENTE(limite_credito) AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;


SELECT nm_cliente, 
       COALESCE(cap10.FN_NIVEL_CLIENTE(limite_credito), "Não Definido") AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;


CREATE VIEW cap10.VW_NIVEL_CLIENTE AS
SELECT nm_cliente, 
       COALESCE(cap10.FN_NIVEL_CLIENTE(limite_credito), "Não Definido") AS status
FROM cap10.TB_CLIENTE
ORDER BY nm_cliente;


SELECT * FROM cap10.vw_nivel_cliente;


DELIMITER //

CREATE PROCEDURE cap10.SP_GET_NIVEL_CLIENTE(
    IN  id_cliente INT,  
    OUT nivel_cliente VARCHAR(20)
)
BEGIN

    DECLARE credito DEC(10,2) DEFAULT 0;
    
    -- Extrai o limite de crédito do cliente
    SELECT limite_credito 
    INTO credito
    FROM cap10.TB_CLIENTE
    WHERE sk_cliente = id_cliente;
    
    -- Executa a função
    SET nivel_cliente = cap10.FN_NIVEL_CLIENTE(credito);
END
//
DELIMITER ;


CALL cap10.SP_GET_NIVEL_CLIENTE(7, @nivel_cliente);
SELECT @nivel_cliente;

CALL cap10.SP_GET_NIVEL_CLIENTE(4, @nivel_cliente);
SELECT @nivel_cliente;


CREATE VIEW cap10.VW_CLIENTE AS
SELECT *
FROM cap10.TB_CLIENTE
WHERE limite_credito IS NOT NULL
ORDER BY nm_cliente;


DELIMITER //
CREATE PROCEDURE cap10.SP_GET_NIVEL_CLIENTE2(
    IN  id_cliente INT,  
    OUT nivel_cliente VARCHAR(20)
)
BEGIN

    DECLARE credito DEC(10,2) DEFAULT 0;
    
    -- Extrai o limite de crédito do cliente
    SELECT limite_credito 
    INTO credito
    FROM cap10.VW_CLIENTE 
    WHERE sk_cliente = id_cliente;
    
    -- Executa a função
    SET nivel_cliente = cap10.FN_NIVEL_CLIENTE(credito);
END
//
DELIMITER ;


CALL cap10.SP_GET_NIVEL_CLIENTE2(7, @nivel_cliente);
SELECT @nivel_cliente;

CALL cap10.SP_GET_NIVEL_CLIENTE2(4, @nivel_cliente);
SELECT @nivel_cliente;






