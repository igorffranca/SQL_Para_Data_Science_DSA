# Criação de Triggers

DROP TRIGGER IF EXISTS cap10.upd_check;

DELIMITER //
CREATE TRIGGER cap10.upd_check BEFORE UPDATE ON cap10.TB_CLIENTE
FOR EACH ROW
BEGIN
    IF NEW.limite_credito < 0 THEN
        SET NEW.limite_credito = 0;
    ELSEIF NEW.limite_credito > 100000 THEN
        SET NEW.limite_credito = 100000;
    END IF;
END
//
DELIMITER ;



UPDATE cap10.TB_CLIENTE
SET limite_credito = -10
WHERE sk_cliente = 8;

UPDATE cap10.TB_CLIENTE
SET limite_credito = 120000
WHERE sk_cliente = 9;


ALTER TABLE cap10.TB_CLIENTE 
ADD COLUMN data_cadastro DATETIME NULL AFTER limite_credito,
ADD COLUMN cadastrado_por VARCHAR(45) NULL AFTER data_cadastro,
ADD COLUMN atualizado_por VARCHAR(45) NULL AFTER cadastrado_por;


DROP TRIGGER IF EXISTS cap10.insert_check;

DELIMITER //
CREATE TRIGGER cap10.insert_check BEFORE INSERT on cap10.TB_CLIENTE FOR EACH ROW
BEGIN
    DECLARE vUser varchar(50);

    -- Usuário que realizou o INSERT
    SELECT USER() INTO vUser;

    -- Obtém a data do sistema e registra na coluna data_cadastro 
    SET NEW.data_cadastro = SYSDATE();

    -- Registra na tabela o usuário que fez o INSERT
    SET NEW.cadastrado_por = vUser;
END
// 
DELIMITER ;


INSERT INTO cap10.TB_CLIENTE (NK_ID_CLIENTE, NM_CLIENTE, NM_CIDADE_CLIENTE, BY_ACEITA_CAMPANHA, DESC_CEP) 
VALUES ('S10984EDCF10101', 'Diana Ross', 'Rio de Janeiro', '1', '72132901');

INSERT INTO cap10.TB_CLIENTE (NK_ID_CLIENTE, NM_CLIENTE, NM_CIDADE_CLIENTE, BY_ACEITA_CAMPANHA, DESC_CEP) 
VALUES ('T10984EDCF10101', 'Tom Petty', 'Natal', '1', '72132902');


CREATE TABLE cap10.TB_AUDITORIA 
(sk_cliente INTEGER, 
 nk_id_cliente VARCHAR(20),
 deleted_date DATE, 
 deleted_by VARCHAR(20));


DROP TRIGGER IF EXISTS cap10.delete_check;

DELIMITER //
CREATE TRIGGER cap10.delete_check AFTER DELETE ON cap10.TB_CLIENTE FOR EACH ROW
BEGIN

    DECLARE vUser VARCHAR(50);

    SELECT USER() into vUser;

    INSERT INTO cap10.TB_AUDITORIA (sk_cliente, nk_id_cliente, deleted_date, deleted_by)
    VALUES (OLD.sk_cliente, OLD.nk_id_cliente, SYSDATE(), vUser);

END; 
//
DELIMITER ; 


DELETE FROM cap10.TB_CLIENTE WHERE sk_cliente = 13;





